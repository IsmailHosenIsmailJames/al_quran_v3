import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/fasting_sunnah_card.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_times_horizontal_card.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  final coordinates = const Coordinates(23.8103, 90.4125); // Dhaka
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

  Widget buildTestableWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LanguageCubit(usedAppLanguageMap.first)),
        BlocProvider(create: (_) => PrayerReminderCubit()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(child: child),
        ),
      ),
    );
  }

  group('PrayerTimesHorizontalCard Tests', () {
    testWidgets('renders all 5 core prayers (Fajr, Dhuhr, Asr, Maghrib, Isha)', (tester) async {
      await tester.pumpWidget(buildTestableWidget(
        PrayerTimesHorizontalCard(prayerTimes: prayerTimes),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('Dhuhr'), findsOneWidget);
      expect(find.text('Asr'), findsOneWidget);
      expect(find.text('Maghrib'), findsOneWidget);
      expect(find.text('Isha'), findsOneWidget);
    });

    testWidgets('tapping on a prayer column opens reminder adjustment sheet', (tester) async {
      await tester.pumpWidget(buildTestableWidget(
        PrayerTimesHorizontalCard(prayerTimes: prayerTimes),
      ));
      await tester.pumpAndSettle();

      // Tap on Fajr
      await tester.tap(find.text('Fajr'));
      await tester.pumpAndSettle();

      // Modal bottom sheet should show up with title
      expect(find.text('Enable Prayer Reminders'), findsOneWidget);
    });
  });

  group('FastingSunnahCard Tests', () {
    testWidgets('renders Suhur End, Iftar Start, and Tahajjud Start in 3 columns', (tester) async {
      await tester.pumpWidget(buildTestableWidget(
        FastingSunnahCard(prayerTimes: prayerTimes),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Suhur End'), findsOneWidget);
      expect(find.text('Iftar Start'), findsOneWidget);
      expect(find.text('Tahajjud Start'), findsOneWidget);
    });
  });
}
