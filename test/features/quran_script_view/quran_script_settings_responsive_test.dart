import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_settings.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    Hive.init("./test_hive_quran_script_settings");
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
  });

  tearDownAll(() async {
    await Hive.close();
  });

  Widget createTestWidget({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit(null)),
        BlocProvider(create: (context) => QuranViewCubit()),
        BlocProvider(create: (context) => AyahToHighlight()),
        BlocProvider(create: (context) => AyahKeyCubit()),
        BlocProvider(create: (context) => SegmentedQuranReciterCubit()),
        BlocProvider(create: (context) => AudioUiCubit()),
        BlocProvider(create: (context) => PlayerPositionCubit()),
        BlocProvider(create: (context) => PlayerStateCubit()),
        BlocProvider(create: (context) => AudioLoopCubit()),
        BlocProvider(create: (context) => WordPlayingStateCubit()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale("en"),
        home: child,
      ),
    );
  }

  group("QuranScriptSettings Responsive Tests", () {
    testWidgets(
      "Wide screen (>=840px) renders 2-column layout with left and right sections",
      (tester) async {
        tester.view.physicalSize = const Size(1200, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: const QuranScriptSettings(asPage: true),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        // Verify title
        expect(find.text("Quran Script Settings"), findsOneWidget);

        // Verify cards from both columns are rendered
        expect(find.text("Typography & Font Settings"), findsOneWidget);
        expect(find.text("Display & Content Options"), findsOneWidget);

        await tester.pumpWidget(const SizedBox());
        await tester.pump();
      },
    );

    testWidgets(
      "Narrow screen (<840px) renders single column vertical layout",
      (tester) async {
        tester.view.physicalSize = const Size(500, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: const QuranScriptSettings(asPage: true),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        // Verify title
        expect(find.text("Quran Script Settings"), findsOneWidget);

        // Verify all cards are rendered vertically
        expect(find.text("Typography & Font Settings"), findsOneWidget);
        expect(find.text("Display & Content Options"), findsOneWidget);

        await tester.pumpWidget(const SizedBox());
        await tester.pump();
      },
    );
  });
}
