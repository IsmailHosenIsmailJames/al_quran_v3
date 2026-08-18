import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/features/setup/domain/repositories/i_resource_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class GetSetupResourcesUseCase {
  final IResourceRepository repository;

  GetSetupResourcesUseCase(this.repository);

  Future<Map<String, List<ResourceEntity>>> execute() async {
    return await repository.getAllAvailableResources();
  }
}
