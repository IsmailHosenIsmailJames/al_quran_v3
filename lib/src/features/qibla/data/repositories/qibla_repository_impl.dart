import "dart:async";
import "dart:math" as math;

import "package:al_quran_v3/src/features/qibla/data/datasources/compass_datasource.dart";
import "package:al_quran_v3/src/features/qibla/data/datasources/vibration_datasource.dart";
import "package:al_quran_v3/src/features/qibla/domain/repositories/qibla_repository.dart";
import "package:injectable/injectable.dart";
import "package:vector_math/vector_math.dart" as vector;

const double kaabaLatDegrees = 21.422487;
const double kaabaLonDegrees = 39.826206;

@LazySingleton(as: QiblaRepository)
class QiblaRepositoryImpl implements QiblaRepository {
  final CompassDatasource _compassDatasource;
  final VibrationDatasource _vibrationDatasource;

  QiblaRepositoryImpl(this._compassDatasource, this._vibrationDatasource);

  @override
  Stream<double?> getCompassHeadingStream() {
    final stream = _compassDatasource.compassEvents;
    if (stream == null) {
      return Stream.value(null);
    }
    return stream.map((event) {
      double? heading = event.heading;
      if (heading == null) return null;
      if (heading < 0) {
        heading = 180 + (180 - heading.abs());
      }
      return heading;
    });
  }

  @override
  double calculateQiblaAngle(double userLat, double userLon) {
    if (userLat == kaabaLatDegrees && userLon == kaabaLonDegrees) {
      return -1.0;
    }

    final double userLatRad = vector.radians(userLat);
    final double userLonRad = vector.radians(userLon);
    final double kaabaLatRad = vector.radians(kaabaLatDegrees);
    final double kaabaLonRad = vector.radians(kaabaLonDegrees);

    final double deltaLon = kaabaLonRad - userLonRad;

    final double y = math.sin(deltaLon) * math.cos(kaabaLatRad);
    final double x =
        math.cos(userLatRad) * math.sin(kaabaLatRad) -
        math.sin(userLatRad) * math.cos(kaabaLatRad) * math.cos(deltaLon);

    final double bearingRad = math.atan2(y, x);
    final double bearingDeg = vector.degrees(bearingRad);

    final double qiblaAngle = (bearingDeg + 360) % 360;
    return qiblaAngle;
  }

  @override
  Future<bool> hasVibrator() {
    return _vibrationDatasource.hasVibrator();
  }

  @override
  Future<void> vibrate() async {
    bool hasCustomSupport =
        await _vibrationDatasource.hasCustomVibrationsSupport();
    await _vibrationDatasource.vibrate(
      amplitude: hasCustomSupport ? 200 : -1,
      duration: 100,
    );
  }
}
