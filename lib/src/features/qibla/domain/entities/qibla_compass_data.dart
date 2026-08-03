class QiblaCompassData {
  final double heading;
  final double kaabaAngle;
  final bool isAligned;

  const QiblaCompassData({
    required this.heading,
    required this.kaabaAngle,
    required this.isAligned,
  });

  /// Computes whether the current heading aligns with Kaaba angle within tolerance.
  static bool checkIsAligned(double heading, double kaabaAngle, {double tolerance = 5.0}) {
    return (heading.abs() - kaabaAngle.abs()).abs() < tolerance;
  }
}
