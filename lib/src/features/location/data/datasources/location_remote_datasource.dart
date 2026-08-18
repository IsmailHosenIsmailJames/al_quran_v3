import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:geolocator/geolocator.dart";
import "package:injectable/injectable.dart";

abstract class LocationRemoteDataSource {
  Future<LocationCoordinates?> getCurrentLocation();
}

@LazySingleton(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationCoordinates?> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return LocationCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
