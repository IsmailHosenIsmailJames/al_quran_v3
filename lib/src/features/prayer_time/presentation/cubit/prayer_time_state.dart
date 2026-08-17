import "package:al_quran_v3/src/features/prayer_time/domain/entities/prayer_time_entity.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'prayer_time_state.freezed.dart';

@freezed
abstract class PrayerTimeState with _$PrayerTimeState {
  const factory PrayerTimeState({
    PrayerTimeEntity? todayPrayerTimes,
    @Default([]) List<PrayerTimeEntity> monthlyPrayerTimes,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
  }) = _PrayerTimeState;
}
