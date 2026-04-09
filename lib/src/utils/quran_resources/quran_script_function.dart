import "dart:convert";

import "package:al_quran_v3/src/utils/tajweed_rules.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:dartx/dartx.dart";
import "package:flutter/services.dart";

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
    bool warshScript = false,
  }) {
    final ayahData = List<String>.from(quranScriptMap[surah][ayah]);
    for (int i = 0; i < ayahData.length; i++) {
      for (int j = tajweedRulesList.length - 1; 0 <= j; j--) {
        ayahData[i] = ayahData[i].replaceAll("r$j", tajweedRulesList[j]);
      }
    }

    if (!warshScript && QuranScriptType.indopak == type) {
      for (int i = 0; i < ayahData.length; i++) {
        ayahData[i] = ayahData[i].replaceAll(1761.toChar(), "Backup");
        ayahData[i] = ayahData[i].replaceAll(1618.toChar(), 1761.toChar());
        ayahData[i] = ayahData[i].replaceAll("Backup", 1618.toChar());
      }
    }

    return ayahData;
  }
}
