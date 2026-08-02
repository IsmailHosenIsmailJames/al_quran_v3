import 'package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart';
import 'package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart';
import 'package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart';
import 'package:al_quran_v3/src/utils/quran_resources/word_by_word_function.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class QuranResourcesRemoteDataSource {
  Future<bool> downloadTranslationResource(
    ResourcesModel model, {
    void Function(double? percentage, String processName)? onProgress,
  }) async {
    bool success = await QuranTranslationFunction.downloadResources(
      onProgress: onProgress,
      translationBook: model,
      isSetupProcess: false,
    );
    if (success) {
      if (await QuranTranslationFunction.isAlreadyDownloaded(model)) {
        await QuranTranslationFunction.setTranslationSelection(model);
      }
    }
    return success;
  }

  Future<bool> downloadTafsirResource(
    ResourcesModel model, {
    void Function(double? percentage, String processName)? onProgress,
  }) async {
    bool success = await QuranTafsirFunction.downloadResources(
      onProgress: onProgress,
      tafsirBook: model,
      isSetupProcess: false,
    );
    if (success) {
      if (await QuranTafsirFunction.isAlreadyDownloaded(model)) {
        await QuranTafsirFunction.setTafsirSelection(model);
      }
    }
    return success;
  }

  Future<bool> downloadWordByWordResource(
    ResourcesModel model, {
    void Function(double? percentage, String processName)? onProgress,
  }) async {
    bool success = await WordByWordFunction.downloadResource(
      book: model,
      isSetupProcess: false,
      onProgress: onProgress,
    );
    if (success) {
      await WordByWordFunction.setSelectedWordByWordBook(model);
    }
    return success;
  }
}
