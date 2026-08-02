import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/repositories/i_quran_resources_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleQuranResourceSelectionUseCase {
  final IQuranResourcesRepository _repository;

  ToggleQuranResourceSelectionUseCase(this._repository);

  Future<void> call(QuranResourceEntity resource) {
    return _repository.toggleResourceSelection(resource);
  }
}
