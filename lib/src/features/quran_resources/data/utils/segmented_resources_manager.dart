import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/core/api/apis_urls.dart";
import "package:al_quran_v3/src/core/utils/encode_decode.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/utils/get_segments_supported_reciters.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

class SegmentedResourcesManager {
  static const String _selectedBox = "selected_segmented_recitation_box";
  static const String _allBoxKey = "segmented_recitation_boxes";
  static const String _metaKey = "meta_data";
  static Box? _segmentsBox;
  static final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  static Map segmentsCache = {};

  static Future<void> init() async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    String? selectedBox = getSelectedDataBoxName();
    if (selectedBox != null && await Hive.boxExists(selectedBox)) {
      await changeSelectedBox(selectedBox);
    }
  }

  static bool isBoxLoadedForUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (_segmentsBox == null || !_segmentsBox!.isOpen) return false;
    return _segmentsBox!.name == praseStringToBoxName(url);
  }

  static List? getAyahSegments(String ayahKey) {
    if (_segmentsBox == null || !_segmentsBox!.isOpen) return null;
    final data = segmentsCache[ayahKey];
    if (data != null) {
      if (data == -1) return null;
      if (data is List) return data;
    }
    dynamic audioTimeStamp =
        data ?? _segmentsBox?.get(ayahKey, defaultValue: null);

    if (!segmentsCache.containsKey(ayahKey)) {
      segmentsCache[ayahKey] = audioTimeStamp ?? -1;
    }

    List<List>? segments;
    if (audioTimeStamp != null &&
        audioTimeStamp is Map &&
        audioTimeStamp["segments"] is List) {
      segments = List<List>.from(
        (audioTimeStamp["segments"] as List).map(
          (e) => e is List ? e : [],
        ),
      );
    }
    return segments;
  }

  static ReciterInfoModel? getOpenSegmentsReciter() {
    if (_segmentsBox == null || !_segmentsBox!.isOpen) {
      String? selectedBox = getSelectedDataBoxName();
      if (selectedBox != null && Hive.isBoxOpen(selectedBox)) {
        _segmentsBox = Hive.box(selectedBox);
      }
    }
    if (_segmentsBox == null || !_segmentsBox!.isOpen) {
      return null;
    }

    final rawMeta = _segmentsBox?.get(_metaKey, defaultValue: null);
    if (rawMeta != null) {
      try {
        if (rawMeta is Map) {
          return ReciterInfoModel.fromJson(Map<String, dynamic>.from(rawMeta));
        } else if (rawMeta is String) {
          final decoded = jsonDecode(rawMeta);
          if (decoded is Map) {
            return ReciterInfoModel.fromJson(
              Map<String, dynamic>.from(decoded),
            );
          }
        }
      } catch (e) {
        log(
          "Error parsing open segments reciter metadata: $e",
          name: "SegmentedResourcesManager",
        );
      }
    }

    // Fallback: match from getSegmentsSupportedReciters based on box name
    String? currentBoxName = _segmentsBox?.name ?? getSelectedDataBoxName();
    if (currentBoxName != null) {
      try {
        final supported = getSegmentsSupportedReciters();
        return supported.cast<ReciterInfoModel?>().firstWhere(
          (reciter) =>
              reciter != null &&
              reciter.segmentsUrl != null &&
              praseStringToBoxName(reciter.segmentsUrl!) == currentBoxName,
          orElse: () => null,
        );
      } catch (_) {}
    }

    return null;
  }

  static Future<void> closeAllBoxes() async {
    List<String> boxesNames = getDownloadedBoxesNames();
    for (String boxName in boxesNames) {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
    }
    _segmentsBox = null;
    segmentsCache.clear();
  }

  /// Clears active in-memory & selected segment box (used when switching to a
  /// reciter without word segmentation so stale timings never bleed over).
  static Future<void> clearActiveBox() async {
    segmentsCache.clear();
    if (_segmentsBox != null && _segmentsBox!.isOpen) {
      try {
        await _segmentsBox!.close();
      } catch (_) {}
    }
    _segmentsBox = null;
    if (Hive.isBoxOpen("user")) {
      await Hive.box("user").delete(_selectedBox);
    }
  }

  static String? getSelectedDataBoxName() {
    if (!Hive.isBoxOpen("user")) return null;
    return Hive.box("user").get(_selectedBox, defaultValue: null);
  }

  static Future<void> saveSelectedBox(String boxName) async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    await Hive.box("user").put(_selectedBox, boxName);
  }

  static List<String> getDownloadedBoxesNames() {
    if (!Hive.isBoxOpen("user")) return [];
    return List<String>.from(
      Hive.box("user").get(_allBoxKey, defaultValue: []),
    );
  }

  static Future<void> changeSelectedBox(String toOpenBox) async {
    // Close other opened boxes
    List<String> boxesNames = getDownloadedBoxesNames();
    for (String boxName in boxesNames) {
      if (boxName != toOpenBox && Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
    }
    // Save selected box to user DB
    await saveSelectedBox(toOpenBox);
    // Open selected box
    if (Hive.isBoxOpen(toOpenBox)) {
      _segmentsBox = Hive.box(toOpenBox);
    } else {
      _segmentsBox = await Hive.openBox(toOpenBox);
    }
    segmentsCache.clear();
  }

  static Future<bool> downloadResources(
    BuildContext? context,
    String url, {
    ReciterInfoModel? reciterMeta,
    void Function(double? percentage, String processName)? onProgress,
  }) async {
    if (url.trim().isEmpty) return false;

    final String rawUrl = url.trim();
    final String boxName = praseStringToBoxName(rawUrl);

    if (await isAlreadyDownloaded(rawUrl)) {
      await changeSelectedBox(boxName);
      return true;
    }

    final String fullUrl =
        rawUrl.startsWith("http") ? rawUrl : "${ApisUrls.base}$rawUrl";

    try {
      final response = await _dio.get(fullUrl);
      if (response.statusCode == 200 && response.data != null) {
        const processMsg = "Processing Audio Segments";
        onProgress?.call(null, processMsg);

        final Map segmentsInfo = await compute(
          (message) => jsonDecode(decodeBZip2String(message)),
          response.data,
        );

        _segmentsBox = await Hive.openBox(boxName);
        for (final ayahKey in segmentsInfo.keys) {
          await _segmentsBox!.put(ayahKey, segmentsInfo[ayahKey]);
        }

        // Save reciter metadata
        ReciterInfoModel? resolvedMeta =
            reciterMeta ??
            getSegmentsSupportedReciters()
                .cast<ReciterInfoModel?>()
                .firstWhere(
                  (r) =>
                      r != null &&
                      r.segmentsUrl != null &&
                      (r.segmentsUrl == rawUrl ||
                          rawUrl.endsWith(r.segmentsUrl!) ||
                          praseStringToBoxName(r.segmentsUrl!) == boxName),
                  orElse: () => null,
                );
        if (resolvedMeta != null) {
          await _segmentsBox?.put(_metaKey, resolvedMeta.toJson());
        }

        // Track downloaded box
        List<String> downloaded = getDownloadedBoxesNames();
        if (!downloaded.contains(boxName)) {
          downloaded.add(boxName);
          await Hive.box("user").put(_allBoxKey, downloaded);
        }

        await changeSelectedBox(boxName);
        return true;
      }
      return false;
    } catch (e, s) {
      log(
        "Failed to download/decode audio segments ($fullUrl): $e",
        stackTrace: s,
        name: "SegmentedResourcesManager",
      );
      return false;
    }
  }

  static Future<bool> isAlreadyDownloaded(String url) async {
    if (url.trim().isEmpty) return false;
    return await Hive.boxExists(praseStringToBoxName(url));
  }

  static String praseStringToBoxName(String url) {
    final Uri uri = Uri.parse(url);
    final last = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : url;
    String boxName = last.replaceAll(RegExp(r"[^a-zA-Z0-9]"), "_");
    return boxName.isNotEmpty ? boxName : "default_box_name";
  }
}
