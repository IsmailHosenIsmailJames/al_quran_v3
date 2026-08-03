import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";
import "package:shared_preferences/shared_preferences.dart";

abstract class LocationLocalDataSource {
  Future<LocationCoordinates?> getSavedLocation();
  Future<void> saveLocation(LocationCoordinates location);
}

@LazySingleton(as: LocationLocalDataSource)
class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  static const String _userLocationKey = "user_location";

  @override
  Future<LocationCoordinates?> getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonLocation = prefs.getString(_userLocationKey);
    if (jsonLocation == null) {
      jsonLocation = Hive.box("user").get(_userLocationKey, defaultValue: null);
      if (jsonLocation != null) {
        await prefs.setString(_userLocationKey, jsonLocation);
      }
    }
    if (jsonLocation == null) return null;
    return LocationCoordinates.fromJson(jsonLocation);
  }

  @override
  Future<void> saveLocation(LocationCoordinates location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userLocationKey, location.toJson());
  }
}
