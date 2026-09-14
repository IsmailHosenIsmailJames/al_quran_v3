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
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_state.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/app_language_settings.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/settings_page.dart";
import "package:al_quran_v3/src/features/settings/presentation/widgets/others_settings.dart";
import "package:al_quran_v3/src/features/settings/presentation/widgets/theme_settings.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class FakeOthersSettingsCubit extends Cubit<OthersSettingsState>
    implements OthersSettingsCubit {
  FakeOthersSettingsCubit() : super(const OthersSettingsState());

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeAuthCubit extends Cubit<AuthState> implements AuthCubit {
  FakeAuthCubit() : super(const Unauthenticated());

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    Hive.init("./test_hive_settings_responsive");
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
        BlocProvider<OthersSettingsCubit>(
          create: (context) => FakeOthersSettingsCubit(),
        ),
        BlocProvider<AuthCubit>(create: (context) => FakeAuthCubit()),
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

  group("SettingsPage Responsive UI Tests", () {
    testWidgets(
      "Mobile layout (<880px) renders top quick-jump bar and bounded single column",
      (tester) async {
        tester.view.physicalSize = const Size(420, 850);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(createTestWidget(child: const SettingsPage()));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        // Verify top quick jump bar ActionChips exist
        expect(find.byType(ActionChip), findsWidgets);
        expect(find.widgetWithText(ActionChip, "App Theme"), findsOneWidget);
        expect(find.widgetWithText(ActionChip, "Audio Settings"), findsOneWidget);

        // Verify theme settings section is rendered
        expect(find.byType(ThemeSettings), findsOneWidget);

        await tester.pumpWidget(const SizedBox());
        await tester.pump();
      },
    );

    testWidgets(
      "Desktop layout (>=880px) renders Master-Detail Two-Pane layout",
      (tester) async {
        tester.view.physicalSize = const Size(1200, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(createTestWidget(child: const SettingsPage()));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        // Top ActionChips should not be present in two-pane mode
        expect(find.byType(ActionChip), findsNothing);

        // Verify master sidebar categories
        expect(find.text("App Theme"), findsWidgets);
        expect(find.text("Dark mode & Accent colors"), findsOneWidget);
        expect(find.text("Others"), findsOneWidget);
        expect(find.text("Language & Preferences"), findsOneWidget);

        // Selected category defaults to 0 (App Theme)
        expect(find.byType(ThemeSettings), findsOneWidget);

        // Tap 'Others' in master sidebar
        await tester.tap(find.text("Others"));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        // Detail view now shows OthersSettings
        expect(find.byType(OthersSettings), findsOneWidget);

        await tester.pumpWidget(const SizedBox());
        await tester.pump();
      },
    );
  });

  group("AppLanguageSettings Responsive UI Tests", () {
    testWidgets(
      "Wide screen (>=650px) renders GridView for languages",
      (tester) async {
        tester.view.physicalSize = const Size(1000, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(createTestWidget(child: const AppLanguageSettings()));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        expect(find.byType(GridView), findsOneWidget);
        expect(find.byType(ListView), findsNothing);

        await tester.pumpWidget(const SizedBox());
        await tester.pump();
      },
    );

    testWidgets(
      "Narrow screen (<650px) renders ListView for languages",
      (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(createTestWidget(child: const AppLanguageSettings()));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(GridView), findsNothing);

        await tester.pumpWidget(const SizedBox());
        await tester.pump();
      },
    );
  });
}
