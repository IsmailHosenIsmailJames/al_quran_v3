import "package:al_quran_v3/src/features/prayer_time/domain/entities/prayer_time_entity.dart";

class PrayerTimeState {
  final PrayerTimeEntity? todayPrayerTimes;
  final List<PrayerTimeEntity> monthlyPrayerTimes;
  final bool isLoading;
  final bool hasError;

  const PrayerTimeState({
    this.todayPrayerTimes,
    this.monthlyPrayerTimes = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  PrayerTimeState copyWith({
    PrayerTimeEntity? todayPrayerTimes,
    List<PrayerTimeEntity>? monthlyPrayerTimes,
    bool? isLoading,
    bool? hasError,
  }) {
    return PrayerTimeState(
      todayPrayerTimes: todayPrayerTimes ?? this.todayPrayerTimes,
      monthlyPrayerTimes: monthlyPrayerTimes ?? this.monthlyPrayerTimes,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
