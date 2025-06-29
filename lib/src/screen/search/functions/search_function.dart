// just return ayah key for now
import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/search/models/search_catagory.dart";
import "package:al_quran_v3/src/screen/search/models/search_options.dart";
import "package:al_quran_v3/src/screen/search/models/search_result_model.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:flutter/foundation.dart";

class SearchFunction {
  static Future<List<SearchResultModel>> search({
    required String searchQuery,
    required SearchFields searchField,
    required SearchCatagory searchCatagory,
    required QuranScriptType quranScriptType,
  }) async {
    List<SearchResultModel> result = [];

    switch (searchField) {
      case SearchFields.translation:
        result = await searchOnTranslation(searchQuery, quranScriptType);
        break;
      case SearchFields.tafsir:
        result = await searchOnTafsir(searchQuery, quranScriptType);
        break;
      case SearchFields.quran:
        result = await searchOnQuran(
          searchQuery,
          quranScriptType,
          searchCatagory,
        );
        break;
    }

    return result;
  }

  static Future<List<SearchResultModel>> searchOnQuran(
    String searchQuery,
    QuranScriptType quranScriptType,
    SearchCatagory searchCatagory,
  ) async {
    List<SearchResultModel> result = [];

    switch (quranScriptType) {
      case QuranScriptType.tajweed:
        result = await compute((message) {
          return searchInQuranScript(message, QuranScriptType.tajweed);
        }, searchCatagory);
        break;
      case QuranScriptType.uthmani:
        result = await compute((message) {
          return searchInQuranScript(message, QuranScriptType.uthmani);
        }, searchCatagory);
        break;
      case QuranScriptType.indopak:
        result = await compute((message) {
          return searchInQuranScript(message, QuranScriptType.indopak);
        }, searchCatagory);
        break;
    }

    return result;
  }

  static List<SearchResultModel> searchInQuranScript(
    SearchCatagory searchCatagory,
    QuranScriptType quranScriptType,
  ) {
    Map<String, dynamic> quranScript = tajweedScript;
    switch (quranScriptType) {
      case QuranScriptType.tajweed:
        quranScript = tajweedScript;
        break;
      case QuranScriptType.uthmani:
        quranScript = uthmaniScript;
        break;
      case QuranScriptType.indopak:
        quranScript = indopakScript;
        break;
    }

    log(quranScript.length.toString(), name: "xyz");
    return [];
  }

  static Future<List<SearchResultModel>> searchOnTranslation(
    String searchQuery,
    QuranScriptType quranScriptType,
  ) async {
    return [];
  }

  static Future<List<SearchResultModel>> searchOnTafsir(
    String searchQuery,
    QuranScriptType quranScriptType,
  ) async {
    return [];
  }
}
