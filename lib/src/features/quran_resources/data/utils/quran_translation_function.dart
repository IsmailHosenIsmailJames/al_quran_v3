import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/core/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/get_translation_with_word_by_word.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "package:al_quran_v3/src/core/api/apis_urls.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/available_surah_info_lang.dart";
import "package:al_quran_v3/src/core/utils/encode_decode.dart";

class QuranTranslationFunction {
  static const String selectedTranslationListKey = "selected_translation_list";
  static const String downloadedTranslationBooks =
      "downloaded_translation_books";

  static Future<void> init({Locale? locale}) async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    List<ResourcesModel>? booksListToOpen = await getTranslationSelections();
    if (booksListToOpen == null) return;
    log(
      booksListToOpen.map((e) => e.toMap()).toString(),
      name: "QuranTranslationFunction.init",
    );

    // Open surah info boxes for any downloaded languages on disk
    for (final lang in availableSurahInfoInLang) {
      final infoBoxName = "surah_info_$lang";
      if (await Hive.boxExists(infoBoxName)) {
        if (!Hive.isBoxOpen(infoBoxName)) {
          await Hive.openLazyBox(infoBoxName);
        }
      }
    }

    // open surah info box for current locale if not already open
    if (locale != null) {
      String infoBoxName = "surah_info_${locale.languageCode}";
      if (!Hive.isBoxOpen(infoBoxName)) {
        await Hive.openLazyBox(infoBoxName);
      }
    }

