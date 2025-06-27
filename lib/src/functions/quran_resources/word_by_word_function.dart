import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/resources/quran_resources/word_by_word_translation.dart";
import "package:al_quran_v3/src/screen/setup/cubit/download_progress_cubit_cubit.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

import "../encode_decode.dart"; // Assuming you have this for bzip2 decoding

class WordByWordFunction {
  static Box? openedWordByWordBox;
  static const String _userBoxKeyDownloaded = "downloaded_wbw_languages";
  static const String _userBoxKeySelected = "selected_wbw_language";

  static Future<void> init({String? languageKey}) async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    final userBox = Hive.box("user");
    String? selectedLanguage = languageKey ?? userBox.get(_userBoxKeySelected);

    log(
      "Selected WbW Language for init: $selectedLanguage",
      name: "WbWFunction.init",
    );

    if (selectedLanguage != null) {
      final boxName = getWordByWordBoxName(selectedLanguage);
      if (await Hive.boxExists(boxName)) {
        await close(); // Close any previously opened box
        openedWordByWordBox = await Hive.openBox(boxName);
        log(
          "Opened WbW box for '$selectedLanguage': $boxName",
          name: "WbWFunction.init",
        );
      } else {
        log(
          "WbW box '$boxName' for language '$selectedLanguage' does not exist.",
          name: "WbWFunction.init",
        );
        // It might have been selected but deleted, so clear selection
        if (languageKey == null) {
          // only clear if not explicitly trying to init this key
          await removeSelectedWordByWordLanguage();
        }
      }
    } else {
      log("No WbW language selected.", name: "WbWFunction.init");
      await close(); // Ensure any open box is closed if nothing is selected
    }
  }

  static String getWordByWordBoxName(String languageKey) {
    // Sanitize languageKey if necessary, though keys from wordByWordTranslation should be simple
    final sanitizedKey = languageKey.replaceAll(RegExp(r"[^\w]"), "_");
    return "wbw_$sanitizedKey";
  }

  static Future<bool> isLanguageDownloaded(String languageKey) async {
    final userBox = Hive.box("user");
    List<String> downloadedLanguages = List<String>.from(
      userBox.get(_userBoxKeyDownloaded, defaultValue: []),
    );
    if (downloadedLanguages.contains(languageKey)) {
      final boxName = getWordByWordBoxName(languageKey);
      return await Hive.boxExists(boxName);
    }
    return false;
  }

  static Future<void> setLanguageAsDownloaded(String languageKey) async {
    final userBox = Hive.box("user");
    List<String> downloadedLanguages = List<String>.from(
      userBox.get(_userBoxKeyDownloaded, defaultValue: []),
    );
    if (!downloadedLanguages.contains(languageKey)) {
      downloadedLanguages.add(languageKey);
      await userBox.put(_userBoxKeyDownloaded, downloadedLanguages);
      log(
        "Language '$languageKey' marked as downloaded.",
        name: "WbWFunction.setLanguageAsDownloaded",
      );
    }
  }

  static List<String> getDownloadedWordByWordLanguages() {
    final userBox = Hive.box("user");
    return List<String>.from(
      userBox.get(_userBoxKeyDownloaded, defaultValue: []),
    );
  }

  static Map<String, dynamic>? getLanguageInfo(String languageKey) {
    if (wordByWordTranslation.containsKey(languageKey)) {
      // wordByWordTranslation stores a list with one map, so take the first element
      return wordByWordTranslation[languageKey]!.first;
    }
    return null;
  }

  static Future<void> removeLanguageFromDownloaded(String languageKey) async {
    final userBox = Hive.box("user");
    List<String> downloadedLanguages = List<String>.from(
      userBox.get(_userBoxKeyDownloaded, defaultValue: []),
    );
    if (downloadedLanguages.contains(languageKey)) {
      downloadedLanguages.remove(languageKey);
      await userBox.put(_userBoxKeyDownloaded, downloadedLanguages);
      log(
        "Language '$languageKey' removed from downloaded list.",
        name: "WbWFunction.removeLanguageFromDownloaded",
      );
    }

    final boxName = getWordByWordBoxName(languageKey);
    if (await Hive.boxExists(boxName)) {
      if (openedWordByWordBox?.name == boxName) {
        await close();
      }
      await Hive.deleteBoxFromDisk(boxName);
      log(
        "Deleted WbW box: $boxName",
        name: "WbWFunction.removeLanguageFromDownloaded",
      );
    }

    // If the removed language was selected, clear the selection
    if (getSelectedWordByWordLanguage() == languageKey) {
      await removeSelectedWordByWordLanguage();
    }
  }

  static Future<void> setSelectedWordByWordLanguage(String languageKey) async {
    final userBox = Hive.box("user");
    await userBox.put(_userBoxKeySelected, languageKey);
    log(
      "Language '$languageKey' set as selected WbW.",
      name: "WbWFunction.setSelectedWordByWordLanguage",
    );
    await init(
      languageKey: languageKey,
    ); // Re-initialize with the new selection
  }

  static String? getSelectedWordByWordLanguage() {
    final userBox = Hive.box("user");
    return userBox.get(_userBoxKeySelected);
  }

  static Future<void> removeSelectedWordByWordLanguage() async {
    final userBox = Hive.box("user");
    await userBox.delete(_userBoxKeySelected);
    log(
      "Selected WbW language removed.",
      name: "WbWFunction.removeSelectedWordByWordLanguage",
    );
    await close(); // Close any opened box
  }

  static Future<bool> downloadResource({
    required BuildContext context,
    required String languageKey, // e.g., "english", "hindi"
    bool isSetupProcess = false,
  }) async {
    final cubit = context.read<DownloadProgressCubitCubit>();

    if (await isLanguageDownloaded(languageKey)) {
      log(
        "WbW for '$languageKey' is already downloaded.",
        name: "WbWFunction.downloadResource",
      );
      if (isSetupProcess && getSelectedWordByWordLanguage() != languageKey) {
        await setSelectedWordByWordLanguage(languageKey);
      } else if (getSelectedWordByWordLanguage() == languageKey &&
          openedWordByWordBox == null) {
        // If selected but box is not open (e.g. after app restart)
        await init(languageKey: languageKey);
      }
      return true;
    }

    final languageData = wordByWordTranslation[languageKey];
    if (languageData == null || languageData.isEmpty) {
      log(
        "No WbW data found for language key '$languageKey' in data source.",
        name: "WbWFunction.downloadResource",
      );
      cubit.updateProgress(null, "Error: WbW for $languageKey not found");
      return false;
    }
    // Assuming one entry per language key
    final Map<String, dynamic> wbwInfo = languageData.first;
    final String? filePath = wbwInfo["full_path"] as String?;

    if (filePath == null) {
      log(
        "File path for '$languageKey' is null.",
        name: "WbWFunction.downloadResource",
      );
      cubit.updateProgress(null, "Error: File path for $languageKey missing");
      return false;
    }

    final boxName = getWordByWordBoxName(languageKey);
    log(
      "Starting download for WbW '$languageKey', Box: $boxName, Path: $filePath",
      name: "WbWFunction.downloadResource",
    );

    Box? newBox; // Use a temporary variable for the new box
    try {
      newBox = await Hive.openBox(boxName);
    } catch (e) {
      log(
        "Error opening Hive box '$boxName' for WbW: $e. Trying to delete and reopen.",
        name: "WbWFunction.downloadResource",
      );
      try {
        await Hive.deleteBoxFromDisk(boxName);
        newBox = await Hive.openBox(boxName);
      } catch (e2) {
        log(
          "Failed to open Hive box '$boxName' even after delete: $e2",
          name: "WbWFunction.downloadResource",
        );
        cubit.updateProgress(null, "Error preparing WbW storage");
        return false;
      }
    }

    try {
      final String downloadUrl = ApisUrls.base + filePath;
      cubit.updateProgress(0.0, "Downloading WbW: ${wbwInfo['name']}");

      dio.Response response = await dio.Dio().get(
        downloadUrl,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            // Cap progress at 0.5 for download part, remaining for processing
            cubit.updateProgress(
              progress * 0.5,
              "Downloading WbW: ${wbwInfo['name']}",
            );
          }
        },
      );

      cubit.updateProgress(0.5, "Processing WbW: ${wbwInfo['name']}");
      // Assuming the response.data is the bzip2 compressed string
      Map<String, dynamic> jsonData = await compute(
        (data) =>
            jsonDecode(decodeBZip2String(data as String))
                as Map<String, dynamic>,
        response.data,
      );

      int totalEntries = jsonData.length;
      int processedEntries = 0;

      for (var entry in jsonData.entries) {
        await newBox.put(entry.key, entry.value); // ayahKey: List<WordData>
        processedEntries++;
        if (processedEntries % 50 == 0 || processedEntries == totalEntries) {
          // Progress from 0.5 to 1.0 for processing
          cubit.updateProgress(
            0.5 + (processedEntries / totalEntries * 0.5),
            "Processing WbW data",
          );
        }
      }

      await newBox.put("meta_data", {
        ...wbwInfo, // Store all info from word_by_word_translation.dart
        "download_date": DateTime.now().toIso8601String(),
        "language_key": languageKey,
      });

      await setLanguageAsDownloaded(languageKey);
      if (isSetupProcess) {
        await setSelectedWordByWordLanguage(languageKey);
      } else if (getSelectedWordByWordLanguage() == languageKey) {
        // If it was already selected, re-init to open the newly downloaded box
        await init(languageKey: languageKey);
      }

      log(
        "WbW for '$languageKey' downloaded and processed successfully.",
        name: "WbWFunction.downloadResource",
      );
      cubit.updateProgress(1.0, "WbW: ${wbwInfo['name']} Downloaded");
      return true;
    } catch (e, s) {
      log(
        "Error downloading/processing WbW for '$languageKey': $e\n$s",
        name: "WbWFunction.downloadResource",
      );
      cubit.updateProgress(
        null,
        "Error downloading WbW for ${wbwInfo['name']}",
      );
      // Clean up partially downloaded box
      if (newBox.isOpen) {
        await newBox.close();
      }
      await Hive.deleteBoxFromDisk(boxName);
      return false;
    }
  }

  static List? getAyahWordByWordData(String ayahKey) {
    if (openedWordByWordBox != null && openedWordByWordBox!.isOpen) {
      if (openedWordByWordBox!.containsKey(ayahKey)) {
        // Data is typically stored as Map<String, List<Map<String, dynamic>>>
        // but Hive might return it as Map<dynamic, dynamic>
        var data = openedWordByWordBox!.get(ayahKey);
        return data;
      } else {
        log(
          "No WbW data found for ayah '$ayahKey' in the current box.",
          name: "WbWFunction.getAyahWordByWordData",
        );
        return null;
      }
    }
    log(
      "WbW box is not open or available.",
      name: "WbWFunction.getAyahWordByWordData",
    );
    return null;
  }

  static Map<String, dynamic>? getMetaInfo() {
    if (openedWordByWordBox != null && openedWordByWordBox!.isOpen) {
      var meta = openedWordByWordBox!.get("meta_data");
      log(meta.toString(), name: "wbw-meta");
      if (meta is Map) {
        return Map<String, dynamic>.from(meta);
      }
    }
    log(
      "WbW box not open or meta_data not found.",
      name: "WbWFunction.getMetaInfo",
    );
    return null;
  }

  static Future<void> close() async {
    if (openedWordByWordBox != null && openedWordByWordBox!.isOpen) {
      await openedWordByWordBox!.close();
      log(
        "WbW box '${openedWordByWordBox!.name}' closed.",
        name: "WbWFunction.close",
      );
    }
    openedWordByWordBox = null;
  }
}
