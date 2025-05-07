import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';

List getListOfAyahKey({
  required String startAyahKey,
  required String endAyahKey,
}) {
  List ayahKeysList = [];
  int startSurahNumber = int.parse(startAyahKey.split(':')[0]);
  int startAyahNumber = int.parse(startAyahKey.split(':')[1]);
  int endSurahNumber = int.parse(endAyahKey.split(':')[0]);
  int endAyahNumber = int.parse(endAyahKey.split(':')[1]);

  for (int surah = startSurahNumber; surah <= endSurahNumber; surah++) {
    int startAyah = 1;
    if (surah == startSurahNumber) startAyah = startAyahNumber;
    int endAyah = quranAyahCount[surah - 1];
    if (surah == endSurahNumber) {
      endAyah = endAyahNumber;
    }
    for (int ayah = startAyah; ayah <= endAyah; ayah++) {
      if (ayah == 1) {
        ayahKeysList.add(surah);
      }
      ayahKeysList.add('$surah:$ayah');
    }
  }
  return ayahKeysList;
}
