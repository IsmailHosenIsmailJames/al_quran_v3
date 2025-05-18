import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";

List<String>? getAyahByKeyAndScriptType(
  QuranScriptType quranScriptType,
  String ayahKey,
) {
  if (quranScriptType == QuranScriptType.indopak) {
    return indopakScript[ayahKey];
  } else if (quranScriptType == QuranScriptType.tajweed) {
    return indopakScript[ayahKey];
  } else {
    return uthmaniScript[ayahKey];
  }
}
