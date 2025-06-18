import "dart:math";

import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:al_quran_v3/src/screen/prayer_time/resources/list_of_methods.dart";

/// Finds the most relevant CalculationMethod based on the user's location.
CalculationMethod findClosestCalculationMethod(double userLat, double userLon) {
  if (prayerTimeCalculationMethodModelList.isEmpty) {
    throw StateError("The list of calculation methods is empty.");
  }

  CalculationMethod? closestMethod;
  double minDistance = double.infinity;

  for (final method in prayerTimeCalculationMethodModelList) {
    if (method.location == null) {
      continue;
    }

    final double distance = _calculateDistance(
      userLat,
      userLon,
      method.location!.latitude,
      method.location!.longitude,
    );

    if (distance < minDistance) {
      minDistance = distance;
      closestMethod = method;
    }
  }

  if (closestMethod == null) {
    throw StateError(
      "Could not find any calculation method with location data.",
    );
  }

  return closestMethod;
}

// Helper function to calculate the distance between two lat/long points using the Haversine formula.
double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadiusKm = 6371;

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  lat1 = _degreesToRadians(lat1);
  lat2 = _degreesToRadians(lat2);

  double a =
      sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadiusKm * c;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}
