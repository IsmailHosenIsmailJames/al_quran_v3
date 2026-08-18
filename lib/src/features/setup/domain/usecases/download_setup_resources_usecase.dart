import "package:al_quran_v3/src/features/setup/domain/entities/download_progress.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart";
import "package:al_quran_v3/src/features/setup/domain/repositories/i_resource_repository.dart";
import "package:al_quran_v3/src/features/setup/domain/repositories/i_setup_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class DownloadSetupResourcesUseCase {
  final IResourceRepository resourceRepository;
  final ISetupRepository setupRepository;

  DownloadSetupResourcesUseCase({
    required this.resourceRepository,
    required this.setupRepository,
  });

  Stream<DownloadProgress> execute({
    required SetupConfig config,
    required String segmentsUrl,
  }) async* {
    await setupRepository.saveAppLanguage(config.appLanguageCode);

    yield* resourceRepository.downloadSetupResources(
      config: config,
      segmentsUrl: segmentsUrl,
    );
  }
}
