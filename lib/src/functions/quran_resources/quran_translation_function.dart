import "dart:convert";
import "dart:developer";

import "package:dio/dio.dart" as dio;
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

import "../../api/apis_urls.dart";
import "../../resources/surah_info/info.dart";
import "../../screen/setup/cubit/download_progress_cubit_cubit.dart";
import "../encode_decode.dart";

class QuranTranslationFunction {
  static Box? openedTranslationBox;

  static Future<void> init({Map? translationInfo}) async {
    Map? translationSelection = translationInfo ?? getTranslationSelection();
    log(translationInfo.toString(), name: "getTranslationSelection");
    if (translationSelection != null) {
      openedTranslationBox = await Hive.openBox(
        getTranslationBoxName(
          translationLanguage: translationSelection["language"],
          translationBook: translationSelection["name"],
        ),
      );
    }else{
      log("translationSelection not found");
    }
  }

  static Future<bool> isAlreadyDownloaded(
    String translationBook,
    String translationLanguage,
  ) async {
    final userBox = Hive.box("user");
    List<Map> downloadedBooks = List<Map>.from(
      userBox.get("downloaded_translation_books", defaultValue: []),
    );
    for (Map book in downloadedBooks) {
      if (book["name"] == translationBook &&
          book["language"] == translationLanguage) {
        return true;
      }
    }
    return false;
  }

  static Future<void> setToListAlreadyDownloaded(
    String translationBook,
    String translationLanguage,
  ) async {
    final userBox = Hive.box("user");
    List<Map> downloadedBooks = List<Map>.from(
      userBox.get("downloaded_translation_books", defaultValue: []),
    );

    downloadedBooks.add({
      "name": translationBook,
      "language": translationLanguage,
    });
    await userBox.put("downloaded_translation_books", downloadedBooks);
  }

  static Future<void> setTranslationSelection(
    String translationBook,
    String translationLanguage,
  ) async {
    final userBox = Hive.box("user");
    await userBox.put("selected_translation", {
      "name": translationBook,
      "language": translationLanguage,
    });
  }

  static Map? getTranslationSelection() {
    final userBox = Hive.box("user");
    return userBox.get("selected_translation");
  }

  static String getTranslationBoxName({
    required String translationBook,
    required String translationLanguage,
  }) {
    // Sanitize the translationBook and translationLanguage to ensure they are valid file names
    String sanitizedBook = translationBook
        .split("/")
        .last
        .replaceAll(RegExp(r"[^\w\.-]"), "_");

    String sanitizedLanguage = translationLanguage.replaceAll(
      RegExp(r"[^\w\.-]"),
      "_",
    );
    return "translation_${sanitizedLanguage}_$sanitizedBook";
  }

  static Future<bool> downloadResources({
    required BuildContext context,
    String? translationBook,
    String? translationLanguage,
    bool? isSetupProcess,
  }) async {
    if (translationBook == null || translationLanguage == null) {
      return false;
    }
    final cubit = context.read<DownloadProgressCubitCubit>();

    if (await isAlreadyDownloaded(translationBook, translationLanguage)) {
      return true;
    }

    final translationBoxName = getTranslationBoxName(
      translationBook: translationBook,
      translationLanguage: translationLanguage,
    );

    log(translationBoxName, name: "Translation Box Name");

    final translationBox = await Hive.openBox(translationBoxName);

    try {
      String base = ApisUrls.base;
      cubit.updateProgress(null, "Downloading Translation");
      dio.Response response = await dio.Dio().get(base + translationBook);

      Map data = await compute(
        (message) => jsonDecode(decodeBZip2String(message)),
        response.data,
      );
      for (int i = 0; i < data.length; i++) {
        String key = data.keys.elementAt(i);
        await translationBox.put(key, data[key]);
        cubit.updateProgress(i / data.length, "Processing Translation");
      }
      await translationBox.put("meta_data", {
        "name": translationBook,
        "language": translationLanguage,
      });

      await setToListAlreadyDownloaded(translationBook, translationLanguage);
      if (isSetupProcess == true) {
        await setTranslationSelection(translationBook, translationLanguage);
      }
      if (availableSurahInfoInLang.contains(translationLanguage)) {
        cubit.updateProgress(null, "Downloading Surah's Information");
        await downloadSurahInfo(translationLanguage);
      }
      log("downloadResources", name: "downloadResources");
      await init();
      return true;
    } catch (e) {
      log(e.toString(), name: "downloadResources");
      return false;
    }
  }

  static Future<void> downloadSurahInfo(String? translationLanguage) async {
    final response = await dio.Dio().get(
      "${ApisUrls.base}quranic_universal_library/surah_info/$translationLanguage.txt",
    );
    if (response.statusCode == 200) {
      final box = await Hive.openBox("surah_info_$translationLanguage");
      Map data = await compute(
        (message) => jsonDecode(decodeBZip2String(message)),
        response.data,
      );
      for (final key in data.keys) {
        await box.put(key, data[key]);
      }
    }
  }

  static Map getTranslation(String ayahKey) {
    return openedTranslationBox?.get(ayahKey) ?? {"t": "Translation Not Found"};
  }

  static Map getMetaInfo() {
    return openedTranslationBox!.get("meta_data");
  }

  static Future<void> close() async {
    await openedTranslationBox?.close();
    openedTranslationBox = null;
  }
}
