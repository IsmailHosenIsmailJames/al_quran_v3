class QiblaState {
  final double? compassHeading;
  final double? kaabaAngle;
  final bool isSensorSupported;
  final bool isAligned;
  final bool hasError;

  const QiblaState({
    this.compassHeading,
    this.kaabaAngle,
    this.isSensorSupported = true,
    this.isAligned = false,
    this.hasError = false,
  });

  QiblaState copyWith({
    double? compassHeading,
    double? kaabaAngle,
    bool? isSensorSupported,
    bool? isAligned,
    bool? hasError,
  }) {
    return QiblaState(
      compassHeading: compassHeading ?? this.compassHeading,
      kaabaAngle: kaabaAngle ?? this.kaabaAngle,
      isSensorSupported: isSensorSupported ?? this.isSensorSupported,
      isAligned: isAligned ?? this.isAligned,
      hasError: hasError ?? this.hasError,
    );
  }
}
