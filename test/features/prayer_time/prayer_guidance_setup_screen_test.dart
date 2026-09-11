import "dart:io";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/models/prayer_reminder_mode.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_guidance_setup_screen.dart";
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
    tempDir = await Directory.systemTemp.createTemp("hive_guidance_test_");
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

  Widget createWidgetUnderTest({bool isFromSettings = false}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<LocationQiblaPrayerDataCubit>.value(value: locationCubit),
        BlocProvider<PrayerReminderCubit>(create: (_) => PrayerReminderCubit()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale("en"),
        home: PrayerGuidanceSetupScreen(isFromSettings: isFromSettings),
      ),
    );
  }

  testWidgets("PrayerGuidanceSetupScreen renders Location section and bottom bar with Skip and Save buttons",
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;

    await tester.pumpWidget(createWidgetUnderTest(isFromSettings: false));
    await tester.pumpAndSettle();

    // Verify title
    expect(find.text("Prayer Settings"), findsNWidgets(2)); // AppBar + Section

    // Verify Location Required card
    expect(find.text("Prayer Location Required"), findsOneWidget);
    expect(find.text("Allow Location"), findsOneWidget);
    expect(find.text("Manual Location"), findsOneWidget);

    // Verify Skip buttons (AppBar + BottomBar)
    expect(find.text("Skip"), findsNWidgets(2));

    // Verify Save & Get Started in bottom bar
    expect(find.text("Save & Get Started"), findsOneWidget);

    // Verify Quick Presets are present
    expect(find.text("Quick Presets"), findsOneWidget);
    expect(find.text("Balanced"), findsOneWidget);
    expect(find.text("All Alarms"), findsOneWidget);
    expect(find.text("All Notifications"), findsOneWidget);

    // Verify all 6 prayers are present
    expect(find.text("Fajr"), findsOneWidget);
    expect(find.text("Sunrise"), findsOneWidget);
    expect(find.text("Dhuhr"), findsOneWidget);
    expect(find.text("Asr"), findsOneWidget);
    expect(find.text("Maghrib"), findsOneWidget);
    expect(find.text("Isha"), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets("Setting location updates UI to show Selected Location and Change button",
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;

    await tester.pumpWidget(createWidgetUnderTest(isFromSettings: false));
    await tester.pumpAndSettle();

    expect(find.text("Prayer Location Required"), findsOneWidget);

    // Save location to cubit
    await locationCubit.saveLocationData(
      const LatLon(latitude: 23.8103, longitude: 90.4125),
      save: true,
    );
    await tester.pumpAndSettle();

    // Verify UI updated to Selected Location
    expect(find.text("Selected Location"), findsOneWidget);
    expect(find.text("Change"), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets("PrayerGuidanceSetupScreen in settings mode shows Save & Return without Skip",
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;

    await tester.pumpWidget(createWidgetUnderTest(isFromSettings: true));
    await tester.pumpAndSettle();

    // In settings mode, title is Prayer Reminders Guide & Setup
    expect(find.text("Prayer Reminders Guide & Setup"), findsOneWidget);

    // No Skip button
    expect(find.text("Skip"), findsNothing);

    // Save & Return button in bottom bar
    expect(find.text("Save & Return"), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets("Tapping presets updates reminder modes in cubit",
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;

    await tester.pumpWidget(createWidgetUnderTest(isFromSettings: false));
    await tester.pumpAndSettle();

    // Tap All Alarms preset
    await tester.tap(find.text("All Alarms"));
    await tester.pumpAndSettle();

    // Verify All Alarms selected
    expect(ReminderScheduler.getPrayerReminderMode(Prayer.dhuhr),
        equals(PrayerReminderMode.alarm));

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets("Lifecycle resume triggers permission checks automatically",
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;

    await tester.pumpWidget(createWidgetUnderTest(isFromSettings: false));
    await tester.pumpAndSettle();

    // Simulate backgrounding and resuming app
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    // Screen should rebuild without error
    expect(find.text("Save & Get Started"), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets("PrayerGuidanceSetupScreen renders on narrow 320px screen without any overflows",
      (tester) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(createWidgetUnderTest(isFromSettings: false));
    await tester.pumpAndSettle();

    // Verify bottom bar button is visible
    expect(find.text("Save & Get Started"), findsOneWidget);

    // Scroll to verify Fajr is rendered without overflow
    await tester.scrollUntilVisible(find.text("Fajr"), 100);
    expect(find.text("Fajr"), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
