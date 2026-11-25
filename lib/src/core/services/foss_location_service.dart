import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:permission_handler/permission_handler.dart";

/// Lightweight position data replacing `geolocator`'s `Position` without GMS.
class FossPosition {
  final double latitude;
  final double longitude;

  const FossPosition({
    required this.latitude,
    required this.longitude,
  });
}

/// FOSS location permission states mapped from `permission_handler`.
enum FossLocationPermission {
  denied,
  deniedForever,
  whileInUse,
  always,
}

/// Pure-FOSS location helper backed by `permission_handler` and AOSP
/// `android.location.LocationManager` via a platform method channel.
class FossLocationService {
  FossLocationService._();

  static const MethodChannel _channel = MethodChannel(
    "com.ismail_hosen_james.al_quran_v3/location",
  );

  static Future<bool> isLocationServiceEnabled() async {
    if (kIsWeb) return false;
    try {
      final status = await Permission.location.serviceStatus;
      return status.isEnabled;
    } catch (_) {
      if (Platform.isAndroid) {
        final enabled = await _channel.invokeMethod<bool>(
          "isLocationServiceEnabled",
        );
        return enabled ?? false;
      }
      return false;
    }
  }

  static Future<bool> openLocationSettings() async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      final opened = await _channel.invokeMethod<bool>("openLocationSettings");
      return opened ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<FossLocationPermission> checkPermission() async {
    if (kIsWeb) return FossLocationPermission.denied;
    final status = await Permission.locationWhenInUse.status;
    return _mapStatus(status);
  }

  static Future<FossLocationPermission> requestPermission() async {
    if (kIsWeb) return FossLocationPermission.denied;
    final status = await Permission.locationWhenInUse.request();
    return _mapStatus(status);
  }

  static Future<FossPosition> getCurrentPosition() async {
    if (kIsWeb || !Platform.isAndroid) {
      throw UnsupportedError(
        "GPS location lookup is only supported on Android in FOSS builds.",
      );
    }

    final result = await _channel.invokeMapMethod<String, dynamic>(
      "getCurrentPosition",
    );
    if (result == null ||
        result["latitude"] == null ||
        result["longitude"] == null) {
      throw PlatformException(
        code: "LOCATION_UNAVAILABLE",
        message: "Unable to determine current location.",
      );
    }

    return FossPosition(
      latitude: (result["latitude"] as num).toDouble(),
      longitude: (result["longitude"] as num).toDouble(),
    );
  }

  static FossLocationPermission _mapStatus(PermissionStatus status) {
    if (status.isGranted || status.isLimited) {
      return FossLocationPermission.whileInUse;
    }
    if (status.isPermanentlyDenied || status.isRestricted) {
      return FossLocationPermission.deniedForever;
    }
    return FossLocationPermission.denied;
  }
}
