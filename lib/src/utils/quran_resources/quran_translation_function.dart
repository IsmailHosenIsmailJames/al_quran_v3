import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/resources/quran_resources/language_resources.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../api/apis_urls.dart";
import "../../resources/quran_resources/available_surah_info_lang.dart";
import "../../resources/quran_resources/models/translation_book_model.dart"; // Correct import
import "../../screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "../encode_decode.dart";

class QuranTranslationFunction {
  static Box? openedTranslationBox;

  static Future<void> init({TranslationBookModel? translationBook}) async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    TranslationBookModel? bookToOpen =
        translationBook ?? getTranslationSelection();
    log(
      bookToOpen?.toMap().toString() ?? "No translation selected",
      name: "QuranTranslationFunction.init",
    );

    // open surah info box if not already open
    String infoBoxName =
        "surah_info_${languageToCodeMap[bookToOpen?.language.toLowerCase()]}";
    if (!Hive.isBoxOpen(infoBoxName)) {
      await Hive.openBox(infoBoxName);
    }

    if (bookToOpen != null) {
      final boxName = getTranslationBoxName(translationBook: bookToOpen);
      if (await Hive.boxExists(boxName)) {
        await close(); // Close any previously opened box
        openedTranslationBox = await Hive.openBox(boxName);
        log(
          "Opened translation box: $boxName",
          name: "QuranTranslationFunction.init",
        );
      } else {
        log(
          "Translation box '$boxName' for book '${bookToOpen.name}' (path: ${bookToOpen.fullPath}) language '${bookToOpen.language}' does not exist.",
          name: "QuranTranslationFunction.init",
        );
        if (translationBook == null) {
          // only clear if not explicitly trying to init this book
          await removeTranslationSelection(); // Clear invalid selection
        }
      }
    } else {
      log(
        "No translation selection found for init.",
        name: "QuranTranslationFunction.init",
      );
      await close(); // Ensure any open box is closed if nothing is selected
    }
  }

  static bool isInfoAvailable() {
    final boxName =
        "surah_info_${languageToCodeMap[getTranslationSelection()?.language.toLowerCase()]}";
    return Hive.box(boxName).isNotEmpty;
  }

  static String getInfoOfSurah(String id) {
    final boxName =
        "surah_info_${languageToCodeMap[getTranslationSelection()?.language.toLowerCase()]}";
    return Hive.box(boxName).get(id)["text"];
  }

  static Future<bool> isAlreadyDownloaded(TranslationBookModel book) async {
    List<TranslationBookModel> downloadedBooks =
        getDownloadedTranslationBooks();

    for (TranslationBookModel downloadedBook in downloadedBooks) {
      // Use fullPath and language for unique identification
      if (downloadedBook.fullPath == book.fullPath) {
        final boxName = getTranslationBoxName(translationBook: book);
        return await Hive.boxExists(boxName);
      }
    }
    return false;
  }

  static Future<void> setToListAlreadyDownloaded(
    TranslationBookModel book,
  ) async {
    final userBox = Hive.box("user");
    List<TranslationBookModel> downloadedList = getDownloadedTranslationBooks();

    if (!downloadedList.any((b) => b.fullPath == book.fullPath)) {
      downloadedList.add(book);
      await userBox.put(
        "downloaded_translation_books",
        downloadedList.map((e) => e.toMap()).toList(),
      );
    }
  }

  static List<TranslationBookModel> getDownloadedTranslationBooks() {
    final userBox = Hive.box("user");
    List<dynamic> downloadedList = userBox.get(
      "downloaded_translation_books",
      defaultValue: [],
    );
    return downloadedList
        .map((e) => TranslationBookModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> removeToListAlreadyDownloaded(
    TranslationBookModel bookToRemove,
  ) async {
    List<TranslationBookModel> downloaded = getDownloadedTranslationBooks();
    downloaded.removeWhere(
      (element) => element.fullPath == bookToRemove.fullPath,
    );

    await Hive.box("user").put(
      "downloaded_translation_books",
      downloaded.map((e) => e.toMap()).toList(),
    );

    final boxName = getTranslationBoxName(translationBook: bookToRemove);
    if (await Hive.boxExists(boxName)) {
      if (openedTranslationBox?.name == boxName) {
        await close();
      }
      await Hive.deleteBoxFromDisk(boxName);
      log(
        "Deleted translation box: $boxName",
        name: "removeToListAlreadyDownloaded",
      );
    }

    final selected = getTranslationSelection();
    if (selected != null &&
        selected.fullPath == bookToRemove.fullPath &&
        selected.language == bookToRemove.language) {
      await removeTranslationSelection();
    }
  }

  static Future<void> removeTranslationSelection() async {
    final userBox = Hive.box("user");
    await userBox.delete("selected_translation");
    await close();
    log("Translation selection removed.", name: "removeTranslationSelection");
  }

  static Future<void> setTranslationSelection(TranslationBookModel book) async {
    final userBox = Hive.box("user");
    await userBox.put("selected_translation", book.toMap());
    await init(translationBook: book);
  }

  static TranslationBookModel? getTranslationSelection() {
    final userBox = Hive.box("user");
    final Map<String, dynamic>? bookMap =
        userBox.get("selected_translation")?.cast<String, dynamic>();
    if (bookMap != null) {
      return TranslationBookModel.fromMap(bookMap);
    }
    return null;
  }

  static String getTranslationBoxName({
    required TranslationBookModel translationBook,
  }) {
    // Using fileName for brevity if available and suitable, otherwise fallback to fullPath's last segment
    String sanitizedBookIdentifier = (translationBook.fileName.isNotEmpty
            ? translationBook.fileName
            : translationBook.fullPath.split("/").last)
        .replaceAll(RegExp(r"[^\w\.-]"), "_");

    return "translation_${translationBook.language}_$sanitizedBookIdentifier";
  }

  static String? getSelectedTranslationBoxName() {
    TranslationBookModel? translationSelection = getTranslationSelection();
    if (translationSelection != null) {
      return getTranslationBoxName(translationBook: translationSelection);
    }
    return null;
  }

  static Future<bool> downloadResources({
    required BuildContext context,
    required TranslationBookModel translationBook,
    bool isSetupProcess = false,
  }) async {
    final cubit = context.read<ResourcesProgressCubitCubit>();
    cubit.updateProgress(
      null,
      "Downloading Translation: ${translationBook.name}",
    );
    if (await isAlreadyDownloaded(translationBook)) {
      log(
        "Translation '${translationBook.name}' (path: ${translationBook.fullPath}) for language '${translationBook.language}' is already downloaded.",
        name: "downloadResources",
      );
      if (isSetupProcess) {
        await setTranslationSelection(translationBook);
      } else {
        final currentSelection = getTranslationSelection();
        if (currentSelection?.fullPath == translationBook.fullPath &&
            currentSelection?.language == translationBook.language &&
            openedTranslationBox == null) {
          await init(translationBook: translationBook);
        }
      }
      return true;
    }

    final translationBoxName = getTranslationBoxName(
      translationBook: translationBook,
    );
    log(
      "Starting download for Translation Box: $translationBoxName",
      name: "downloadResources",
    );

    Box? newTranslationBox;
    try {
      newTranslationBox = await Hive.openBox(translationBoxName);
    } catch (e) {
      log(
        "Error opening Box '$translationBoxName': $e. Trying to delete and reopen.",
        name: "downloadResources",
      );
      try {
        await Hive.deleteBoxFromDisk(translationBoxName);
        newTranslationBox = await Hive.openBox(translationBoxName);
      } catch (e2) {
        log(
          "Failed to open Box '$translationBoxName' even after delete: $e2",
          name: "downloadResources",
        );
        cubit.updateProgress(null, "Error preparing translation storage");
        return false;
      }
    }

    try {
      String base = ApisUrls.base;
      // Using fullPath from the model for the download URL
      cubit.updateProgress(0.0, "Downloading: ${translationBook.name}");
      dio.Response response = await dio.Dio().get(
        base + translationBook.fullPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            cubit.updateProgress(
              progress * 0.5,
              "Downloading: ${translationBook.name}", // Using model's display name
            );
          }
        },
      );

      cubit.updateProgress(0.5, "Processing: ${translationBook.name}");
      Map data = await compute(
        (message) => jsonDecode(decodeBZip2String(message as String)),
        response.data,
      );

      int totalEntries = data.length;
      int processedEntries = 0;
      for (int i = 0; i < data.length; i++) {
        String key = data.keys.elementAt(i);
        await newTranslationBox.put(key, data[key]);
        processedEntries++;
        if (processedEntries % 50 == 0 || processedEntries == totalEntries) {
          cubit.updateProgress(
            0.5 + (processedEntries / totalEntries * 0.5),
            "Processing Translation",
          );
        }
      }
      await newTranslationBox.put("meta_data", translationBook.toMap());

      await setToListAlreadyDownloaded(translationBook);
      if (isSetupProcess) {
        await setTranslationSelection(translationBook);
      }

      if (availableSurahInfoInLang.contains(
        languageToCodeMap[translationBook.language.toLowerCase()],
      )) {
        cubit.updateProgress(
          null,
          "Downloading Surah's Info (${translationBook.language})",
        );
        await downloadSurahInfo(
          languageToCodeMap[translationBook.language.toLowerCase()]!,
        );
      } else {
        log(
          "Skipping downloading Surah's Info (${translationBook.language})",
          name: "downloadSurahInfo",
        );
      }

      log(
        "Translation '${translationBook.name}' (path: ${translationBook.fullPath}) downloaded and processed successfully.",
        name: "downloadResources",
      );
      final currentSelection = getTranslationSelection();
      if (currentSelection?.fullPath == translationBook.fullPath &&
          currentSelection?.language == translationBook.language) {
        await init(translationBook: translationBook);
      }
      cubit.updateProgress(1.0, "Downloaded: ${translationBook.name}");
      return true;
    } catch (e, s) {
      log(
        "Error downloading or processing Translation '${translationBook.name}' (path: ${translationBook.fullPath}): $e\n$s",
        name: "downloadResources",
      );
      cubit.updateProgress(null, "Error downloading Translation");
      if (newTranslationBox.isOpen) {
        await newTranslationBox.close();
      }
      await Hive.deleteBoxFromDisk(translationBoxName);
      return false;
    }
  }

  static Future<void> downloadSurahInfo(String languageCode) async {
    final surahInfoBoxName = "surah_info_$languageCode";
    log("Downloading surah info for $languageCode", name: "downloadSurahInfo");
    // Check if box exists and is not empty
    if (await Hive.boxExists(surahInfoBoxName)) {
      var box = await Hive.openBox(surahInfoBoxName);
      if (box.isNotEmpty) {
        log(
          "Surah info for $languageCode already exists and is not empty.",
          name: "downloadSurahInfo",
        );
        await box.close(); // Close if we opened it just for check
        return;
      }
      await box.close(); // Close if it was empty and we opened it
    }

    try {
      final response = await dio.Dio().get(
        "${ApisUrls.base}quranic_universal_library/surah_info/$languageCode.txt",
      );
      if (response.statusCode == 200) {
        log(surahInfoBoxName);
        final box = await Hive.openBox(surahInfoBoxName);
        Map data = await compute(
          (message) => jsonDecode(decodeBZip2String(message as String)),
          response.data,
        );
        for (final key in data.keys) {
          log(key);
          await box.put(key, data[key]);
        }
        // await box.close(); // Close after writing
        log(
          "Surah info for $languageCode downloaded successfully.",
          name: "downloadSurahInfo",
        );
      } else {
        log(
          "Failed to download surah info for $languageCode. Status: ${response.statusCode}",
          name: "downloadSurahInfo",
        );
      }
    } catch (e) {
      log(
        "Error downloading surah info for $languageCode: $e",
        name: "downloadSurahInfo",
      );
    }
  }

  static Map? getTranslation(String ayahKey) {
    if (openedTranslationBox == null || !openedTranslationBox!.isOpen) {
      log("Translation box is not open or available.", name: "getTranslation");
      TranslationBookModel? currentSelection = getTranslationSelection();
      if (currentSelection != null) {
        log(
          "Attempting to re-open translation box for ${currentSelection.name} (path: ${currentSelection.fullPath})",
          name: "getTranslation",
        );
        // Synchronous re-init is problematic. UI should handle this state.
        return {"t": "Translation box not ready. Please re-select."};
      }
      return {"t": "Translation Not Selected"};
    }
    return openedTranslationBox!.get(
      ayahKey,
      defaultValue: {"t": "Translation Not Found For Ayah"},
    );
  }

  static TranslationBookModel? getMetaInfo() {
    if (openedTranslationBox != null && openedTranslationBox!.isOpen) {
      final Map<String, dynamic>? metaMap =
          openedTranslationBox!.get("meta_data")?.cast<String, dynamic>();
      if (metaMap != null) {
        return TranslationBookModel.fromMap(metaMap);
      }
    }
    log(
      "Translation box not open or meta_data not found.",
      name: "getMetaInfo",
    );
    return null;
  }

  static Future<void> close() async {
    if (openedTranslationBox != null && openedTranslationBox!.isOpen) {
      await openedTranslationBox!.close();
      log(
        "Translation box '${openedTranslationBox!.name}' closed.",
        name: "QuranTranslationFunction.close",
      );
    }
    openedTranslationBox = null;
  }
}
