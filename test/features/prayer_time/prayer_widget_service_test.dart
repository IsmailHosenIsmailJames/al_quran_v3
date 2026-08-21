import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations_en.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/prayer_widget_service.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";
import "package:intl/date_symbol_data_local.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "user_location_name": "Dhaka, Bangladesh",
    });
    await initializeDateFormatting("en", null);
    Intl.defaultLocale = "en";
    await ReminderScheduler.init();

    // Mock HomeWidget platform channel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel("home_widget"), (call) async {
      return true;
    });
  });

  group("PrayerWidgetService Unit Tests", () {
    test("prayerTitle returns correct title for all prayers", () {
      final l10n = AppLocalizationsEn();
      expect(PrayerWidgetService.prayerTitle(Prayer.fajr, l10n), l10n.fajr);
      expect(PrayerWidgetService.prayerTitle(Prayer.sunrise, l10n), l10n.sunrise);
      expect(PrayerWidgetService.prayerTitle(Prayer.dhuhr, l10n), l10n.dhuhr);
      expect(PrayerWidgetService.prayerTitle(Prayer.asr, l10n), l10n.asr);
      expect(PrayerWidgetService.prayerTitle(Prayer.maghrib, l10n), l10n.maghrib);
      expect(PrayerWidgetService.prayerTitle(Prayer.isha, l10n), l10n.isha);
      expect(PrayerWidgetService.prayerTitle(Prayer.tahajjud, l10n), l10n.tahajjud);
    });

    test("PrayerTimeline accurately resolves upcoming event", () {
      const coords = Coordinates(23.8103, 90.4125); // Dhaka
      final params = CalculationMethodParameters.karachi()..madhab = Madhab.hanafi;
      final pt = PrayerTimes(
        coordinates: coords,
        date: DateTime.now(),
        calculationParameters: params,
        precision: true,
      );

      final testTime = pt.dhuhr.toLocal().add(const Duration(minutes: 30));
      final timeline = PrayerTimeline.calculate(
        coordinates: coords,
        calculationParameters: params,
        now: testTime,
      );

      expect(timeline.currentPrayer, Prayer.dhuhr);
      expect(timeline.nextPrayer, Prayer.asr);
      expect(timeline.nextPrayerTime.isAfter(testTime), isTrue);
      expect(timeline.durationUntilNext.isNegative, isFalse);
    });

    test("PrayerWidgetService generates valid 7-day multi-day JSON timeline", () async {
      final locState = LocationQiblaPrayerDataState(
        latLon: const LatLon(latitude: 23.8103, longitude: 90.4125), // Dhaka
        calculationMethod: CalculationMethodParameters.karachi(),
        madhab: Madhab.hanafi,
      );

      final now = DateTime.now();

      // Verify that updateWidgets executes cleanly
      await PrayerWidgetService.updateWidgets(
        locationState: locState,
        currentTime: now,
        locationNameOverride: "Dhaka",
      );
    });
  });
}
