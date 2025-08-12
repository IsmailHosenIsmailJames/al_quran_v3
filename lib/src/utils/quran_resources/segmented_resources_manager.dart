import "dart:convert";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/utils/encode_decode.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/hive_flutter.dart";

class SegmentedResourcesManager {
  static final String _selectedBox = "selected_segmented_recitation_box";
  static final String _allBoxKey = "segmented_recitation_boxes";
  static final String _metaKey = "meta_data";
  static Box? _segmentsBox;

  static Future<void> init() async {
    await Hive.openBox("user");
    String? selectedBox = getSelectedDataBoxName();
    if (selectedBox != null) {
      await changeSelectedBox(selectedBox);
    }
  }

  static List? getAyahSegments(String ayahKey) {
    if (_segmentsBox?.isOpen == false) return null;
    Map? audioTimeStamp = _segmentsBox?.get(ayahKey, defaultValue: null);
    List<List>? segments;
    if (audioTimeStamp != null) {
      segments = List<List>.from(audioTimeStamp["segments"]);
    }
    return segments;
  }

  static ReciterInfoModel? getOpenSegmentsReciter() {
    String? metaData = _segmentsBox?.get(_metaKey, defaultValue: null);
    if (metaData == null) return null;
    return ReciterInfoModel.fromJson(_segmentsBox!.get(_metaKey));
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
    return Hive.box("user").get(_selectedBox, defaultValue: null);
  }

  static Future<void> saveSelectedBox(String boxName) async {
    await Hive.box("user").put(_selectedBox, boxName);
  }

  static List<String> getDownloadedBoxesNames() {
    return List<String>.from(
      Hive.box("user").get(_allBoxKey, defaultValue: []),
    );
  }

  static Future<void> changeSelectedBox(String toOpenBox) async {
    // close all opened boxes
    List<String> boxesNames = getDownloadedBoxesNames();
    for (String boxName in boxesNames) {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
    }
    // save selected box to user DB
    saveSelectedBox(toOpenBox);
    // open selected box
    _segmentsBox = await Hive.openBox(toOpenBox);
  }

  static Future<bool> downloadResources(
    BuildContext context,
    String url,
  ) async {
    if (await isAlreadyDownloaded(url)) {
      return true;
    } else {
      AppLocalizations appLocalizations = AppLocalizations.of(context);
      url = ApisUrls.base + url;
      final response = await dio.Dio().get(url);
      final String boxName = praseStringToBoxName(url);
      if (response.statusCode == 200) {
        _segmentsBox = await Hive.openBox(boxName);
        context.read<ResourcesProgressCubitCubit>().updateProgress(
          null,
          appLocalizations.processingSegmentedQuranRecitation,
        );
        Map segmentsInfo = await compute(
          (message) => jsonDecode(decodeBZip2String(message)),
          response.data,
        );

        for (final ayahKey in segmentsInfo.keys) {
          await _segmentsBox!.put(ayahKey, segmentsInfo[ayahKey]);
        }
        await _segmentsBox?.put(
          _metaKey,
          context.read<SegmentedQuranReciterCubit>().state.toJson(),
        );
        await changeSelectedBox(praseStringToBoxName(url));
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
