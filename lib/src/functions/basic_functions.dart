import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';

String capitalizeFirstLatter(String input) {
  if (input.isEmpty) {
    return '';
  }
  return input[0].toUpperCase() + input.substring(1);
}

String? convertAyahNumberToKey(int ayahNumber) {
  int sum = 0;
  for (int i = 0; i < quranAyahCount.length; i++) {
    sum += quranAyahCount[i];
    if (ayahNumber <= sum) {
      sum = sum - quranAyahCount[i];
      return '${i + 1}:${ayahNumber - sum}';
    }
  }
  return null;
}
