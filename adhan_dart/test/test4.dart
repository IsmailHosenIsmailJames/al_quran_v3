// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// During Isha prayer, currentPrayer returns Isha, but nextPrayer returns fajrAfter.
///
/// After Midnight, currentPrayer returns IshaBefore, but nextPrayer returns fajr.
///
/// The latter will persist until the next fajr prayer.
void main() {
  tz.initializeTimeZones();
  // final location = tz.getLocation('America/New_York');
  final location = tz.getLocation('Asia/Dhaka');

  // Definitions
  DateTime date = tz.TZDateTime.from(DateTime.now(), location);

  PrayerTimes prayerTimes = PrayerTimes(
      date: date,
      coordinates: Coordinates(23.783014, 90.397082),
      calculationParameters: CalculationMethodParameters.muslimWorldLeague());

  for (Prayer prayer in Prayer.values) {
    final time = prayerTimes.timeForPrayer(prayer);
    log('${time?.toIso8601String().split("T").last ?? 'Null Found'} -> ${prayer.name}',
        name: 'Prayer');
  }
}
