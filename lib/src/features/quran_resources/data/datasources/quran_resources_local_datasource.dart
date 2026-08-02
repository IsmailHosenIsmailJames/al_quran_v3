import 'package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart';
import 'package:al_quran_v3/src/resources/quran_resources/tafsir_resources.dart';
import 'package:al_quran_v3/src/resources/quran_resources/translation_resources.dart';
import 'package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart';
import 'package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart';
import 'package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class QuranResourcesLocalDataSource {
  Map<String, List<Map<String, dynamic>>> getRawTranslationsMap() {
    return translationResources;
  }

  Map<String, List<Map<String, dynamic>>> getRawTafsirsMap() {
    return tafsirResources;
  }

  List<ResourcesModel> getDownloadedTranslations() {
    return QuranTranslationFunction.getDownloadedTranslationBooks();
  }

  Future<List<ResourcesModel>?> getSelectedTranslations() {
    return QuranTranslationFunction.getTranslationSelections();
  }

  List<ResourcesModel> getDownloadedTafsirs() {
    return QuranTafsirFunction.getDownloadedTafsirBooks();
  }

  Future<List<ResourcesModel>?> getSelectedTafsirs() {
    return QuranTafsirFunction.getTafsirSelections();
  }

  Future<void> initWordByWord() async {
    await WordByWordFunction.init();
  }

  List<ResourcesModel> getDownloadedWordByWords() {
    return WordByWordFunction.getDownloadedWordByWordBooks();
  }

  ResourcesModel? getSelectedWordByWord() {
    return WordByWordFunction.getSelectedWordByWordBook();
  }

  Future<void> toggleTranslationSelection(ResourcesModel model) async {
    final selected = await getSelectedTranslations();
    bool isSelected =
        selected?.any((e) => e.fullPath == model.fullPath) ?? false;
    if (isSelected) {
      await QuranTranslationFunction.removeTranslationSelection(model);
    } else {
      await QuranTranslationFunction.setTranslationSelection(model);
    }
  }

  Future<void> deleteTranslation(ResourcesModel model) async {
    await QuranTranslationFunction.removeFromListAlreadyDownloaded(model);
  }

  Future<void> toggleTafsirSelection(ResourcesModel model) async {
    final selected = await getSelectedTafsirs();
    bool isSelected =
        selected?.any((e) => e.fullPath == model.fullPath) ?? false;
    if (isSelected) {
      await QuranTafsirFunction.removeTafsirSelection(model);
    } else {
      await QuranTafsirFunction.setTafsirSelection(model);
    }
  }

  Future<void> deleteTafsir(ResourcesModel model) async {
    await QuranTafsirFunction.removeFromListAlreadyDownloaded(model);
  }

  Future<void> toggleWordByWordSelection(ResourcesModel model) async {
    final selected = getSelectedWordByWord();
    if (selected?.fullPath == model.fullPath) {
      await WordByWordFunction.removeSelectedWordByWordBook();
    } else {
      await WordByWordFunction.setSelectedWordByWordBook(model);
    }
  }

  Future<void> deleteWordByWord(ResourcesModel model) async {
    await WordByWordFunction.removeBookFromDownloaded(model);
  }
}
