import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/location/domain/repositories/location_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class GetSavedLocationUseCase {
  final LocationRepository _repository;

  GetSavedLocationUseCase(this._repository);

  Future<LocationCoordinates?> call() {
    return _repository.getSavedLocation();
  }
}
