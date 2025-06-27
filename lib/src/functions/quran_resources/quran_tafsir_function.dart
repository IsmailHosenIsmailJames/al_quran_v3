import "dart:convert";
import "dart:developer";

import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

import "../../api/apis_urls.dart";
import "../../screen/setup/cubit/download_progress_cubit_cubit.dart";
import "../encode_decode.dart";

class QuranTafsirFunction {
  static LazyBox? openedTafsirBox;

  static Future<void> init({Map? tafsirInfo}) async {
    // Ensure the user box is open
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
    Map? tafsirSelection = tafsirInfo ?? getTafsirSelection();
    log(tafsirSelection.toString(), name: "getTafsirSelection");
    if (tafsirSelection != null &&
        tafsirSelection["name"] != null &&
        tafsirSelection["language"] != null) {
      final boxName = getTafsirBoxName(
        tafsirBook: tafsirSelection["name"],
        tafsirLanguage: tafsirSelection["language"],
      );
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

  static String getTafsirBoxName({
    required String tafsirBook,
    required String tafsirLanguage,
  }) {
    // Sanitize the tafsirBook and tafsirLanguage to ensure they are valid box names
    String sanitizedBook = tafsirBook
        .split("/")
        .last
        .replaceAll(RegExp(r"[^\w\.-]"), "_");
    String sanitizedLanguage = tafsirLanguage.replaceAll(
      RegExp(r"[^\w\.-]"),
      "_",
    );
    return "tafsir_${sanitizedLanguage}_$sanitizedBook";
  }

  static Future<bool> isAlreadyDownloaded(
    String tafsirBook,
    String tafsirLanguage,
  ) async {
    final userBox = Hive.box("user");
    List<Map> downloadedBooks = List<Map>.from(
      userBox.get("downloaded_tafsir_books", defaultValue: []),
    );
    for (Map book in downloadedBooks) {
      if (book["name"] == tafsirBook && book["language"] == tafsirLanguage) {
        // Additionally verify if the box actually exists
        final boxName = getTafsirBoxName(
          tafsirBook: tafsirBook,
          tafsirLanguage: tafsirLanguage,
        );
        return await Hive.boxExists(boxName);
      }
    }
    return false;
  }

  static Future<void> setToListAlreadyDownloaded(
    String tafsirBook,
    String tafsirLanguage,
  ) async {
    final userBox = Hive.box("user");
    List<Map> downloadedBooks = List<Map>.from(
      userBox.get("downloaded_tafsir_books", defaultValue: []),
    );
    // Avoid duplicates
    if (!downloadedBooks.any(
      (book) =>
          book["name"] == tafsirBook && book["language"] == tafsirLanguage,
    )) {
      downloadedBooks.add({"name": tafsirBook, "language": tafsirLanguage});
      await userBox.put("downloaded_tafsir_books", downloadedBooks);
    }
  }

  static List<Map> getDownloadedTafsirBooks() {
    final userBox = Hive.box("user");
    return List<Map>.from(
      userBox.get("downloaded_tafsir_books", defaultValue: []),
    );
  }

  static Future<void> removeTafsirFromListDownloaded(
    String tafsirBook,
    String tafsirLanguage,
  ) async {
    final userBox = Hive.box("user");
    List<Map> downloadedBooks = List<Map>.from(
      userBox.get("downloaded_tafsir_books", defaultValue: []),
    );
    bool changed = false;
    downloadedBooks.removeWhere((book) {
      if (book["name"] == tafsirBook && book["language"] == tafsirLanguage) {
        changed = true;
        return true;
      }
      return false;
    });

    if (changed) {
      await userBox.put("downloaded_tafsir_books", downloadedBooks);
    }

    // Also delete the Hive box for this tafsir
    final tafsirBoxName = getTafsirBoxName(
      tafsirBook: tafsirBook,
      tafsirLanguage: tafsirLanguage,
    );
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

  static Future<void> setTafsirSelection(
    String tafsirBook,
    String tafsirLanguage,
  ) async {
    final userBox = Hive.box("user");
    await userBox.put("selected_tafsir", {
      "name": tafsirBook,
      "language": tafsirLanguage,
    });
    // Re-initialize to open the newly selected tafsir
    await init(tafsirInfo: {"name": tafsirBook, "language": tafsirLanguage});
  }

  static Map? getTafsirSelection() {
    final userBox = Hive.box("user");
    return userBox.get("selected_tafsir");
  }

  static Future<void> removeTafsirSelection() async {
    final userBox = Hive.box("user");
    await userBox.delete("selected_tafsir");
    await close(); // Close any currently open tafsir box
    log("Tafsir selection removed.", name: "removeTafsirSelection");
  }

  static Future<bool> downloadResources({
    required BuildContext context,
    String? tafsirBook,
    String? tafsirLanguage,
    bool isSetupProcess = false, // Standardized parameter name
  }) async {
    if (tafsirBook == null || tafsirLanguage == null) {
      log("Tafsir book or language is null.", name: "downloadResources");
      return false;
    }

    final cubit = context.read<DownloadProgressCubitCubit>();

    if (await isAlreadyDownloaded(tafsirBook, tafsirLanguage)) {
      log(
        "Tafsir '$tafsirBook' for language '$tafsirLanguage' is already downloaded.",
        name: "downloadResources",
      );
      if (isSetupProcess) {
        // Also set as current selection if in setup
        await setTafsirSelection(tafsirBook, tafsirLanguage);
      }
      await init(); // Ensure it's initialized if it was already downloaded
      return true;
    }

    final tafsirBoxName = getTafsirBoxName(
      tafsirBook: tafsirBook,
      tafsirLanguage: tafsirLanguage,
    );

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

    try {
      String base = ApisUrls.base;
      cubit.updateProgress(null, "Downloading Tafsir");
      dio.Response response = await dio.Dio().get(
        base + tafsirBook,
      ); // Ensure ApisUrls.base ends with '/' or tafsirBook starts with one

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

      await tafsirBox.put("meta_data", {
        "name": tafsirBook,
        "language": tafsirLanguage,
        "download_date": DateTime.now().toIso8601String(),
      });

      await setToListAlreadyDownloaded(tafsirBook, tafsirLanguage);
      if (isSetupProcess) {
        await setTafsirSelection(tafsirBook, tafsirLanguage);
      }

      log(
        "Tafsir '$tafsirBook' downloaded and processed successfully.",
        name: "downloadResources",
      );
      await init(); // Initialize with the new data
      return true;
    } catch (e, s) {
      log(
        "Error downloading or processing Tafsir '$tafsirBook': $e\n$s",
        name: "downloadResources",
      );
      cubit.updateProgress(null, "Error downloading Tafsir");
      return false;
    }
  }

  static Future<Map?> getTafsir(String ayahKey) async {
    if (openedTafsirBox == null || !openedTafsirBox!.isOpen) {
      log("Tafsir box is not open or available.", name: "getTafsir");

      Map? currentSelection = getTafsirSelection();
      if (currentSelection != null) {
        await init(tafsirInfo: currentSelection);
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

  static Map? getMetaInfo() {
    if (openedTafsirBox != null && openedTafsirBox!.isOpen) {
      // This will be slow with LazyBox if not awaited.
      // For frequent access, consider loading meta_data during init.
      // However, Hive's get is synchronous if the key is in memory.
      // Let's assume it might not be and make it async to be safe.
      // For LazyBox, all reads are async.
      // return openedTafsirBox!.get("meta_data") as Map?; // This won't work directly
      // Instead, you'd have to make this async or load meta_data into a variable at init
      log(
        "getMetaInfo requires an async call for LazyBox or pre-loading meta_data.",
        name: "getMetaInfo",
      );
      return null; // Or implement an async version: static Future<Map?> getMetaInfoAsync() async {...}
    }
    log("Tafsir box is not open. Cannot get meta info.", name: "getMetaInfo");
    return null;
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
