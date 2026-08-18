import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/word_by_word_function.dart";

final Map<String, TranslationWithWordByWord> cacheOfAyahKeys = {};

TranslationWithWordByWord? getTranslationFromCache(String ayahKey) {
  return cacheOfAyahKeys[ayahKey];
}

Future<TranslationWithWordByWord> getTranslationWithWordByWord(
  String ayahKey,
) async {
  final cached = cacheOfAyahKeys[ayahKey];
  if (cached != null) return cached;

  final TranslationWithWordByWord translationWithWordByWord =
      TranslationWithWordByWord(
        translationList: await QuranTranslationFunction.getTranslation(ayahKey),
        wordByWord: await WordByWordFunction.getAyahWordByWordData(ayahKey),
      );
  cacheOfAyahKeys[ayahKey] = translationWithWordByWord;
  return translationWithWordByWord;
}

/// Pre-warms the translation cache for a list of Ayahs in the background.
Future<void> prewarmAyahsTranslation(List<String> ayahKeys) async {
  for (final key in ayahKeys) {
    if (!cacheOfAyahKeys.containsKey(key)) {
      getTranslationWithWordByWord(key);
    }
  }
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
