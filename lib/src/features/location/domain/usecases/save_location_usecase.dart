import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/location/domain/repositories/location_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SaveLocationUseCase {
  final LocationRepository _repository;

  SaveLocationUseCase(this._repository);

  Future<void> call(LocationCoordinates location) {
    return _repository.saveLocation(location);
  }
}
