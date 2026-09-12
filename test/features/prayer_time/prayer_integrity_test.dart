import "dart:io";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/models/prayer_reminder_mode.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_settings_screen.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_times_horizontal_card.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce/hive.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late LocationQiblaPrayerDataCubit locationCubit;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp("hive_integrity_test_");
    Hive.init(tempDir.path);
    await Hive.openBox("user");
    await Hive.openBox("theme");
  });

  tearDownAll(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    await ReminderScheduler.init();
    locationCubit = LocationQiblaPrayerDataCubit();
  });

  tearDown(() {
    locationCubit.close();
  });

  group("Prayer Reminder Integrity & Single Source of Truth", () {
    test("Canonical fresh-install defaults match Balanced preset (Fajr=Alarm)", () {
      final modes = ReminderScheduler.getPrayerReminderModes();

      expect(modes[Prayer.fajr], equals(PrayerReminderMode.alarm));
      expect(modes[Prayer.dhuhr], equals(PrayerReminderMode.notification));
      expect(modes[Prayer.asr], equals(PrayerReminderMode.notification));
      expect(modes[Prayer.maghrib], equals(PrayerReminderMode.notification));
      expect(modes[Prayer.isha], equals(PrayerReminderMode.notification));
      expect(modes[Prayer.sunrise], equals(PrayerReminderMode.off));
      expect(modes[Prayer.sunset], equals(PrayerReminderMode.off));

      // Check single source of truth for enabled state
      expect(ReminderScheduler.isPrayerEnabled(Prayer.fajr), isTrue);
      expect(ReminderScheduler.isPrayerEnabled(Prayer.dhuhr), isTrue);
      expect(ReminderScheduler.isPrayerEnabled(Prayer.sunrise), isFalse);
    });

    test("togglePrayerReminder toggles off to Off and on to Alarm/Notification", () async {
      final cubit = PrayerReminderCubit();

      // Fajr defaults to Alarm (enabled)
      expect(cubit.state.prayerReminderModes?[Prayer.fajr], equals(PrayerReminderMode.alarm));
      expect(cubit.state.enabledPrayers?[Prayer.fajr], isTrue);

      // Toggle off
      await cubit.togglePrayerReminder(Prayer.fajr);
      expect(cubit.state.prayerReminderModes?[Prayer.fajr], equals(PrayerReminderMode.off));
      expect(cubit.state.enabledPrayers?[Prayer.fajr], isFalse);
      expect(ReminderScheduler.getPrayerReminderMode(Prayer.fajr), equals(PrayerReminderMode.off));
      expect(ReminderScheduler.isPrayerEnabled(Prayer.fajr), isFalse);

      // Toggle back on -> Restores to Alarm for Fajr
      await cubit.togglePrayerReminder(Prayer.fajr);
      expect(cubit.state.prayerReminderModes?[Prayer.fajr], equals(PrayerReminderMode.alarm));
      expect(cubit.state.enabledPrayers?[Prayer.fajr], isTrue);
      expect(ReminderScheduler.getPrayerReminderMode(Prayer.fajr), equals(PrayerReminderMode.alarm));
      expect(ReminderScheduler.isPrayerEnabled(Prayer.fajr), isTrue);

      // Dhuhr defaults to Notification (enabled)
      await cubit.togglePrayerReminder(Prayer.dhuhr);
      expect(cubit.state.prayerReminderModes?[Prayer.dhuhr], equals(PrayerReminderMode.off));
      expect(cubit.state.enabledPrayers?[Prayer.dhuhr], isFalse);

      // Toggle back on -> Restores to Notification for Dhuhr
      await cubit.togglePrayerReminder(Prayer.dhuhr);
      expect(cubit.state.prayerReminderModes?[Prayer.dhuhr], equals(PrayerReminderMode.notification));
      expect(cubit.state.enabledPrayers?[Prayer.dhuhr], isTrue);

      await cubit.close();
    });

    test("commitSetupConfiguration enables notifications and persists preset modes", () async {
      final cubit = PrayerReminderCubit();

      expect(ReminderScheduler.isPrayerRemindNotificationEnabled(), isFalse);

      await cubit.commitSetupConfiguration(preset: "balanced");

      expect(ReminderScheduler.isPrayerRemindNotificationEnabled(), isTrue);
      expect(cubit.state.isPrayerRemindNotificationEnabled, isTrue);
      expect(ReminderScheduler.getPrayerReminderMode(Prayer.fajr), equals(PrayerReminderMode.alarm));
      expect(ReminderScheduler.getPrayerReminderMode(Prayer.dhuhr), equals(PrayerReminderMode.notification));

      await cubit.close();
    });

    test("Bulk presets update both modes and enabledPrayers consistently", () async {
      final cubit = PrayerReminderCubit();

      await cubit.applyBulkPreset("all_alarm");
      for (final p in [Prayer.fajr, Prayer.dhuhr, Prayer.asr, Prayer.maghrib, Prayer.isha]) {
        expect(cubit.state.prayerReminderModes?[p], equals(PrayerReminderMode.alarm));
        expect(cubit.state.enabledPrayers?[p], isTrue);
        expect(ReminderScheduler.getPrayerReminderMode(p), equals(PrayerReminderMode.alarm));
      }

      await cubit.applyBulkPreset("all_notification");
      for (final p in [Prayer.fajr, Prayer.dhuhr, Prayer.asr, Prayer.maghrib, Prayer.isha]) {
        expect(cubit.state.prayerReminderModes?[p], equals(PrayerReminderMode.notification));
        expect(cubit.state.enabledPrayers?[p], isTrue);
        expect(ReminderScheduler.getPrayerReminderMode(p), equals(PrayerReminderMode.notification));
      }

      await cubit.close();
    });
  });

  group("Prayer Settings Screen Preset Integration", () {
    testWidgets("PrayerSettings displays quick preset chips and allows switching presets",
        (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final prayerTimes = PrayerTimes(
        coordinates: const Coordinates(23.8103, 90.4125),
        date: DateTime.now(),
        calculationParameters: CalculationMethodParameters.muslimWorldLeague(),
      );

      final reminderCubit = PrayerReminderCubit();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
            BlocProvider<LanguageCubit>(create: (_) => LanguageCubit(null)),
            BlocProvider<LocationQiblaPrayerDataCubit>.value(value: locationCubit),
            BlocProvider<PrayerReminderCubit>.value(value: reminderCubit),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale("en"),
            home: PrayerSettings(prayerTimes: prayerTimes),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Quick Presets label should be present
      expect(find.text("Quick Presets"), findsWidgets);
      expect(find.text("Balanced"), findsOneWidget);
      expect(find.text("All Alarms"), findsOneWidget);
      expect(find.text("All Notifications"), findsOneWidget);

      // Initially Balanced is selected
      expect(reminderCubit.state.prayerReminderModes?[Prayer.fajr], equals(PrayerReminderMode.alarm));
      expect(reminderCubit.state.prayerReminderModes?[Prayer.dhuhr], equals(PrayerReminderMode.notification));

      // Tap All Alarms
      await tester.ensureVisible(find.text("All Alarms"));
      await tester.tap(find.text("All Alarms"));
      await tester.pumpAndSettle();

      expect(reminderCubit.state.prayerReminderModes?[Prayer.dhuhr], equals(PrayerReminderMode.alarm));
      expect(ReminderScheduler.getPrayerReminderMode(Prayer.dhuhr), equals(PrayerReminderMode.alarm));

      reminderCubit.close();
    });

    testWidgets("Tapping prayer row opens timing offset sheet and adjusts minutes",
        (tester) async {
      tester.view.physicalSize = const Size(800, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final prayerTimes = PrayerTimes(
        coordinates: const Coordinates(23.8103, 90.4125),
        date: DateTime.now(),
        calculationParameters: CalculationMethodParameters.muslimWorldLeague(),
      );

      final reminderCubit = PrayerReminderCubit();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
            BlocProvider<LanguageCubit>(create: (_) => LanguageCubit(null)),
            BlocProvider<LocationQiblaPrayerDataCubit>.value(value: locationCubit),
            BlocProvider<PrayerReminderCubit>.value(value: reminderCubit),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale("en"),
            home: PrayerSettings(prayerTimes: prayerTimes),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Scroll down to Fajr in prayer alert modes card
      await tester.ensureVisible(find.text("Fajr"));
      await tester.tap(find.text("Fajr"));
      await tester.pumpAndSettle();

      // Bottom sheet should be visible with Close button
      expect(find.text("Close"), findsOneWidget);

      // Tap +5 m chip
      await tester.tap(find.text("+5 m").last);
      await tester.pumpAndSettle();

      expect(reminderCubit.state.reminderTimeAdjustment?[Prayer.fajr], equals(5));

      // Close bottom sheet
      await tester.tap(find.text("Close"));
      await tester.pumpAndSettle();

      // Fajr row now shows badge "+5 m"
      expect(find.text("+5 m"), findsOneWidget);

      reminderCubit.close();
    });
  });

  group("PrayerTimesHorizontalCard 3-Way Mode Selection", () {
    testWidgets("tapping a prayer column displays 3 modes and changes Fajr to Notification",
        (tester) async {
      tester.view.physicalSize = const Size(800, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final prayerTimes = PrayerTimes(
        coordinates: const Coordinates(23.8103, 90.4125),
        date: DateTime.now(),
        calculationParameters: CalculationMethodParameters.muslimWorldLeague(),
      );

      final reminderCubit = PrayerReminderCubit();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
            BlocProvider<LanguageCubit>(create: (_) => LanguageCubit(null)),
            BlocProvider<LocationQiblaPrayerDataCubit>.value(value: locationCubit),
            BlocProvider<PrayerReminderCubit>.value(value: reminderCubit),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale("en"),
            home: Scaffold(
              body: PrayerTimesHorizontalCard(prayerTimes: prayerTimes),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open Fajr sheet
      await tester.tap(find.text("Fajr"));
      await tester.pumpAndSettle();

      // Verify 3 modes exist
      expect(find.text("Off"), findsOneWidget);
      expect(find.text("Notification"), findsOneWidget);
      expect(find.text("Alarm"), findsOneWidget);

      // Switch Fajr to Notification
      await tester.tap(find.text("Notification"));
      await tester.pumpAndSettle();

      expect(reminderCubit.state.prayerReminderModes?[Prayer.fajr], equals(PrayerReminderMode.notification));
      expect(ReminderScheduler.getPrayerReminderMode(Prayer.fajr), equals(PrayerReminderMode.notification));

      reminderCubit.close();
    });
  });
}
