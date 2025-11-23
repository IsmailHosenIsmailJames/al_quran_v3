import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../api/apis_urls.dart";
import "../../screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "../encode_decode.dart";

class QuranTafsirFunction {
  static const String selectedTafsirListKey = "selected_tafsir_list";
  static const String downloadedTafsirBooksKey = "downloaded_tafsir_books";

  static Future<void> init() async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    List<TafsirBookModel>? booksListToOpen = await getTafsirSelections();
    if (booksListToOpen == null) return;
    log(
      booksListToOpen.map((e) => e.toMap()).toString(),
      name: "QuranTafsirFunction.init",
    );

    if (booksListToOpen.isNotEmpty) {
      for (TafsirBookModel bookModel in booksListToOpen) {
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

  static String getTafsirBoxName({required TafsirBookModel tafsirBook}) {
    String sanitizedBook = tafsirBook.fullPath
        .split("/")
        .last
        .replaceAll(RegExp(r"[^\w\.-]"), "_");

    return "tafsir_${tafsirBook.language}_$sanitizedBook";
  }

  static Future<List<String>?> getSelectedTafsirBoxName() async {
    List<TafsirBookModel>? tafsirSelectionList = await getTafsirSelections();
    if (tafsirSelectionList != null) {
      return tafsirSelectionList
          .map((e) => getTafsirBoxName(tafsirBook: e))
          .toList();
    }
    return null;
  }

  static Future<bool> isAlreadyDownloaded(TafsirBookModel tafsirBook) async {
    List<TafsirBookModel> downloadedBooks = getDownloadedTafsirBooks();
    for (TafsirBookModel book in downloadedBooks) {
      if (book.fullPath == tafsirBook.fullPath) {
        final boxName = getTafsirBoxName(tafsirBook: tafsirBook);
        return await Hive.boxExists(boxName);
      }
    }
    return false;
  }

  static Future<void> setToListAlreadyDownloaded({
    required TafsirBookModel tafsirBook,
  }) async {
    final userBox = Hive.box("user");
    List<TafsirBookModel> downloadedBooks = getDownloadedTafsirBooks();
    if (!downloadedBooks.any((book) => book.fullPath == tafsirBook.fullPath)) {
      downloadedBooks.add(tafsirBook);
      await userBox.put(
        downloadedTafsirBooksKey,
        downloadedBooks.map((e) => e.toMap()).toList(),
      );
    }
  }

  static List<TafsirBookModel> getDownloadedTafsirBooks() {
    final userBox = Hive.box("user");
    return List<Map>.from(
          userBox.get(downloadedTafsirBooksKey, defaultValue: []),
        )
        .map((e) => TafsirBookModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> removeFromListAlreadyDownloaded(
    TafsirBookModel tafsirBook,
  ) async {
    final userBox = Hive.box("user");
    List<TafsirBookModel> downloadedBooks = getDownloadedTafsirBooks();
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

  static Future<void> setTafsirSelection(TafsirBookModel tafsirBook) async {
    final userBox = Hive.box("user");
    List<TafsirBookModel> selectedTafsirList =
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

  static Future<void> removeTafsirSelection(TafsirBookModel tafsirBook) async {
    final userBox = Hive.box("user");
    List<TafsirBookModel> selectedTafsirList =
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

  static Future<List<TafsirBookModel>?> getTafsirSelections() async {
    final userBox = Hive.box("user");
    final Map<String, dynamic>? previousBookMap =
        userBox.get("selected_tafsir")?.cast<String, dynamic>();

    if (previousBookMap != null) {
      await userBox.put(selectedTafsirListKey, [previousBookMap]);
      await userBox.delete("selected_tafsir");
    }

    List? booksList = userBox.get(selectedTafsirListKey);
    List<TafsirBookModel>? bookListModel =
        booksList
            ?.map((e) => TafsirBookModel.fromMap(Map<String, dynamic>.from(e)))
            .toList();

    return bookListModel;
  }

  static Future<bool> downloadResources({
    required BuildContext context,
    required TafsirBookModel tafsirBook,
    bool isSetupProcess = false,
  }) async {
    final cubit = context.read<ResourcesProgressCubit>();
    cubit.updateProgress(null, "Downloading Tafsir: ${tafsirBook.name}");

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
        cubit.updateProgress(null, "Error preparing Tafsir storage");
        return false;
      }
    }

    try {
      String base = ApisUrls.base;
      cubit.updateProgress(0.0, "Downloading: ${tafsirBook.name}");
      dio.Response response = await dio.Dio().get(
        base + tafsirBook.fullPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            cubit.updateProgress(
              progress * 0.5,
              "Downloading: ${tafsirBook.name}",
            );
          }
        },
      );

      cubit.updateProgress(0.5, "Processing: ${tafsirBook.name}");
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
          cubit.updateProgress(
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
      cubit.updateProgress(1.0, "Downloaded: ${tafsirBook.name}");
      return true;
    } catch (e, s) {
      log(
        "Error downloading or processing Tafsir '${tafsirBook.name}': $e\n$s",
        name: "downloadResources",
      );
      cubit.updateProgress(null, "Error downloading Tafsir");
      if (tafsirBox.isOpen) {
        await tafsirBox.close();
      }
      await Hive.deleteBoxFromDisk(tafsirBoxName);
      return false;
    }
  }

  static Future<List<TafsirOfAyah>> getTafsir(String ayahKey) async {
    final List<TafsirOfAyah> toReturn = [];
    List<TafsirBookModel>? selectedBooks = await getTafsirSelections() ?? [];

    for (TafsirBookModel bookModel in selectedBooks) {
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
    TafsirBookModel tafsirBook,
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

  static Future<Map?> getMetaInfoAsync(TafsirBookModel tafsirBook) async {
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
    List<TafsirBookModel> selectedBooks = getDownloadedTafsirBooks();
    selectedBooks.addAll(await getTafsirSelections() ?? []);
    for (TafsirBookModel bookModel in selectedBooks) {
      String boxName = getTafsirBoxName(tafsirBook: bookModel);
      if (Hive.isBoxOpen(boxName)) {
        await Hive.lazyBox(boxName).close();
      }
    }
  }
}

class TafsirOfAyah {
  final Map<String, dynamic> tafsir;
  final TafsirBookModel bookInfo;

  TafsirOfAyah({required this.tafsir, required this.bookInfo});
}
