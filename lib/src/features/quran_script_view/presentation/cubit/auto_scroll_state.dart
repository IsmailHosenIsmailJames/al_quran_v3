import "package:al_quran_v3/src/core/resources/quran_resources/ayahs_len.dart";

class AutoScrollState {
  final bool isActive;
  final bool isPlaying;
  final bool isPausedByTouch;
  final double speed;
  final String? currentAyahKey;
  final int currentScrollIndex;

  const AutoScrollState({
    this.isActive = false,
    this.isPlaying = false,
    this.isPausedByTouch = false,
    this.speed = 1.0,
    this.currentAyahKey,
    this.currentScrollIndex = 0,
  });

  static const List<double> availableSpeeds = [
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    2.0,
    2.5,
    3.0,
  ];

  /// Calculates smooth reading duration for a specific Ayah based on word count.
  ///
  /// Standard recitation pace is ~650ms per word (approx 90-95 words per minute),
  /// scaled inversely by the user's chosen speed multiplier.
  Duration getAyahDuration(String ayahKey) {
    int wordCount = 10;
    try {
      final parts = ayahKey.split(":");
      final surah = parts.first;
      final ayah = parts.last;
      final raw = ayahsLenInfo[surah]?[ayah];
      if (raw is int && raw > 0) {
        wordCount = raw;
      }
    } catch (_) {}

    final rawMillis = (wordCount * 650.0) / speed;
    // Floor duration at 2200ms so very short verses remain comfortably readable
    final effectiveMillis = rawMillis.clamp(2200.0, 180000.0).round();
    return Duration(milliseconds: effectiveMillis);
  }

  /// Calculates duration for a whole page in Continuous Reading Mode.
  Duration getPageDuration(List<String> pageAyahs) {
    int totalWords = 0;
    for (final key in pageAyahs) {
      try {
        final parts = key.split(":");
        final raw = ayahsLenInfo[parts.first]?[parts.last];
        if (raw is int) totalWords += raw;
      } catch (_) {}
    }
    if (totalWords == 0) totalWords = 130;
    final rawMillis = (totalWords * 550.0) / speed;
    final effectiveMillis = rawMillis.clamp(8000.0, 300000.0).round();
    return Duration(milliseconds: effectiveMillis);
  }

  AutoScrollState copyWith({
    bool? isActive,
    bool? isPlaying,
    bool? isPausedByTouch,
    double? speed,
    String? currentAyahKey,
    int? currentScrollIndex,
  }) {
    return AutoScrollState(
      isActive: isActive ?? this.isActive,
      isPlaying: isPlaying ?? this.isPlaying,
      isPausedByTouch: isPausedByTouch ?? this.isPausedByTouch,
      speed: speed ?? this.speed,
      currentAyahKey: currentAyahKey ?? this.currentAyahKey,
      currentScrollIndex: currentScrollIndex ?? this.currentScrollIndex,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoScrollState &&
          runtimeType == other.runtimeType &&
          isActive == other.isActive &&
          isPlaying == other.isPlaying &&
          isPausedByTouch == other.isPausedByTouch &&
          speed == other.speed &&
          currentAyahKey == other.currentAyahKey &&
          currentScrollIndex == other.currentScrollIndex;

  @override
  int get hashCode =>
      isActive.hashCode ^
      isPlaying.hashCode ^
      isPausedByTouch.hashCode ^
      speed.hashCode ^
      (currentAyahKey?.hashCode ?? 0) ^
      currentScrollIndex.hashCode;
}
