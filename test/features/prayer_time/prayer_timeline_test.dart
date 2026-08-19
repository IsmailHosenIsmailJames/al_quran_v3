import 'package:adhan_dart/adhan_dart.dart';
import 'package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrayerTimeline Continuous Calculation Tests', () {
    final coordinates = Coordinates(24.2513, 89.9167); // Tangail, Bangladesh
    final parameters = CalculationParameters(
      method: CalculationMethodEnum.muslimWorldLeague,
      fajrAngle: 18.0,
      ishaAngle: 17.0,
    );

    test('Midnight (12:41 AM) calculates accurate remaining time (< 3 hours, not 25+ hours)', () {
      final now = DateTime(2026, 8, 19, 0, 41, 0); // 12:41 AM

      final timeline = PrayerTimeline.calculate(
        coordinates: coordinates,
        calculationParameters: parameters,
        now: now,
      );

      // Current should be Isha (from yesterday evening)
      expect(timeline.currentPrayer, Prayer.isha);
      // Next should be Tahajjud (at ~2:39 AM today)
      expect(timeline.nextPrayer, Prayer.tahajjud);
      // Remaining duration should be strictly under 2 hours (~1h 58m)
      expect(timeline.durationUntilNext.inHours, lessThan(3));
      expect(timeline.durationUntilNext.inMinutes, greaterThan(60));
      expect(timeline.durationUntilNext.inMinutes, lessThan(120));
      expect(timeline.progressElapsed, inInclusiveRange(0.0, 1.0));
    });

    test('Mid-Tahajjud (03:00 AM) transitions next prayer to Fajr', () {
      final now = DateTime(2026, 8, 19, 3, 0, 0); // 3:00 AM

      final timeline = PrayerTimeline.calculate(
        coordinates: coordinates,
        calculationParameters: parameters,
        now: now,
      );

      expect(timeline.currentPrayer, Prayer.tahajjud);
      expect(timeline.nextPrayer, Prayer.fajr);
      expect(timeline.durationUntilNext.inHours, lessThan(2));
      expect(timeline.progressElapsed, inInclusiveRange(0.0, 1.0));
    });

    test('Morning (04:30 AM) transitions current to Fajr and next to Sunrise', () {
      final now = DateTime(2026, 8, 19, 4, 30, 0); // 4:30 AM

      final timeline = PrayerTimeline.calculate(
        coordinates: coordinates,
        calculationParameters: parameters,
        now: now,
      );

      expect(timeline.currentPrayer, Prayer.fajr);
      expect(timeline.nextPrayer, Prayer.sunrise);
      expect(timeline.durationUntilNext.inMinutes, lessThan(120));
    });

    test('Afternoon (01:00 PM) transitions current to Dhuhr and next to Asr', () {
      final now = DateTime(2026, 8, 19, 13, 0, 0); // 1:00 PM

      final timeline = PrayerTimeline.calculate(
        coordinates: coordinates,
        calculationParameters: parameters,
        now: now,
      );

      expect(timeline.currentPrayer, Prayer.dhuhr);
      expect(timeline.nextPrayer, Prayer.asr);
      expect(timeline.durationUntilNext.inHours, lessThan(4));
    });

    test('Evening (08:00 PM) transitions current to Isha and next to Tahajjud/Fajr', () {
      final now = DateTime(2026, 8, 19, 20, 0, 0); // 8:00 PM

      final timeline = PrayerTimeline.calculate(
        coordinates: coordinates,
        calculationParameters: parameters,
        now: now,
      );

      expect(timeline.currentPrayer, Prayer.isha);
      expect(timeline.nextPrayer, Prayer.tahajjud);
      expect(timeline.durationUntilNext.inHours, lessThan(10));
    });

    test('Late Night (11:55 PM) stays continuous without day-rollover glitch', () {
      final now = DateTime(2026, 8, 19, 23, 55, 0); // 11:55 PM

      final timeline = PrayerTimeline.calculate(
        coordinates: coordinates,
        calculationParameters: parameters,
        now: now,
      );

      expect(timeline.currentPrayer, Prayer.isha);
      expect(timeline.nextPrayer, Prayer.tahajjud);
      expect(timeline.durationUntilNext.inHours, lessThan(5));
      expect(timeline.progressElapsed, inInclusiveRange(0.0, 1.0));
    });
  });
}
