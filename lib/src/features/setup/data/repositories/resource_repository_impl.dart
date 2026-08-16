import "dart:async";

import "package:al_quran_v3/src/features/setup/data/models/resource_mapper.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/download_progress.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart";
import "package:al_quran_v3/src/features/setup/domain/repositories/i_resource_repository.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/tafsir_resources.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/location_resources_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_tafsir_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/segmented_resources_manager.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/word_by_word_function.dart";
import "package:dartx/dartx.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: IResourceRepository)
class ResourceRepositoryImpl implements IResourceRepository {
  final Map<String, List<ResourceEntity>> _cachedResources = {};

  @override
  Future<Map<String, List<ResourceEntity>>> getAllAvailableResources() async {
    if (_cachedResources.isNotEmpty) {
      return _cachedResources;
    }

    final rawList = (tafsirResources.values.toList() +
            translationResources.values.toList())
        .expand((e) => e)
        .map((e) => ResourcesModel.fromMap(e))
        .toList();

    final mappedEntities = <ResourceEntity>[];
    for (final model in rawList) {
      final isDownloaded = await _checkIfDownloaded(model);
      mappedEntities.add(ResourceMapper.toEntity(model, isDownloaded: isDownloaded));
    }

    final grouped = mappedEntities.groupBy((element) => element.languageCode);
    _cachedResources.clear();
    _cachedResources.addAll(grouped);
    return _cachedResources;
  }

  Future<bool> _checkIfDownloaded(ResourcesModel model) async {
    if (model.type == ResourceType.tafsir) {
      return await QuranTafsirFunction.isAlreadyDownloaded(model);
    } else if (model.type == ResourceType.word_by_word) {
      return await WordByWordFunction.isBookDownloaded(model);
    } else {
      return await QuranTranslationFunction.isAlreadyDownloaded(model);
    }
  }

  @override
  Future<bool> isResourceDownloaded(ResourceEntity resource) async {
    final model = ResourceMapper.toModel(resource);
    return await _checkIfDownloaded(model);
  }

  @override
  Stream<DownloadProgress> downloadSetupResources({
    required SetupConfig config,
    required String segmentsUrl,
  }) async* {
    if (config.selectedTranslation == null || config.selectedTafsir == null) {
      yield DownloadProgress.failed(
        stepName: "Validation",
        errorMessage: "Please select required translation and tafsir options.",
      );
      return;
    }

    final translationModel = ResourceMapper.toModel(config.selectedTranslation!);
    final tafsirModel = ResourceMapper.toModel(config.selectedTafsir!);

    final controller = StreamController<DownloadProgress>();

    void emitProgress(double? subPercentage, String stepName, int stepIndex) {
      double baseProgress = stepIndex / 5.0;
      double overall = baseProgress + ((subPercentage ?? 0.0) * 0.20);
      if (overall > 1.0) overall = 1.0;

      controller.add(
        DownloadProgress.inProgress(
          stepName: stepName,
          percentage: overall,
          currentStepIndex: stepIndex,
          totalSteps: 5,
        ),
      );
    }

    // Run batch download asynchronously while yielding from stream controller
    Future<void> runBatch() async {
      try {
        // Step 0: Translation
        emitProgress(0.0, "Downloading Translation: ${translationModel.name}", 0);
        bool success1 = await QuranTranslationFunction.downloadResources(
          translationBook: translationModel,
          isSetupProcess: true,
          onProgress: (perc, name) => emitProgress(perc, name, 0),
        );
        if (!success1) {
          controller.add(
            DownloadProgress.failed(
              stepName: "Translation Download",
              errorMessage: "Failed to download selected translation.",
              currentStepIndex: 0,
            ),
          );
          await controller.close();
          return;
        }

        // Step 1: Tafsir
        emitProgress(0.0, "Downloading Tafsir: ${tafsirModel.name}", 1);
        bool success2 = await QuranTafsirFunction.downloadResources(
          tafsirBook: tafsirModel,
          isSetupProcess: true,
          onProgress: (perc, name) => emitProgress(perc, name, 1),
        );
        if (!success2) {
          controller.add(
            DownloadProgress.failed(
              stepName: "Tafsir Download",
              errorMessage: "Failed to download selected tafsir.",
              currentStepIndex: 1,
            ),
          );
          await controller.close();
          return;
        }

        // Step 2: Word by Word (if available for language)
        final allResourcesMap = await getAllAvailableResources();
        final langResources = allResourcesMap[config.appLanguageCode] ?? [];
        final wbwEntity = langResources.firstOrNullWhere(
          (e) => e.isWordByWord,
        );

        bool success3 = true;
        if (wbwEntity != null) {
          emitProgress(0.0, "Downloading Word-by-Word data", 2);
          final wbwModel = ResourceMapper.toModel(wbwEntity);
          success3 = await WordByWordFunction.downloadResource(
            book: wbwModel,
            isSetupProcess: true,
            onProgress: (perc, name) => emitProgress(perc, name, 2),
          );
        } else {
          emitProgress(1.0, "Word-by-Word data (Not applicable)", 2);
        }

        // Step 3: Audio Segments
        emitProgress(0.0, "Downloading Audio Segments", 3);
        bool success4 = await SegmentedResourcesManager.downloadResources(
          null,
          segmentsUrl,
          onProgress: (perc, name) => emitProgress(perc, name, 3),
        );

        // Step 4: Location Data
        emitProgress(0.0, "Downloading Location Data", 4);
        bool success5 = await LocationResourcesFunction.downloadLocationResources(
          isSetupProcess: true,
        );
        emitProgress(1.0, "Location Data Downloaded", 4);

        if (success1 && success2 && success3 && success4 && success5) {
          final userBox = Hive.box("user");
          await userBox.put("is_setup_complete", true);
          controller.add(
            DownloadProgress.completed(stepName: "Download Complete"),
          );
        } else {
          controller.add(
            DownloadProgress.failed(
              stepName: "Resource Setup",
              errorMessage: "Unable to download all required resources.",
            ),
          );
        }
      } catch (e) {
        controller.add(
          DownloadProgress.failed(
            stepName: "Unexpected Error",
            errorMessage: e.toString(),
          ),
        );
      } finally {
        await controller.close();
      }
    }

    runBatch();

    yield* controller.stream;
  }
}
