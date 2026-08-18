import "package:al_quran_v3/src/features/location/data/datasources/location_local_datasource.dart";
import "package:al_quran_v3/src/features/location/data/datasources/location_remote_datasource.dart";
import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/location/domain/repositories/location_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource _localDataSource;
  final LocationRemoteDataSource _remoteDataSource;

  LocationRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<LocationCoordinates?> getCurrentLocation() async {
    final location = await _remoteDataSource.getCurrentLocation();
    if (location != null) {
      await _localDataSource.saveLocation(location);
    }
    return location;
  }

  @override
  Future<LocationCoordinates?> getSavedLocation() {
    return _localDataSource.getSavedLocation();
  }

  @override
  Future<void> saveLocation(LocationCoordinates location) {
    return _localDataSource.saveLocation(location);
  }
}
