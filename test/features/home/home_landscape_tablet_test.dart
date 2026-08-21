import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/fasting_sunnah_card.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/forbidden_prayer_times_card.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_times_horizontal_card.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  final coordinates = const Coordinates(23.8103, 90.4125);
  final parameters = CalculationParameters(
    method: CalculationMethodEnum.muslimWorldLeague,
    fajrAngle: 18.0,
    ishaAngle: 17.0,
  );
  final testDate = DateTime(2026, 8, 21, 12, 0, 0);
  final prayerTimes = PrayerTimes(
    coordinates: coordinates,
    date: testDate,
    calculationParameters: parameters,
    precision: true,
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    await ReminderScheduler.init();
  });

  Widget buildTestableWidget(Widget child, {Size size = const Size(840, 390)}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LanguageCubit(usedAppLanguageMap.first)),
        BlocProvider(create: (_) => PrayerReminderCubit()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(size: size),
          child: Scaffold(
            body: child,
          ),
        ),
      ),
    );
  }

  group('Landscape and Tablet UI Tests', () {
    testWidgets('Prayer landscape dashboard widgets render without overflow', (tester) async {
      // Mobile Landscape Screen Size (840 x 390)
      tester.view.physicalSize = const Size(840, 390);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestableWidget(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PrayerTimesHorizontalCard(prayerTimes: prayerTimes),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FastingSunnahCard(prayerTimes: prayerTimes),
            ),
          ],
        ),
        size: const Size(840, 390),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('Suhur End'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('ForbiddenPrayerTimesCard renders properly in landscape', (tester) async {
      tester.view.physicalSize = const Size(840, 390);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestableWidget(
        SingleChildScrollView(
          child: ForbiddenPrayerTimesCard(prayerTimes: prayerTimes),
        ),
        size: const Size(840, 390),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Forbidden Salat Times'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
