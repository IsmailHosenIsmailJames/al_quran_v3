import "dart:convert";

import "package:al_quran_v3/src/utils/tajweed_rules.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:flutter/services.dart";
import "package:hive_ce/hive.dart";

class QuranScriptFunction {
  static String quranScriptVersion = "1";
  static Box? quranBox;

  static Future<void> writeQuranScript({
    Function(int progress)? onProgress,
  }) async {
    int progress = 0;
    int processed = 0;
    final userBox = Hive.box("user");
    for (QuranScriptType scriptType in QuranScriptType.values) {
      Map quranScriptMap = {};
      switch (scriptType) {
        case QuranScriptType.tajweed:
          quranScriptMap = jsonDecode(
            await rootBundle.loadString(
              "assets/quran_script/QPC_Hafs_Tajweed_Compress.json",
            ),
          );
        case QuranScriptType.uthmani:
          quranScriptMap = jsonDecode(
            await rootBundle.loadString("assets/quran_script/Uthmani.json"),
          );
        case QuranScriptType.indopak:
          quranScriptMap = jsonDecode(
            await rootBundle.loadString("assets/quran_script/Indopak.json"),
          );
      }
      final quranBox = await Hive.openBox("script_${scriptType.name}");
      for (String surahKey in quranScriptMap.keys) {
        Map surahMap = quranScriptMap[surahKey] as Map;
        for (final ayahKey in surahMap.keys) {
          await quranBox.put("$surahKey:$ayahKey", surahMap[ayahKey]);
          processed++;
          if (onProgress != null) {
            final double temProgress = (processed / 18708) * 100;
            if (temProgress.toInt() != progress) {
              progress = temProgress.toInt();
              onProgress(progress);
            }
          }
        }
      }

      quranScriptMap.clear();
      await quranBox.close();
    }
    await userBox.put("writeQuranScriptVersion", quranScriptVersion);
    await userBox.put("writeQuranScript", true);
  }

  static Future<void> initQuranScript(QuranScriptType type) async {
    quranBox = await Hive.openBox("script_${type.name}");
  }

  static Map cacheOfAyah = {};

  static List<String> getWordListOfAyah(
    QuranScriptType type,
    String surah,
    String ayah,
  ) {
    String ayahKey = "$surah:$ayah";
    final fromCache = cacheOfAyah[ayahKey + type.name];
    if (fromCache != null) return fromCache;
    switch (type) {
      case QuranScriptType.tajweed:
        List<String> compressed = List<String>.from(quranBox!.get(ayahKey));
        for (int i = 0; i < compressed.length; i++) {
          for (int j = tajweedRulesList.length - 1; 0 <= j; j--) {
            compressed[i] = compressed[i].replaceAll(
              "r$j",
              tajweedRulesList[j],
            );
          }
        }
        cacheOfAyah[ayahKey + type.name] = compressed;
        return compressed;

      default:
        final toReturn = List<String>.from(quranBox!.get(ayahKey));
        cacheOfAyah[ayahKey + type.name] = toReturn;
        return toReturn;
    }
  }
}
