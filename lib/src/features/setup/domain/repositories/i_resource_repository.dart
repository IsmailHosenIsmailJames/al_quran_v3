import "package:al_quran_v3/src/features/setup/domain/entities/download_progress.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart";

abstract class IResourceRepository {
  Future<Map<String, List<ResourceEntity>>> getAllAvailableResources();
  Stream<DownloadProgress> downloadSetupResources({
    required SetupConfig config,
    required String segmentsUrl,
  });
  Future<bool> isResourceDownloaded(ResourceEntity resource);
}
