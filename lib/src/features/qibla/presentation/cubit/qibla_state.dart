import "package:freezed_annotation/freezed_annotation.dart";

part 'qibla_state.freezed.dart';

@freezed
abstract class QiblaState with _$QiblaState {
  const factory QiblaState({
    double? compassHeading,
    double? kaabaAngle,
    @Default(true) bool isSensorSupported,
    @Default(false) bool isAligned,
    @Default(false) bool hasError,
  }) = _QiblaState;
}
