import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart";

Map<String, TranslationWithWordByWord> cacheOfAyahKeys = {};

TranslationWithWordByWord? getTranslationFromCache(String ayahKey) {
  return cacheOfAyahKeys[ayahKey];
}

Future<TranslationWithWordByWord> getTranslationWithWordByWord(
  String ayahKey,
) async {
  final TranslationWithWordByWord translationWithWordByWord =
      TranslationWithWordByWord(
        await QuranTranslationFunction.getTranslation(ayahKey),
        await WordByWordFunction.getAyahWordByWordData(ayahKey),
      );
  cacheOfAyahKeys[ayahKey] = translationWithWordByWord;
  return translationWithWordByWord;
}

class TranslationWithWordByWord {
  final Map<dynamic, dynamic>? translation;
  final List? wordByWord;
  TranslationWithWordByWord(this.translation, this.wordByWord);
}
