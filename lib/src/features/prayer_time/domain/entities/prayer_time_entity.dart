import "package:adhan_dart/adhan_dart.dart";

class PrayerTimeEntity {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
  final String nextPrayerName;
  final DateTime? nextPrayerTime;
  final Duration? timeRemaining;

  const PrayerTimeEntity({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.nextPrayerName,
    this.nextPrayerTime,
    this.timeRemaining,
  });

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
