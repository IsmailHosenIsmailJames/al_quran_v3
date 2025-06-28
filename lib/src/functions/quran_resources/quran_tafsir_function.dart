import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

import "../../api/apis_urls.dart";
import "../../screen/setup/cubit/resources_progress_cubit_cubit.dart";
import "../encode_decode.dart";

class QuranTafsirFunction {
  static LazyBox? openedTafsirBox;

  static Future<void> init({TafsirBookModel? tafsirBook}) async {
    // Ensure the user box is open
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    TafsirBookModel? tafsirSelection = tafsirBook ?? getTafsirSelection();
    log(tafsirSelection.toString(), name: "getTafsirSelection");
    if (tafsirSelection != null) {
      final boxName = getTafsirBoxName(tafsirBook: tafsirSelection);
      if (await Hive.boxExists(boxName)) {
        openedTafsirBox = await Hive.openLazyBox(boxName);
        log("Tafsir box '$boxName' opened.", name: "QuranTafsirFunction.init");
      } else {
        log(
          "Tafsir box '$boxName' does not exist. Cannot open.",
          name: "QuranTafsirFunction.init",
        );
        // Optionally, try to download if it's selected but not found
      }
    } else {
      log(
        "Tafsir selection not found or incomplete.",
        name: "QuranTafsirFunction.init",
      );
    }
  }

  static String getTafsirBoxName({required TafsirBookModel tafsirBook}) {
    // Sanitize the tafsirFullPath and languageCode to ensure they are valid box names
    String sanitizedBook = tafsirBook.fullPath
        .split("/")
        .last
        .replaceAll(RegExp(r"[^\w\.-]"), "_");

    return "tafsir_${tafsirBook.language}_$sanitizedBook";
  }

  static String? getSelectedTafsirBoxName() {
    TafsirBookModel? tafsirSelection = getTafsirSelection();
    if (tafsirSelection != null) {
      final boxName = getTafsirBoxName(tafsirBook: tafsirSelection);
      return boxName;
    }
    return null;
  }

