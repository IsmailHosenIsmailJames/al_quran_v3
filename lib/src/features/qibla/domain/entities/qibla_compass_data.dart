import "package:freezed_annotation/freezed_annotation.dart";

part 'qibla_compass_data.freezed.dart';

@freezed
abstract class QiblaCompassData with _$QiblaCompassData {
  const factory QiblaCompassData({
    required double heading,
    required double kaabaAngle,
    required bool isAligned,
  }) = _QiblaCompassData;

  /// Computes whether the current heading aligns with Kaaba angle within tolerance.
  static bool checkIsAligned(double heading, double kaabaAngle, {double tolerance = 5.0}) {
    return (heading.abs() - kaabaAngle.abs()).abs() < tolerance;
  }
}
