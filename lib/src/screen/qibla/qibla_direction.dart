import "dart:math" as math;

import "package:al_quran_v3/src/features/qibla/presentation/screens/qibla_screen.dart";
import "package:al_quran_v3/src/features/qibla/presentation/widgets/compass_painter.dart"
    as painter;
import "package:flutter/material.dart";
import "package:vector_math/vector_math.dart" as vector;

export "package:al_quran_v3/src/features/qibla/presentation/screens/qibla_screen.dart";

const double kaabaLatDegrees = 21.422487;
const double kaabaLonDegrees = 39.826206;

/// Backward-compatible widget facade for QiblaDirection.
class QiblaDirection extends StatelessWidget {
  const QiblaDirection({super.key});

  @override
  Widget build(BuildContext context) {
    return const QiblaScreen();
  }
}

/// Backward-compatible wrapper function for calculateQiblaAngle.
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

/// Backward-compatible wrapper function for transformAngle.
double transformAngle(double inputAngle) {
  return painter.transformAngle(inputAngle);
}
