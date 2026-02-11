import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/resources/quran_resources/language_resources.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/utils/quran_resources/get_translation_with_word_by_word.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../api/apis_urls.dart";
import "../../resources/quran_resources/available_surah_info_lang.dart";
import "../../resources/quran_resources/models/translation_book_model.dart";
import "../../screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "../encode_decode.dart";

class QuranTranslationFunction {
  static const String selectedTranslationListKey = "selected_translation_list";
  static const String downloadedTranslationBooks =
      "downloaded_translation_books";

  static Future<void> init({Locale? locale}) async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    List<TranslationBookModel>? booksListToOpen =
        await getTranslationSelections();
    if (booksListToOpen == null) return;
    log(
      booksListToOpen.map((e) => e.toMap()).toString(),
      name: "QuranTranslationFunction.init",
    );

    // open surah info box if not already open
    if (locale != null) {
      String infoBoxName = "surah_info_${locale.languageCode}";
      if (!Hive.isBoxOpen(infoBoxName)) {
        await Hive.openLazyBox(infoBoxName);
      }
    }

    if (booksListToOpen.isNotEmpty) {
      for (TranslationBookModel bookModel in booksListToOpen) {
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

  static bool isInfoAvailable(Locale locale) {
    final boxName = "surah_info_${locale.languageCode}";
    return Hive.isBoxOpen(boxName);
  }

  static Future<String> getInfoOfSurah(Locale locale, String id) async {
    final boxName = "surah_info_${locale.languageCode}";
    return (await Hive.lazyBox(boxName).get(id))["text"];
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
        downloadedTranslationBooks,
        downloadedList.map((e) => e.toMap()).toList(),
      );
    }
  }

  static List<TranslationBookModel> getDownloadedTranslationBooks() {
    final userBox = Hive.box("user");
    List<dynamic> downloadedList = userBox.get(
      downloadedTranslationBooks,
      defaultValue: [],
    );
    return downloadedList
        .map((e) => TranslationBookModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> removeFromListAlreadyDownloaded(
    TranslationBookModel bookToRemove,
  ) async {
    List<TranslationBookModel> downloaded = getDownloadedTranslationBooks();
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
    await Hive.box("user").put(
      downloadedTranslationBooks,
      downloaded.map((e) => e.toMap()).toList(),
    );
  }

  static Future<void> setTranslationSelection(TranslationBookModel book) async {
    cacheOfAyahKeys.clear();
    final userBox = Hive.box("user");
    List<TranslationBookModel> selectedTranslationList =
        (await getTranslationSelections()) ?? [];
    selectedTranslationList.add(book);
    await userBox.put(
      selectedTranslationListKey,
      selectedTranslationList.map((e) => e.toMap()).toList(),
    );
    await init();
  }

  static Future<void> removeTranslationSelection(
    TranslationBookModel book,
  ) async {
    cacheOfAyahKeys.clear();
    final userBox = Hive.box("user");
    List<TranslationBookModel> selectedTranslationList =
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

  static Future<List<TranslationBookModel>?> getTranslationSelections() async {
    final userBox = Hive.box("user");
    final Map<String, dynamic>? previousBookMap = userBox
        .get("selected_translation")
        ?.cast<String, dynamic>();

    if (previousBookMap != null) {
      await userBox.put(selectedTranslationListKey, [previousBookMap]);
    }

    List? booksList = userBox.get(selectedTranslationListKey);
    List<TranslationBookModel>? bookListModel = booksList
        ?.map((e) => TranslationBookModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return bookListModel;
  }

  static String getTranslationBoxName({
    required TranslationBookModel translationBook,
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
    List<TranslationBookModel>? translationSelectionList =
        await getTranslationSelections();
    if (translationSelectionList != null) {
      return translationSelectionList
          .map((e) => getTranslationBoxName(translationBook: e))
          .toList();
    }
    return null;
  }

  static Future<bool> downloadResources({
    required BuildContext context,
    required TranslationBookModel translationBook,
    bool isSetupProcess = false,
  }) async {
    final cubit = context.read<ResourcesProgressCubit>();
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
        List<TranslationBookModel>? selectedTranslationBook =
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
        await downloadSurahInfo(context.read<LanguageCubit>().state.locale);
      } else {
        log(
          "Skipping downloading Surah's Info (${translationBook.language})",
          name: "downloadSurahInfo",
        );
      }

      await init();
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

  static Future<void> downloadSurahInfo(Locale locale) async {
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
        await box.close(); // Close if we opened it just for check
        return;
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
        for (final key in data.keys) {
          log(key);
          await box.put(key, data[key]);
        }
        // await box.close(); // Close after writing
        log(
          "Surah info for ${locale.languageCode} downloaded successfully.",
          name: "downloadSurahInfo",
        );
      } else {
        log(
          "Failed to download surah info for ${locale.languageCode}. Status: ${response.statusCode}",
          name: "downloadSurahInfo",
        );
      }
    } catch (e) {
      log(
        "Error downloading surah info for ${locale.languageCode}: $e",
        name: "downloadSurahInfo",
      );
    }
  }

  static Future<List<TranslationOfAyah>> getTranslation(String ayahKey) async {
    final List<TranslationOfAyah> toReturn = [];

    List<TranslationBookModel>? selectedBooks =
        await getTranslationSelections() ?? [];

    for (TranslationBookModel bookModel in selectedBooks) {
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
    List<TranslationBookModel> selectedBooks = getDownloadedTranslationBooks();
    selectedBooks.addAll(await getTranslationSelections() ?? []);
    for (TranslationBookModel bookModel in selectedBooks) {
      String boxName = getTranslationBoxName(translationBook: bookModel);
      if (Hive.isBoxOpen(boxName)) {
        await Hive.lazyBox(boxName).close();
      }
    }
  }
}
