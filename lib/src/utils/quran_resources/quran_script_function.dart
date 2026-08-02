import "dart:convert";

import "package:al_quran_v3/src/resources/quran_resources/quran_ayah_count.dart";
import "package:al_quran_v3/src/utils/tajweed_rules.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:dartx/dartx.dart";
import "package:flutter/services.dart";

import "../../resources/quran_resources/ayah_word_length_map.dart";

class QuranScriptFunction {
  static Map quranScriptMap = {};
  static QuranScriptType? currentScript;

  static Future<void> loadScript(QuranScriptType scriptType) async {
    if (currentScript != scriptType) {
      quranScriptMap = {};
      currentScript = scriptType;
    } else {
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
    quranScriptMap = jsonDecode(value);
  }

  static List<String> getWordListOfAyah(
    QuranScriptType type,
    String surah,
    String ayah, {
    required bool circleJojom,
  }) {
    final ayahData = List<String>.from(quranScriptMap[surah][ayah]);
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
