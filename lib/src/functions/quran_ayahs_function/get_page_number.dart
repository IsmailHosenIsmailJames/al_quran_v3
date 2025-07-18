import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/resources/quran_resources/quran_pages_info.dart";

int? getPageNumber(String ayahKey) {
  int ayahID = convertKeyToAyahNumber(ayahKey)!;
  for (Map info in quranPagesInfo) {
    if (info["s"] <= ayahID && info["e"] >= ayahID) {
      return info["i"] + 1;
    }
  }
  return null;
}
