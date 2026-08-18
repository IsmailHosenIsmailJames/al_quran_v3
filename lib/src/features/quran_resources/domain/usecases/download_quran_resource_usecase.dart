import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/repositories/i_quran_resources_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DownloadQuranResourceUseCase {
  final IQuranResourcesRepository _repository;

  DownloadQuranResourceUseCase(this._repository);

  Future<bool> call(
    QuranResourceEntity resource, {
    void Function(double progress, String name)? onProgress,
  }) {
    return _repository.downloadResource(resource, onProgress: onProgress);
  }
}