    if (booksListToOpen.isNotEmpty) {
      for (ResourcesModel bookModel in booksListToOpen) {
        await Hive.openLazyBox(
          getTranslationBoxName(translationBook: bookModel),
        );
      }
    } else {
      log(
        "No translation selection found for init.",
        name: "QuranTranslationFunction.init",
      );
      await close(); // Ensure any open box is closed if nothing is selected
    }
  }

  static bool isInfoAvailable([Locale? locale]) {
    // 1. Check specific locale if provided
    if (locale != null) {
      final boxName = "surah_info_${locale.languageCode}";
      if (Hive.isBoxOpen(boxName) && Hive.lazyBox(boxName).isNotEmpty) {
        return true;
      }
    }

    // 2. Check if any available Surah info box is open and has items
    for (final lang in availableSurahInfoInLang) {
      final boxName = "surah_info_$lang";
      if (Hive.isBoxOpen(boxName) && Hive.lazyBox(boxName).isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  static String? getAvailableSurahInfoLanguage([Locale? preferredLocale]) {
    if (preferredLocale != null &&
        availableSurahInfoInLang.contains(preferredLocale.languageCode)) {
      final boxName = "surah_info_${preferredLocale.languageCode}";
      if (Hive.isBoxOpen(boxName) && Hive.lazyBox(boxName).isNotEmpty) {
        return preferredLocale.languageCode;
      }
    }

    // Check selected translation languages
    if (Hive.isBoxOpen("user")) {
      final userBox = Hive.box("user");
      final selectedList =
          userBox.get(selectedTranslationListKey, defaultValue: []) as List;
      for (final item in selectedList) {
        try {
          final book = ResourcesModel.fromMap(Map<String, dynamic>.from(item));
          final code = languageToCodeMap[book.language.toLowerCase()];
          if (code != null && availableSurahInfoInLang.contains(code)) {
            final boxName = "surah_info_$code";
            if (Hive.isBoxOpen(boxName) && Hive.lazyBox(boxName).isNotEmpty) {
              return code;
            }
          }
        } catch (_) {}
      }
    }

    // Check English fallback, then any open box
    if (Hive.isBoxOpen("surah_info_en") &&
        Hive.lazyBox("surah_info_en").isNotEmpty) {
      return "en";
    }

    for (final lang in availableSurahInfoInLang) {
      final boxName = "surah_info_$lang";
      if (Hive.isBoxOpen(boxName) && Hive.lazyBox(boxName).isNotEmpty) {
        return lang;
      }
    }

    // If preferred locale is supported, return it even if not yet downloaded
    if (preferredLocale != null &&
        availableSurahInfoInLang.contains(preferredLocale.languageCode)) {
      return preferredLocale.languageCode;
    }

    return "en";
  }

  static Future<String?> getInfoOfSurah(
    dynamic localeOrId, [
    String? optionalId,
  ]) async {
    Locale? locale;
    String id;
    if (localeOrId is Locale && optionalId != null) {
      locale = localeOrId;
      id = optionalId;
    } else if (localeOrId is String) {
      id = localeOrId;
      if (optionalId != null) locale = Locale(optionalId);
    } else {
      id = localeOrId.toString();
    }

    String? lang = locale?.languageCode;
    if (lang == null || !availableSurahInfoInLang.contains(lang)) {
      lang = getAvailableSurahInfoLanguage(locale);
    }
    lang ??= "en";

    final boxName = "surah_info_$lang";
    LazyBox box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.lazyBox(boxName);
    } else if (await Hive.boxExists(boxName)) {
      box = await Hive.openLazyBox(boxName);
    } else {
      // If not yet on disk, download on demand
      if (availableSurahInfoInLang.contains(lang)) {
        final success = await downloadSurahInfo(Locale(lang));
        if (success && Hive.isBoxOpen(boxName)) {
          box = Hive.lazyBox(boxName);
        } else {
          return null;
        }
      } else {
        return null;
      }
    }

    final data = await box.get(id);
    if (data == null) return null;
    return data["text"];
  }

  static Future<bool> isAlreadyDownloaded(ResourcesModel book) async {
    List<ResourcesModel> downloadedBooks = getDownloadedTranslationBooks();

    for (ResourcesModel downloadedBook in downloadedBooks) {
      // Use fullPath and language for unique identification
      if (downloadedBook.fullPath == book.fullPath) {
        final boxName = getTranslationBoxName(translationBook: book);
        return await Hive.boxExists(boxName);
      }
    }
    return false;
  }

  static Future<void> setToListAlreadyDownloaded(ResourcesModel book) async {
    final userBox = Hive.box("user");
    List<ResourcesModel> downloadedList = getDownloadedTranslationBooks();

    if (!downloadedList.any((b) => b.fullPath == book.fullPath)) {
      downloadedList.add(book);
      await userBox.put(
        downloadedTranslationBooks,
        downloadedList.map((e) => e.toMap()).toList(),
      );
    }
  }

  static List<ResourcesModel> getDownloadedTranslationBooks() {
    final userBox = Hive.box("user");
    List<dynamic> downloadedList = userBox.get(
      downloadedTranslationBooks,
      defaultValue: [],
    );
    return downloadedList
        .map((e) => ResourcesModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> removeFromListAlreadyDownloaded(
    ResourcesModel bookToRemove,
  ) async {
    List<ResourcesModel> downloaded = getDownloadedTranslationBooks();
    downloaded.removeWhere(
      (element) => element.fullPath == bookToRemove.fullPath,
    );

    await Hive.box("user").put(
      downloadedTranslationBooks,
      downloaded.map((e) => e.toMap()).toList(),
    );

    final boxName = getTranslationBoxName(translationBook: bookToRemove);
    if (await Hive.boxExists(boxName)) {
      await Hive.deleteBoxFromDisk(boxName);
      log(
        "Deleted translation box: $boxName",
        name: "removeToListAlreadyDownloaded",
      );
    }

    List<ResourcesModel>? selectedBefore = await getTranslationSelections();
    bool wasSelected =
        selectedBefore?.any((e) => e.fullPath == bookToRemove.fullPath) ??
        false;

    await removeTranslationSelection(bookToRemove);

    if (wasSelected && downloaded.isNotEmpty) {
      List<ResourcesModel>? selectedAfter = await getTranslationSelections();
      if (selectedAfter == null || selectedAfter.isEmpty) {
        await setTranslationSelection(downloaded.first);
      }
    }

    await Hive.box("user").put(
      downloadedTranslationBooks,
      downloaded.map((e) => e.toMap()).toList(),
    );
  }

  static Future<void> setTranslationSelection(ResourcesModel book) async {
    cacheOfAyahKeys.clear();
    final userBox = Hive.box("user");
    List<ResourcesModel> selectedTranslationList =
        (await getTranslationSelections()) ?? [];

    bool exists = selectedTranslationList.any(
      (e) => e.fullPath == book.fullPath,
    );
    if (!exists) {
      selectedTranslationList.add(book);
      await userBox.put(
        selectedTranslationListKey,
        selectedTranslationList.map((e) => e.toMap()).toList(),
      );
    }
    await init();
  }

  static Future<void> removeTranslationSelection(ResourcesModel book) async {
    cacheOfAyahKeys.clear();
    final userBox = Hive.box("user");
    List<ResourcesModel> selectedTranslationList =
        (await getTranslationSelections()) ?? [];
    selectedTranslationList.removeWhere(
      (element) => element.fullPath == book.fullPath,
    );
    await userBox.put(
      selectedTranslationListKey,
      selectedTranslationList.map((e) => e.toMap()).toList(),
    );
    await init();
  }

  static Future<List<ResourcesModel>?> getTranslationSelections() async {
    final userBox = Hive.box("user");
    final Map<String, dynamic>? previousBookMap = userBox
        .get("selected_translation")
        ?.cast<String, dynamic>();

    if (previousBookMap != null) {
      await userBox.put(selectedTranslationListKey, [previousBookMap]);
    }

    List? booksList = userBox.get(selectedTranslationListKey);
    List<ResourcesModel>? bookListModel = booksList
        ?.map((e) => ResourcesModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return bookListModel;
  }

  static String getTranslationBoxName({
    required ResourcesModel translationBook,
  }) {
    // Using fileName for brevity if available and suitable, otherwise fallback to fullPath's last segment
    String sanitizedBookIdentifier =
        (translationBook.fileName.isNotEmpty
                ? translationBook.fileName
                : translationBook.fullPath.split("/").last)
            .replaceAll(RegExp(r"[^\w\.-]"), "_");

    return "translation_${translationBook.language}_$sanitizedBookIdentifier";
  }

  static Future<List<String>?> getSelectedTranslationBoxName() async {
    List<ResourcesModel>? translationSelectionList =
        await getTranslationSelections();
    if (translationSelectionList != null) {
      return translationSelectionList
          .map((e) => getTranslationBoxName(translationBook: e))
          .toList();
    }
    return null;
  }

  static Future<bool> downloadResources({
    BuildContext? context,
    void Function(double? percentage, String processName)? onProgress,
    required ResourcesModel translationBook,
    bool isSetupProcess = false,
  }) async {
    void updateProgress(double? percentage, String name) {
      if (onProgress != null) {
        onProgress(percentage, name);
      }
    }

    updateProgress(
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
        List<ResourcesModel>? selectedTranslationBook =
            await getTranslationSelections();
        bool isSelected =
            selectedTranslationBook?.any(
              (element) =>
                  element.fileName == translationBook.fileName &&
                  element.language == translationBook.language,
            ) ==
            true;
        if (isSelected) {
          await init();
        }
      }
      // its selected and downloaded
      return true;
    }

    final translationBoxName = getTranslationBoxName(
      translationBook: translationBook,
    );
    log(
      "Starting download for Translation Box: $translationBoxName",
      name: "downloadResources",
    );

    LazyBox? newTranslationBox;
    try {
      newTranslationBox = await Hive.openLazyBox(translationBoxName);
    } catch (e) {
      log(
        "Error opening Box '$translationBoxName': $e. Trying to delete and reopen.",
        name: "downloadResources",
      );
      try {
        await Hive.deleteBoxFromDisk(translationBoxName);
        newTranslationBox = await Hive.openLazyBox(translationBoxName);
      } catch (e2) {
        log(
          "Failed to open Box '$translationBoxName' even after delete: $e2",
          name: "downloadResources",
        );
        updateProgress(null, "Error preparing translation storage");
        return false;
      }
    }

    try {
      String base = ApisUrls.base;
      // Using fullPath from the model for the download URL
      updateProgress(0.0, "Downloading: ${translationBook.name}");
      dio.Response response = await dio.Dio().get(
        base + translationBook.fullPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            updateProgress(
              progress * 0.5,
              "Downloading: ${translationBook.name}", // Using model's display name
            );
          }
        },
      );

      updateProgress(0.5, "Processing: ${translationBook.name}");
      Map data = await compute(
        (message) => jsonDecode(decodeBZip2String(message as String)),
        response.data,
      );

      updateProgress(0.7, "Saving Translation");
      await newTranslationBox.putAll(data);
      await newTranslationBox.put("meta_data", translationBook.toMap());

      await setToListAlreadyDownloaded(translationBook);
      if (isSetupProcess) {
        await setTranslationSelection(translationBook);
      }

      final bookLangCode =
          languageToCodeMap[translationBook.language.toLowerCase()];
      if (bookLangCode != null &&
          availableSurahInfoInLang.contains(bookLangCode)) {
        updateProgress(
          null,
          "Downloading Surah's Info (${translationBook.language})",
        );
        try {
          await downloadSurahInfo(Locale(bookLangCode));
        } catch (e) {
          log(
            "Error downloading surah info for $bookLangCode: $e",
            name: "downloadSurahInfo",
          );
        }
      } else {
        log(
          "Skipping downloading Surah's Info (${translationBook.language})",
          name: "downloadSurahInfo",
        );
      }

      await init();
      updateProgress(1.0, "Downloaded: ${translationBook.name}");
      return true;
    } catch (e, s) {
      log(
        "Error downloading or processing Translation '${translationBook.name}' (path: ${translationBook.fullPath}): $e\n$s",
        name: "downloadResources",
      );
      updateProgress(null, "Error downloading Translation");
      if (newTranslationBox.isOpen) {
        await newTranslationBox.close();
      }
      await Hive.deleteBoxFromDisk(translationBoxName);
      return false;
    }
  }

  static Future<bool> downloadSurahInfo(Locale locale) async {
    final surahInfoBoxName = "surah_info_${locale.languageCode}";
    log(
      "Downloading surah info for ${locale.languageCode}",
      name: "downloadSurahInfo",
    );
    // Check if box exists and is not empty
    if (await Hive.boxExists(surahInfoBoxName)) {
      var box = await Hive.openLazyBox(surahInfoBoxName);
      if (box.isNotEmpty) {
        log(
          "Surah info for ${locale.languageCode} already exists and is not empty.",
          name: "downloadSurahInfo",
        );
        // Keep box open so isInfoAvailable recognizes it immediately
        return true;
      }
      await box.close(); // Close if it was empty and we opened it
    }

    try {
      final response = await dio.Dio().get(
        "${ApisUrls.base}quranic_universal_library/surah_info/${locale.languageCode}.txt",
      );
      if (response.statusCode == 200) {
        log(surahInfoBoxName);
        final box = await Hive.openLazyBox(surahInfoBoxName);
        Map data = await compute(
          (message) => jsonDecode(decodeBZip2String(message as String)),
          response.data,
        );
        await box.putAll(data);
        log(
          "Surah info for ${locale.languageCode} downloaded successfully.",
          name: "downloadSurahInfo",
        );
        return true;
      } else {
        log(
          "Failed to download surah info for ${locale.languageCode}. Status: ${response.statusCode}",
          name: "downloadSurahInfo",
        );
        return false;
      }
    } catch (e) {
      log(
        "Error downloading surah info for ${locale.languageCode}: $e",
        name: "downloadSurahInfo",
      );
      return false;
    }
  }

  static Future<List<TranslationOfAyah>> getTranslation(String ayahKey) async {
    final List<TranslationOfAyah> toReturn = [];

    List<ResourcesModel>? selectedBooks =
        await getTranslationSelections() ?? [];

    for (ResourcesModel bookModel in selectedBooks) {
      String boxName = getTranslationBoxName(translationBook: bookModel);
      LazyBox? translationBox;
      if (!Hive.isBoxOpen(boxName)) {
        translationBox = await Hive.openLazyBox(boxName);
      } else {
        translationBox = Hive.lazyBox(boxName);
      }
      toReturn.add(
        TranslationOfAyah(
          translation: Map<String, dynamic>.from(
            await translationBox.get(
              ayahKey,
              defaultValue: {"t": "Translation Not Found For Ayah"},
            ),
          ),
          bookInfo: bookModel,
        ),
      );
    }

    return toReturn;
  }

  static Future<void> close() async {
    cacheOfAyahKeys.clear();
    List<ResourcesModel> selectedBooks = getDownloadedTranslationBooks();
    selectedBooks.addAll(await getTranslationSelections() ?? []);
    for (ResourcesModel bookModel in selectedBooks) {
      String boxName = getTranslationBoxName(translationBook: bookModel);
      if (Hive.isBoxOpen(boxName)) {
        await Hive.lazyBox(boxName).close();
      }
    }
  }
}
