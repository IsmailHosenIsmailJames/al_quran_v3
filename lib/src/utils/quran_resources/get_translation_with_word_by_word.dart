import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
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
        translationList: await QuranTranslationFunction.getTranslation(ayahKey),
        wordByWord: await WordByWordFunction.getAyahWordByWordData(ayahKey),
      );
  cacheOfAyahKeys[ayahKey] = translationWithWordByWord;
  return translationWithWordByWord;
}

class TranslationWithWordByWord {
  final List<TranslationOfAyah> translationList;
  final List? wordByWord;
  TranslationWithWordByWord({
    required this.translationList,
    required this.wordByWord,
  });
}

class TranslationOfAyah {
  final Map? translation;
  final ResourcesModel? bookInfo;
  TranslationOfAyah({this.translation, required this.bookInfo});
}
