import "package:adhan_dart/adhan_dart.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'prayer_time_entity.freezed.dart';

@freezed
abstract class PrayerTimeEntity with _$PrayerTimeEntity {
  const factory PrayerTimeEntity({
    required DateTime fajr,
    required DateTime sunrise,
    required DateTime dhuhr,
    required DateTime asr,
    required DateTime maghrib,
    required DateTime isha,
    required String nextPrayerName,
    DateTime? nextPrayerTime,
    Duration? timeRemaining,
  }) = _PrayerTimeEntity;

  factory PrayerTimeEntity.fromPrayerTimes(PrayerTimes prayerTimes) {
    Prayer? nextPrayerEnum = prayerTimes.nextPrayer(date: DateTime.now());
    String nextPrayerName = nextPrayerEnum?.name ?? "";
    DateTime? nextTime =
        nextPrayerEnum != null ? prayerTimes.timeForPrayer(nextPrayerEnum) : null;
    Duration? remaining;
    if (nextTime != null) {
      remaining = nextTime.difference(DateTime.now());
    }

    return PrayerTimeEntity(
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
      nextPrayerName: nextPrayerName,
      nextPrayerTime: nextTime,
      timeRemaining: remaining,
    );
  }
}
