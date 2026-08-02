import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../api/apis_urls.dart";
import "../encode_decode.dart";

class QuranTafsirFunction {
  static const String selectedTafsirListKey = "selected_tafsir_list";
  static const String downloadedTafsirBooksKey = "downloaded_tafsir_books";

  static Future<void> init() async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    List<ResourcesModel>? booksListToOpen = await getTafsirSelections();
    if (booksListToOpen == null) return;
    log(
      booksListToOpen.map((e) => e.toMap()).toString(),
      name: "QuranTafsirFunction.init",
    );

    if (booksListToOpen.isNotEmpty) {
      for (ResourcesModel bookModel in booksListToOpen) {
        await Hive.openLazyBox(getTafsirBoxName(tafsirBook: bookModel));
      }
    } else {
      log(
        "No tafsir selection found for init.",
        name: "QuranTafsirFunction.init",
      );
      await close(); // Ensure any open box is closed if nothing is selected
    }
  }

  static String getTafsirBoxName({required ResourcesModel tafsirBook}) {
    String sanitizedBook = tafsirBook.fullPath
        .split("/")
        .last
        .replaceAll(RegExp(r"[^\w\.-]"), "_");

    return "tafsir_${tafsirBook.language}_$sanitizedBook";
  }

  static Future<List<String>?> getSelectedTafsirBoxName() async {
    List<ResourcesModel>? tafsirSelectionList = await getTafsirSelections();
    if (tafsirSelectionList != null) {
      return tafsirSelectionList
          .map((e) => getTafsirBoxName(tafsirBook: e))
          .toList();
    }
    return null;
  }

  static Future<bool> isAlreadyDownloaded(ResourcesModel tafsirBook) async {
    List<ResourcesModel> downloadedBooks = getDownloadedTafsirBooks();
    for (ResourcesModel book in downloadedBooks) {
      if (book.fullPath == tafsirBook.fullPath) {
        final boxName = getTafsirBoxName(tafsirBook: tafsirBook);
        return await Hive.boxExists(boxName);
      }
    }
    return false;
  }

  static Future<void> setToListAlreadyDownloaded({
    required ResourcesModel tafsirBook,
  }) async {
    final userBox = Hive.box("user");
    List<ResourcesModel> downloadedBooks = getDownloadedTafsirBooks();
    if (!downloadedBooks.any((book) => book.fullPath == tafsirBook.fullPath)) {
      downloadedBooks.add(tafsirBook);
      await userBox.put(
        downloadedTafsirBooksKey,
        downloadedBooks.map((e) => e.toMap()).toList(),
      );
    }
  }

  static List<ResourcesModel> getDownloadedTafsirBooks() {
    final userBox = Hive.box("user");
    return List<Map>.from(
      userBox.get(downloadedTafsirBooksKey, defaultValue: []),
    ).map((e) => ResourcesModel.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  static Future<void> removeFromListAlreadyDownloaded(
    ResourcesModel tafsirBook,
  ) async {
    final userBox = Hive.box("user");
    List<ResourcesModel> downloadedBooks = getDownloadedTafsirBooks();
    bool changed = false;
    downloadedBooks.removeWhere((book) {
      if (tafsirBook.fullPath == book.fullPath) {
        changed = true;
        return true;
      }
      return false;
    });

    if (changed) {
      await userBox.put(
        downloadedTafsirBooksKey,
        downloadedBooks.map((e) => e.toMap()).toList(),
      );
    }

    final tafsirBoxName = getTafsirBoxName(tafsirBook: tafsirBook);
    if (await Hive.boxExists(tafsirBoxName)) {
      await Hive.deleteBoxFromDisk(tafsirBoxName);
      log(
        "Deleted Tafsir box: $tafsirBoxName",
        name: "removeFromListAlreadyDownloaded",
      );
    }
    await removeTafsirSelection(tafsirBook);
  }

  static Future<void> setTafsirSelection(ResourcesModel tafsirBook) async {
    final userBox = Hive.box("user");
    List<ResourcesModel> selectedTafsirList =
        (await getTafsirSelections()) ?? [];
    if (!selectedTafsirList.any((b) => b.fullPath == tafsirBook.fullPath)) {
      selectedTafsirList.add(tafsirBook);
      await userBox.put(
        selectedTafsirListKey,
        selectedTafsirList.map((e) => e.toMap()).toList(),
      );
    }
    await init();
  }

  static Future<void> removeTafsirSelection(ResourcesModel tafsirBook) async {
    final userBox = Hive.box("user");
    List<ResourcesModel> selectedTafsirList =
        (await getTafsirSelections()) ?? [];
    selectedTafsirList.removeWhere(
      (element) => element.fullPath == tafsirBook.fullPath,
    );
    await userBox.put(
      selectedTafsirListKey,
      selectedTafsirList.map((e) => e.toMap()).toList(),
    );
    await init();
  }

  static Future<List<ResourcesModel>?> getTafsirSelections() async {
    final userBox = Hive.box("user");
    final Map<String, dynamic>? previousBookMap = userBox
        .get("selected_tafsir")
        ?.cast<String, dynamic>();

    if (previousBookMap != null) {
      await userBox.put(selectedTafsirListKey, [previousBookMap]);
      await userBox.delete("selected_tafsir");
    }

    List? booksList = userBox.get(selectedTafsirListKey);
    List<ResourcesModel>? bookListModel = booksList
        ?.map((e) => ResourcesModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    return bookListModel;
  }

  static Future<bool> downloadResources({
    BuildContext? context,
    void Function(double? percentage, String processName)? onProgress,
    required ResourcesModel tafsirBook,
    bool isSetupProcess = false,
  }) async {
    void updateProgress(double? percentage, String name) {
      if (onProgress != null) {
        onProgress(percentage, name);
      }
    }

    updateProgress(null, "Downloading Tafsir: ${tafsirBook.name}");

    if (await isAlreadyDownloaded(tafsirBook)) {
      log(
        "Tafsir '${tafsirBook.fullPath}' is already downloaded.",
        name: "downloadResources",
      );
      if (isSetupProcess) {
        await setTafsirSelection(tafsirBook);
      }
      await init();
      return true;
    }

    final tafsirBoxName = getTafsirBoxName(tafsirBook: tafsirBook);

    log(
      "Starting download for Tafsir Box: $tafsirBoxName",
      name: "downloadResources",
    );

    LazyBox tafsirBox;
    try {
      tafsirBox = await Hive.openLazyBox(tafsirBoxName);
    } catch (e) {
      log(
        "Error opening LazyBox '$tafsirBoxName': $e. Trying to delete and reopen.",
        name: "downloadResources",
      );
      try {
        await Hive.deleteBoxFromDisk(tafsirBoxName);
        tafsirBox = await Hive.openLazyBox(tafsirBoxName);
      } catch (e2) {
        log(
          "Failed to open LazyBox '$tafsirBoxName' even after delete: $e2",
          name: "downloadResources",
        );
        updateProgress(null, "Error preparing Tafsir storage");
        return false;
      }
    }

    try {
      String base = ApisUrls.base;
      updateProgress(0.0, "Downloading: ${tafsirBook.name}");
      dio.Response response = await dio.Dio().get(
        base + tafsirBook.fullPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            updateProgress(
              progress * 0.5,
              "Downloading: ${tafsirBook.name}",
            );
          }
        },
      );

      updateProgress(0.5, "Processing: ${tafsirBook.name}");
      Map data = await compute(
        (message) => jsonDecode(decodeBZip2String(message)),
        response.data,
      );

      int totalEntries = data.length;
      int processedEntries = 0;
      for (String key in data.keys) {
        await tafsirBox.put(key, data[key]);
        processedEntries++;
        if (processedEntries % 50 == 0 || processedEntries == totalEntries) {
          updateProgress(
            0.5 + (processedEntries / totalEntries * 0.5),
            "Processing Tafsir",
          );
        }
      }

      await tafsirBox.put("meta_data", tafsirBook.toMap());

      await setToListAlreadyDownloaded(tafsirBook: tafsirBook);
      if (isSetupProcess) {
        await setTafsirSelection(tafsirBook);
      }

      log(
        "Tafsir '${tafsirBook.fullPath}' downloaded and processed successfully.",
        name: "downloadResources",
      );
      await init();
      updateProgress(1.0, "Downloaded: ${tafsirBook.name}");
      return true;
    } catch (e, s) {
      log(
        "Error downloading or processing Tafsir '${tafsirBook.name}': $e\n$s",
        name: "downloadResources",
      );
      updateProgress(null, "Error downloading Tafsir");
      if (tafsirBox.isOpen) {
        await tafsirBox.close();
      }
      await Hive.deleteBoxFromDisk(tafsirBoxName);
      return false;
    }
  }

  static Future<List<TafsirOfAyah>> getTafsir(String ayahKey) async {
    final List<TafsirOfAyah> toReturn = [];
    List<ResourcesModel>? selectedBooks = await getTafsirSelections() ?? [];

    for (ResourcesModel bookModel in selectedBooks) {
      String boxName = getTafsirBoxName(tafsirBook: bookModel);
      LazyBox? tafsirBox;
      if (!Hive.isBoxOpen(boxName)) {
        tafsirBox = await Hive.openLazyBox(boxName);
      } else {
        tafsirBox = Hive.lazyBox(boxName);
      }
      final tafsirData = await tafsirBox.get(ayahKey, defaultValue: null);
      if (tafsirData != null) {
        toReturn.add(
          TafsirOfAyah(
            tafsir: Map<String, dynamic>.from(tafsirData),
            bookInfo: bookModel,
          ),
        );
      }
    }
    return toReturn;
  }

  static Future<TafsirOfAyah?> getTafsirForBook(
    ResourcesModel tafsirBook,
    String ayahKey,
  ) async {
    String boxName = getTafsirBoxName(tafsirBook: tafsirBook);
    LazyBox? tafsirBox;
    if (!Hive.isBoxOpen(boxName)) {
      tafsirBox = await Hive.openLazyBox(boxName);
    } else {
      tafsirBox = Hive.lazyBox(boxName);
    }
    final tafsirData = await tafsirBox.get(ayahKey, defaultValue: null);
    if (tafsirData != null) {
      return TafsirOfAyah(
        tafsir: Map<String, dynamic>.from(tafsirData),
        bookInfo: tafsirBook,
      );
    }
    return null;
  }

  static Future<Map?> getMetaInfoAsync(ResourcesModel tafsirBook) async {
    final boxName = getTafsirBoxName(tafsirBook: tafsirBook);
    if (await Hive.boxExists(boxName)) {
      final box = await Hive.openLazyBox(boxName);
      try {
        final data = await box.get("meta_data");
        await box.close();
        return data as Map?;
      } catch (e) {
        log("Error fetching meta_data: $e", name: "getMetaInfoAsync");
        await box.close();
        return null;
      }
    }
    log(
      "Tafsir box is not open. Cannot get meta info.",
      name: "getMetaInfoAsync",
    );
    return null;
  }

  static Future<void> close() async {
    List<ResourcesModel> selectedBooks = getDownloadedTafsirBooks();
    selectedBooks.addAll(await getTafsirSelections() ?? []);
    for (ResourcesModel bookModel in selectedBooks) {
      String boxName = getTafsirBoxName(tafsirBook: bookModel);
      if (Hive.isBoxOpen(boxName)) {
        await Hive.lazyBox(boxName).close();
      }
    }
  }
}

class TafsirOfAyah {
  final Map<String, dynamic> tafsir;
  final ResourcesModel bookInfo;

  TafsirOfAyah({required this.tafsir, required this.bookInfo});
}
