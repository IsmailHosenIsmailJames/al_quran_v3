import "package:al_quran_v3/src/resources/quran_resources/quran_ayah_count.dart";

String? convertAyahNumberToKey(int ayahNumber) {
  int sum = 0;
  for (int i = 0; i < quranAyahCount.length; i++) {
    sum += quranAyahCount[i];
    if (ayahNumber <= sum) {
      sum = sum - quranAyahCount[i];
      return "${i + 1}:${ayahNumber - sum}";
    }
  }
  return null;
}

int? convertKeyToAyahNumber(String ayahKey) {
  // ayah Key example 1:1, 1:7, 2:100
  List<String> parts = ayahKey.split(":");
  if (parts.length != 2) {
    return null;
  }
  int surahNumber = int.parse(parts[0]);
  int ayahNumber = int.parse(parts[1]);
  if (surahNumber < 1 || surahNumber > quranAyahCount.length) {
    return null;
  }
  if (ayahNumber < 1 || ayahNumber > quranAyahCount[surahNumber - 1]) {
    return null;
  }
  int sum = 0;
  for (int i = 0; i < surahNumber - 1; i++) {
    sum += quranAyahCount[i];
  }
  return sum + ayahNumber;
}

String safeSubString(String str, int len, {String replacer = ""}) {
  int strLen = str.length;
  if (strLen > len) {
    return str.substring(0, len) + replacer;
  } else {
    return str;
  }
}
