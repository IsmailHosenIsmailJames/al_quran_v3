import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/core/api/apis_urls.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/foundation.dart";
import "package:flutter/material.dart"; // Still needed for BuildContext
import "package:hive_ce_flutter/hive_flutter.dart";

import "package:al_quran_v3/src/core/utils/encode_decode.dart";

class WordByWordFunction {
  static LazyBox? openedWordByWordBox;

  // User box keys will now store maps, not just language strings
  static const String _userBoxKeyDownloaded = "downloaded_wbw_books";
  static const String _userBoxKeySelected = "selected_wbw_book";

  static Future<void> init({ResourcesModel? book}) async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    ResourcesModel? selectedBook = book ?? getSelectedWordByWordBook();

    log(
      "Selected WbW Book for init: ${selectedBook?.toMap()}",
      name: "WbWFunction.init",
    );

    if (selectedBook != null) {
      // Ensure it's a wordByWord type, though selection should ideally filter this
      if (selectedBook.type != ResourceType.word_by_word) {
        log(
          "Book ${selectedBook.name} is not a wordByWord type. Clearing selection.",
          name: "WbWFunction.init",
        );
        if (book == null) await removeSelectedWordByWordBook();
        return;
      }
      final boxName = getWordByWordBoxName(selectedBook);
      if (await Hive.boxExists(boxName)) {
        await close(); // Close any previously opened box
        openedWordByWordBox = await Hive.openLazyBox(boxName);
        log(
          "Opened WbW box for '${selectedBook.name}': $boxName",
          name: "WbWFunction.init",
        );
      } else {
        log(
          "WbW box '$boxName' for book '${selectedBook.name}' (path: ${selectedBook.fullPath}) language '${selectedBook.language}' does not exist.",
          name: "WbWFunction.init",
        );
        if (book == null) {
          await removeSelectedWordByWordBook();
        }
      }
    } else {
      log("No WbW book selected.", name: "WbWFunction.init");
      await close();
    }
  }

  static String getWordByWordBoxName(ResourcesModel book) {
    // Ensure it's a wordByWord type before proceeding (optional assertion)
    // assert(book.type == ResourceType.word_by_word);
    String sanitizedIdentifier =
        (book.fileName.isNotEmpty
                ? book.fileName
                : book.fullPath.split("/").last)
            .replaceAll(RegExp(r"[^\w\.-]"), "_");

    return "wbw_${book.language}_$sanitizedIdentifier";
  }

  static Future<bool> isBookDownloaded(ResourcesModel book) async {
    // assert(book.type == ResourceType.word_by_word);
    final userBox = Hive.box("user");
    List<dynamic> downloadedList = userBox.get(
      _userBoxKeyDownloaded,
      defaultValue: [],
    );
    List<ResourcesModel> downloadedBooks = downloadedList
        .map((e) => ResourcesModel.fromMap(Map<String, dynamic>.from(e)))
        .where((b) => b.type == ResourceType.word_by_word)
        .toList();

    for (ResourcesModel downloadedBook in downloadedBooks) {
      if (downloadedBook.fullPath == book.fullPath &&
          downloadedBook.language == book.language) {
        final boxName = getWordByWordBoxName(book);
        return await Hive.boxExists(boxName);
      }
    }
    return false;
  }

  static Future<void> setBookAsDownloaded(ResourcesModel book) async {
    // assert(book.type == ResourceType.word_by_word);
    final userBox = Hive.box("user");
    List<ResourcesModel> downloadedList = getDownloadedWordByWordBooks();

    if (!downloadedList.any((bMap) => bMap.fullPath == book.fullPath)) {
      downloadedList.add(book);
      await userBox.put(
        _userBoxKeyDownloaded,
        downloadedList.map((e) => e.toMap()).toList(),
      );
      log(
        "Book '${book.name}' marked as downloaded WbW.",
        name: "WbWFunction.setBookAsDownloaded",
      );
    }
  }

  static List<ResourcesModel> getDownloadedWordByWordBooks() {
    final userBox = Hive.box("user");
    List<dynamic> downloadedList = userBox.get(
      _userBoxKeyDownloaded,
      defaultValue: [],
    );
    return downloadedList
        .map((e) => ResourcesModel.fromMap(Map<String, dynamic>.from(e)))
        .where((b) => b.type == ResourceType.word_by_word)
        .toList();
  }

  // getLanguageInfo might be deprecated if all info now comes from ResourcesModel
  // static Map<String, dynamic>? getLanguageInfo(String languageKey) { ... }

  static Future<void> removeBookFromDownloaded(
    ResourcesModel bookToRemove,
  ) async {
    // assert(bookToRemove.type == ResourceType.word_by_word);

    List<ResourcesModel> downloadedMapList = getDownloadedWordByWordBooks();

    downloadedMapList.removeWhere(
      (bMap) => bMap.fullPath == bookToRemove.fullPath,
    );

    await Hive.box("user").put(_userBoxKeyDownloaded, downloadedMapList);

    final boxName = getWordByWordBoxName(bookToRemove);

    if (await Hive.boxExists(boxName)) {
      if (openedWordByWordBox?.name == boxName) {
        await close();
      }
      await Hive.deleteBoxFromDisk(boxName);
      log(
        "Deleted WbW box: $boxName",
        name: "WbWFunction.removeBookFromDownloaded",
      );
    }

    final selectedBook = getSelectedWordByWordBook();
    if (selectedBook != null &&
        selectedBook.fullPath == bookToRemove.fullPath &&
        selectedBook.language == bookToRemove.language) {
      await removeSelectedWordByWordBook();
    }
  }

  static Future<void> setSelectedWordByWordBook(ResourcesModel book) async {
    if (book.type != ResourceType.word_by_word) {
      log(
        "Cannot select non-wbw book '${book.name}' as WbW.",
        name: "WbWFunction.setSelectedWordByWordBook",
      );
      return;
    }
    final userBox = Hive.box("user");
    await userBox.put(_userBoxKeySelected, book.toMap());
    log(
      "Book '${book.name}' set as selected WbW.",
      name: "WbWFunction.setSelectedWordByWordBook",
    );
    await init(book: book);
  }

  static ResourcesModel? getSelectedWordByWordBook() {
    final userBox = Hive.box("user");
    final Map<String, dynamic>? bookMap = userBox
        .get(_userBoxKeySelected)
        ?.cast<String, dynamic>();
    if (bookMap != null) {
      final book = ResourcesModel.fromMap(bookMap);
      // Ensure it is indeed a wordByWord type
      if (book.type == ResourceType.word_by_word) return book;
      // If not, it's an invalid selection, log and return null (or clear it)
      log(
        "Selected WbW book is not of type wordByWord. Invalid selection.",
        name: "WbWFunction.getSelectedWordByWordBook",
      );
      // userBox.delete(_userBoxKeySelected); // Optionally clear invalid selection
      return null;
    }
    return null;
  }

  static Future<void> removeSelectedWordByWordBook() async {
    final userBox = Hive.box("user");
    await userBox.delete(_userBoxKeySelected);
    log(
      "Selected WbW book removed.",
      name: "WbWFunction.removeSelectedWordByWordBook",
    );
    await close();
  }

  static Future<bool> downloadResource({
    BuildContext? context,
    void Function(double? percentage, String processName)? onProgress,
    required ResourcesModel book,
    bool isSetupProcess = false,
  }) async {
    void updateProgress(double? percentage, String name) {
      if (onProgress != null) {
        onProgress(percentage, name);
      }
    }

    if (book.type != ResourceType.word_by_word) {
      log(
        "Download requested for non-WbW book: ${book.name}",
        name: "WbWFunction.downloadResource",
      );
      // Optionally notify cubit of an error here
      return false;
    }

    updateProgress(null, "Downloading WbW: ${book.name}");

    if (await isBookDownloaded(book)) {
      log(
        "WbW book '${book.name}' is already downloaded.",
        name: "WbWFunction.downloadResource",
      );
      final currentSelection = getSelectedWordByWordBook();
      if (isSetupProcess &&
          (currentSelection == null ||
              currentSelection.fullPath != book.fullPath)) {
        await setSelectedWordByWordBook(book);
      } else if (currentSelection?.fullPath == book.fullPath &&
          currentSelection?.language == book.language &&
          openedWordByWordBox == null) {
        await init(book: book);
      }
      return true;
    }

    // The 'filePath' now comes from book.fullPath
    // The 'wbwInfo' map ('name', etc.) comes from book.name, book.language etc.

    final boxName = getWordByWordBoxName(book);
    log(
      "Starting download for WbW '${book.name}', Box: $boxName, Path: ${book.fullPath}",
      name: "WbWFunction.downloadResource",
    );

    LazyBox? newBox;
    try {
      newBox = await Hive.openLazyBox(boxName);
    } catch (e) {
      log(
        "Error opening Hive box '$boxName' for WbW: $e. Trying to delete and reopen.",
        name: "WbWFunction.downloadResource",
      );
      try {
        await Hive.deleteBoxFromDisk(boxName);
        newBox = await Hive.openLazyBox(boxName);
      } catch (e2) {
        log(
          "Failed to open Hive box '$boxName' even after delete: $e2",
          name: "WbWFunction.downloadResource",
        );
        updateProgress(
          null,
          "Error preparing WbW storage for ${book.name}",
        );
        return false;
      }
    }

    try {
      final String downloadUrl = ApisUrls.base + book.fullPath;
      updateProgress(0.0, "Downloading WbW: ${book.name}");

      dio.Response response = await dio.Dio().get(
        downloadUrl,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            updateProgress(
              progress * 0.5,
              "Downloading WbW: ${book.name}",
            );
          }
        },
      );

      updateProgress(0.5, "Processing WbW: ${book.name}");
      Map<String, dynamic> jsonData = await compute(
        (data) =>
            jsonDecode(decodeBZip2String(data as String))
                as Map<String, dynamic>,
        response.data,
      );

      int totalEntries = jsonData.length;
      int processedEntries = 0;

      for (var entry in jsonData.entries) {
        await newBox.put(entry.key, entry.value);
        processedEntries++;
        if (processedEntries % 50 == 0 || processedEntries == totalEntries) {
          updateProgress(
            0.5 + (processedEntries / totalEntries * 0.5),
            "Processing WbW data for ${book.name}",
          );
        }
      }

      await newBox.put("meta_data", {
        ...book.toMap(), // Store all info from the ResourcesModel
        "download_date": DateTime.now().toIso8601String(),
      });

      await setBookAsDownloaded(book);
      final currentSelection = getSelectedWordByWordBook();
      if (isSetupProcess) {
        await setSelectedWordByWordBook(book);
      } else if (currentSelection?.fullPath == book.fullPath &&
          currentSelection?.language == book.language) {
        await init(book: book);
      }

      log(
        "WbW for '${book.name}' downloaded and processed successfully.",
        name: "WbWFunction.downloadResource",
      );
      updateProgress(1.0, "WbW: ${book.name} Downloaded");
      return true;
    } catch (e, s) {
      log(
        "Error downloading/processing WbW for '${book.name}': $e\n$s",
        name: "WbWFunction.downloadResource",
      );
      updateProgress(null, "Error downloading WbW for ${book.name}");
      if (newBox.isOpen) {
        await newBox.close();
      }
      await Hive.deleteBoxFromDisk(boxName);
      return false;
    }
  }

  static Future<List?> getAyahWordByWordData(String ayahKey) async {
    if (openedWordByWordBox != null && openedWordByWordBox!.isOpen) {
      if (openedWordByWordBox!.containsKey(ayahKey)) {
        var data = await openedWordByWordBox!.get(ayahKey);
        return data as List?; // Assuming it's stored as a List
      } else {
        log(
          "No WbW data found for ayah '$ayahKey' in the current box: ${openedWordByWordBox!.name}",
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
