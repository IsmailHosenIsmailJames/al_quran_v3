import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/utils/tajweed_rules.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";

List<String> getWordListOfAyah(
  QuranScriptType type,
  String surah,
  String ayah,
) {
  switch (type) {
    case QuranScriptType.tajweed:
      log("I am here");
      List<String> compressed = List<String>.from(
        tajweedQuranScriptCompressed[surah][ayah],
      );
      for (int i = 0; i < compressed.length; i++) {
        for (int j = tajweedRulesList.length - 1; 0 <= j; j--) {
          log(j.toString());
          compressed[i] = compressed[i].replaceAll("r$j", tajweedRulesList[j]);
        }
      }
      return compressed;

    case QuranScriptType.uthmani:
      return List<String>.from(uthmaniQuranScript[surah][ayah]);

    case QuranScriptType.indopak:
      return List<String>.from(indopakQuranScript[surah][ayah]);
  }
}
