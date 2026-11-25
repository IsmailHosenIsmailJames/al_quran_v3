import "package:al_quran_v3/src/core/services/foss_location_service.dart";
import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:injectable/injectable.dart";

abstract class LocationRemoteDataSource {
  Future<LocationCoordinates?> getCurrentLocation();
}

@LazySingleton(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationCoordinates?> getCurrentLocation() async {
    FossPosition position = await FossLocationService.getCurrentPosition();
    return LocationCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
