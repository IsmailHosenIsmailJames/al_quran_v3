import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";

Future<TranslationWithWordByWord> getTranslationWithWordByWord(
  String ayahKey,
) async {
  return TranslationWithWordByWord(
    await QuranTranslationFunction.getTranslation(ayahKey),
    await WordByWordFunction.getAyahWordByWordData(ayahKey),
  );
}

class TranslationWithWordByWord {
  final Map<dynamic, dynamic>? translation;
  final List? wordByWord;
  TranslationWithWordByWord(this.translation, this.wordByWord);
}
