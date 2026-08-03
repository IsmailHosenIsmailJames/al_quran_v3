import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";

abstract class LocationRepository {
  /// Fetches current device GPS location using geolocator.
  Future<LocationCoordinates?> getCurrentLocation();

  /// Retrieves previously saved location from local storage.
  Future<LocationCoordinates?> getSavedLocation();

  /// Saves user location to local storage.
  Future<void> saveLocation(LocationCoordinates location);
}
