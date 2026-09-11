import "dart:convert";

import "package:al_quran_v3/src/core/resources/quran_resources/quran_ayah_count.dart";
import "package:al_quran_v3/src/features/tajweed_guide/domain/utils/tajweed_rules.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:dartx/dartx.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";

import "package:al_quran_v3/src/core/resources/quran_resources/ayah_word_length_map.dart";

Map<String, dynamic> _parseScriptJson(String jsonString) {
  return Map<String, dynamic>.from(jsonDecode(jsonString));
}

class QuranScriptFunction {
  static final Map<QuranScriptType, Map<String, dynamic>> _scripts = {};
  static QuranScriptType? currentScript;

  static Map get quranScriptMap =>
      _scripts[currentScript] ??
      _scripts[QuranScriptType.uthmani] ??
      _scripts[QuranScriptType.indopak] ??
      {};

  static set quranScriptMap(Map map) {
    if (currentScript != null) {
      _scripts[currentScript!] = Map<String, dynamic>.from(map);
    }
  }

  static Map<String, dynamic> getScriptMap([QuranScriptType? type]) {
    return _scripts[type ?? currentScript ?? QuranScriptType.uthmani] ?? {};
  }

  static Future<void> loadScript(
    QuranScriptType scriptType, {
    bool setCurrent = true,
  }) async {
    if (setCurrent) {
      currentScript = scriptType;
    }
    if (_scripts.containsKey(scriptType) && _scripts[scriptType]!.isNotEmpty) {
      return;
    }
    String scriptAssetName = "";
    switch (scriptType) {
      case QuranScriptType.indopak:
        scriptAssetName = "assets/quran_script/Indopak.json";
        break;
      case QuranScriptType.uthmani:
        scriptAssetName = "assets/quran_script/QPC_Hafs_Tajweed_Compress.json";
        break;
    }
    final value = await rootBundle.loadString(scriptAssetName);
    _scripts[scriptType] = await compute(_parseScriptJson, value);
  }

  static Future<void> initAllScripts({QuranScriptType? initialScript}) async {
    currentScript = initialScript ?? QuranScriptType.uthmani;
    await Future.wait([
      loadScript(QuranScriptType.uthmani, setCurrent: false),
      loadScript(QuranScriptType.indopak, setCurrent: false),
    ]);
  }

  static List<String> getWordListOfAyah(
    QuranScriptType type,
    String surah,
    String ayah, {
    required bool circleJojom,
  }) {
    final scriptMap =
        _scripts[type] ?? _scripts[currentScript] ?? quranScriptMap;
    final ayahList = scriptMap[surah]?[ayah];
    if (ayahList == null) return [];
    final ayahData = List<String>.from(ayahList);
    for (int i = 0; i < ayahData.length; i++) {
      for (int j = tajweedRulesList.length - 1; 0 <= j; j--) {
        ayahData[i] = ayahData[i].replaceAll("r$j", tajweedRulesList[j]);
      }
    }

    if (!circleJojom && QuranScriptType.indopak == type) {
      for (int i = 0; i < ayahData.length; i++) {
        ayahData[i] = ayahData[i].replaceAll(1761.toChar(), "Backup");
        ayahData[i] = ayahData[i].replaceAll(1618.toChar(), 1761.toChar());
        ayahData[i] = ayahData[i].replaceAll("Backup", 1618.toChar());
      }
    }
    if (circleJojom && QuranScriptType.uthmani == type) {
      for (int i = 0; i < ayahData.length; i++) {
        ayahData[i] = ayahData[i].replaceAll(1761.toChar(), "Backup");
        ayahData[i] = ayahData[i].replaceAll(1618.toChar(), 1761.toChar());
        ayahData[i] = ayahData[i].replaceAll("Backup", 1618.toChar());
      }
    }

    return ayahData;
  }

  static String? getAyahKeyFromWordId({
    required int surah,
    required int wordId,
    required int page,
  }) {
    int ayahCount = quranAyahCount[surah - 1];
    for (int ayahNumber = 1; ayahNumber <= ayahCount; ayahNumber++) {
      String ayahKey = "$surah:$ayahNumber";
      if (ayahWordLengthMap[ayahKey]! > wordId) {
        String previousAyahKey = "$surah:${ayahNumber - 1}";
        String wordKey =
            "$previousAyahKey:${wordId - ayahWordLengthMap[previousAyahKey]!}";
        if (wordKey.endsWith("0")) {
          return null;
        }
        return wordKey;
      }
    }
    String lastAyahKey = "$surah:$ayahCount";
    String wordKey = "$lastAyahKey:${wordId - ayahWordLengthMap[lastAyahKey]!}";
    if (wordKey.endsWith("0")) {
      return null;
    }
    return wordKey;
  }
}