  static Future<bool> isAlreadyDownloaded(TafsirBookModel tafsirBook) async {
    List<TafsirBookModel> downloadedBooks = getDownloadedTafsirBooks();
    for (TafsirBookModel book in downloadedBooks) {
      if (book.fullPath == tafsirBook.fullPath) {
        // Additionally verify if the box actually exists
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
    // Avoid duplicates
    if (!downloadedBooks.any((book) => book.fullPath == tafsirBook.fullPath)) {
      downloadedBooks.add(tafsirBook);
      await userBox.put(
        "downloaded_tafsir_books",
        downloadedBooks.map((e) => e.toMap()).toList(),
      );
    }
  }

  static List<TafsirBookModel> getDownloadedTafsirBooks() {
    final userBox = Hive.box("user");
    return List<Map>.from(
          userBox.get("downloaded_tafsir_books", defaultValue: []),
        )
        .map((e) => TafsirBookModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  static Future<void> removeTafsirFromListDownloaded(
    TafsirBookModel tafsirBook,
    String languageCode,
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
        "downloaded_tafsir_books",
        downloadedBooks.map((e) => e.toMap()).toList(),
      );
    }

    // Also delete the Hive box for this tafsir
    final tafsirBoxName = getTafsirBoxName(tafsirBook: tafsirBook);
    if (await Hive.boxExists(tafsirBoxName)) {
      // Close the box if it's the currently opened one
      if (openedTafsirBox?.name == tafsirBoxName) {
        await close();
      }
      await Hive.deleteBoxFromDisk(tafsirBoxName);
      log(
        "Deleted Tafsir box: $tafsirBoxName",
        name: "removeTafsirFromListDownloaded",
      );
    }
  }

  static Future<void> setTafsirSelection(TafsirBookModel tafsirBook) async {
    final userBox = Hive.box("user");
    await userBox.put("selected_tafsir", tafsirBook.toMap());
    // Re-initialize to open the newly selected tafsir
    await init(tafsirBook: tafsirBook);
  }

  static TafsirBookModel? getTafsirSelection() {
    final userBox = Hive.box("user");
    return TafsirBookModel.fromMap(
      Map<String, dynamic>.from(userBox.get("selected_tafsir")),
    );
  }

  static Future<void> removeTafsirSelection() async {
    final userBox = Hive.box("user");
    await userBox.delete("selected_tafsir");
    await close(); // Close any currently open tafsir box
    log("Tafsir selection removed.", name: "removeTafsirSelection");
  }

  static Future<bool> downloadResources({
    required BuildContext context,
    TafsirBookModel? tafsirBook,
    bool isSetupProcess = false, // Standardized parameter name
  }) async {
    if (tafsirBook == null) {
      log("Tafsir book or language is null.", name: "downloadResources");
      return false;
    }

    final cubit = context.read<ResourcesProgressCubitCubit>();

    if (await isAlreadyDownloaded(tafsirBook)) {
      log(
        "Tafsir '${tafsirBook.fullPath}'  is already downloaded.",
        name: "downloadResources",
      );
      if (isSetupProcess) {
        // Also set as current selection if in setup
        await setTafsirSelection(tafsirBook);
      }
      await init(); // Ensure it's initialized if it was already downloaded
      return true;
    }

    final tafsirBoxName = getTafsirBoxName(tafsirBook: tafsirBook);

    log(
      "Starting download for Tafsir Box: $tafsirBoxName",
      name: "downloadResources",
    );

    LazyBox tafsirBox;
    try {
      // Open the box before writing to it. If it exists from a partial download, this will use it.
      tafsirBox = await Hive.openLazyBox(tafsirBoxName);
    } catch (e) {
      log(
        "Error opening LazyBox '$tafsirBoxName': $e. Trying to delete and reopen.",
        name: "downloadResources",
      );
      try {
        await Hive.deleteBoxFromDisk(
          tafsirBoxName,
        ); // Attempt to clean up corrupted box
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

    // try {
    String base = ApisUrls.base;
    cubit.updateProgress(null, "Downloading Tafsir");
    dio.Response response = await dio.Dio().get(
      base + tafsirBook.fullPath,
    ); // Ensure ApisUrls.base ends with '/' or tafsirFullPath starts with one

    Map data = await compute(
      (message) => jsonDecode(decodeBZip2String(message)),
      response.data,
    );

    // It's generally faster to use putAll for many entries if Hive supports it directly with LazyBox
    // However, for progress reporting, iterating is fine.
    int totalEntries = data.length;
    int processedEntries = 0;
    for (String key in data.keys) {
      await tafsirBox.put(key, data[key]);
      processedEntries++;
      if (processedEntries % 50 == 0 || processedEntries == totalEntries) {
        // Update progress periodically
        cubit.updateProgress(
          processedEntries / totalEntries,
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
    await init(); // Initialize with the new data
    return true;
  }

  static Future<Map?> getTafsir(String ayahKey) async {
    if (openedTafsirBox == null || !openedTafsirBox!.isOpen) {
      log("Tafsir box is not open or available.", name: "getTafsir");

      TafsirBookModel? currentSelection = getTafsirSelection();
      if (currentSelection != null) {
        await init(tafsirBook: currentSelection);
        if (openedTafsirBox == null || !openedTafsirBox!.isOpen) {
          return {"error": "Tafsir not available."};
        }
      } else {
        return {"error": "Tafsir not selected or available."};
      }
    }
    try {
      return await openedTafsirBox!.get(ayahKey, defaultValue: null);
    } catch (e) {
      log("Error fetching Tafsir for $ayahKey: $e", name: "getTafsir");
      return {"error": "Error fetching Tafsir."};
    }
  }

  static Future<Map?> getMetaInfoAsync() async {
    if (openedTafsirBox != null && openedTafsirBox!.isOpen) {
      try {
        final data = await openedTafsirBox!.get("meta_data");
        return data as Map?;
      } catch (e) {
        log("Error fetching meta_data: $e", name: "getMetaInfoAsync");
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
    if (openedTafsirBox != null && openedTafsirBox!.isOpen) {
      await openedTafsirBox!.close();
      log(
        "Tafsir box '${openedTafsirBox!.name}' closed.",
        name: "QuranTafsirFunction.close",
      );
    }
    openedTafsirBox = null;
  }
}
