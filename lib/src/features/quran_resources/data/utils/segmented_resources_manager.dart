import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/core/api/apis_urls.dart";
import "package:al_quran_v3/src/features/audio/data/utils/get_segments_supported_reciters.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/core/utils/encode_decode.dart";
import "package:dartx/dartx.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

class SegmentedResourcesManager {
  static final String _selectedBox = "selected_segmented_recitation_box";
  static final String _allBoxKey = "segmented_recitation_boxes";
  static final String _metaKey = "meta_data";
  static Box? _segmentsBox;

  static Future<void> init() async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    String? selectedBox = getSelectedDataBoxName();
    if (selectedBox != null) {
      await changeSelectedBox(selectedBox);
    }
  }

  static Map segmentsCache = {};
  static List? getAyahSegments(String ayahKey) {
    if (_segmentsBox?.isOpen == false) return null;
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
        return supported.firstOrNullWhere(
          (reciter) =>
              reciter.segmentsUrl != null &&
              praseStringToBoxName(reciter.segmentsUrl!) == currentBoxName,
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
    // close other opened boxes
    List<String> boxesNames = getDownloadedBoxesNames();
    for (String boxName in boxesNames) {
      if (boxName != toOpenBox && Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
    }
    // save selected box to user DB
    await saveSelectedBox(toOpenBox);
    // open selected box
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
    void Function(double? percentage, String processName)? onProgress,
  }) async {
    final String boxName = praseStringToBoxName(url);
    if (await isAlreadyDownloaded(url)) {
      await changeSelectedBox(boxName);
      return true;
    } else {
      url = ApisUrls.base + url;
      final response = await dio.Dio().get(url);
      if (response.statusCode == 200) {
        _segmentsBox = await Hive.openBox(boxName);
        const processMsg = "Processing Audio Segments";
        if (onProgress != null) {
          onProgress(null, processMsg);
        }
        Map segmentsInfo = await compute(
          (message) => jsonDecode(decodeBZip2String(message)),
          response.data,
        );

        for (final ayahKey in segmentsInfo.keys) {
          await _segmentsBox!.put(ayahKey, segmentsInfo[ayahKey]);
        }

        // Save reciter metadata
        ReciterInfoModel? reciterInfo = getSegmentsSupportedReciters().firstOrNullWhere(
          (r) =>
              r.segmentsUrl != null &&
              (r.segmentsUrl == url ||
                  url.endsWith(r.segmentsUrl!) ||
                  praseStringToBoxName(r.segmentsUrl!) == boxName),
        );
        if (reciterInfo != null) {
          await _segmentsBox?.put(_metaKey, reciterInfo.toJson());
        } else if (context != null) {
          try {
            await _segmentsBox?.put(
              _metaKey,
              context.read<SegmentedQuranReciterCubit>().state.toJson(),
            );
          } catch (_) {}
        }

        // Track downloaded box
        List<String> downloaded = getDownloadedBoxesNames();
        if (!downloaded.contains(boxName)) {
          downloaded.add(boxName);
          await Hive.box("user").put(_allBoxKey, downloaded);
        }

        await changeSelectedBox(boxName);
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<bool> isAlreadyDownloaded(String url) async {
    return await Hive.boxExists(praseStringToBoxName(url));
  }

  static String praseStringToBoxName(String url) {
    final Uri uri = Uri.parse(url);
    String boxName = uri.pathSegments.last.replaceAll(
      RegExp(r"[^a-zA-Z0-9]"),
      "_",
    );
    return boxName.isNotEmpty
        ? boxName
        : "default_box_name"; // Fallback if parsing fails or result is empty
  }
}
