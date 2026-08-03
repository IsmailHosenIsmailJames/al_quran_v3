abstract class QiblaRepository {
  /// Returns a stream of compass heading values in degrees.
  Stream<double?> getCompassHeadingStream();

  /// Calculates Qibla direction angle (in degrees relative to North) given latitude and longitude.
  double calculateQiblaAngle(double userLat, double userLon);

  /// Checks if device supports vibration.
  Future<bool> hasVibrator();

  /// Triggers haptic vibration feedback.
  Future<void> vibrate();
}
