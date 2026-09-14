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
import "package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart";
import "package:al_quran_v3/src/features/home/domain/repositories/i_history_repository.dart";
import "package:al_quran_v3/src/features/home/domain/usecases/add_history_usecase.dart";
import "package:al_quran_v3/src/features/home/domain/usecases/get_history_usecase.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class FakeHistoryRepo implements IHistoryRepository {
  final List<HistoryElementEntity> _storage = [];
  @override
  List<HistoryElementEntity> getHistory() => List.unmodifiable(_storage);
  @override
  Future<void> addHistory({required int surahNumber, int? ayahNumber, int? pageNumber}) async {}
  @override
  Future<void> clearHistory() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FakeHistoryRepo fakeHistoryRepo;
  late QuranHistoryCubit quranHistoryCubit;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    Hive.init("./test_hive_quran_script_view_responsive");
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }

    final Map mockScriptMap = {};
    for (int surah = 1; surah <= 114; surah++) {
      mockScriptMap["$surah"] = {};
      for (int ayah = 1; ayah <= 286; ayah++) {
        mockScriptMap["$surah"]["$ayah"] = ["كلمة", "تجريبية"];
      }
    }
    QuranScriptFunction.quranScriptMap = mockScriptMap;
    QuranScriptFunction.currentScript = QuranScriptType.uthmani;
  });

  setUp(() {
    fakeHistoryRepo = FakeHistoryRepo();
    quranHistoryCubit = QuranHistoryCubit(
      getHistoryUseCase: GetHistoryUseCase(fakeHistoryRepo),
      addHistoryUseCase: AddHistoryUseCase(fakeHistoryRepo),
    );
  });

  tearDownAll(() async {
    await Hive.close();
  });

  Widget buildWrapper({
    required Widget child,
    required AyahToHighlight ayahToHighlight,
    required AyahByAyahInScrollInfoCubit ayahScrollInfoCubit,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit(null)),
        BlocProvider(create: (context) => AyahKeyCubit()),
        BlocProvider.value(value: ayahToHighlight),
        BlocProvider.value(value: ayahScrollInfoCubit),
        BlocProvider.value(value: quranHistoryCubit),
        BlocProvider(create: (context) => SegmentedQuranReciterCubit()),
        BlocProvider(create: (context) => QuranViewCubit()),
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

  group("QuranScriptView Responsive Tests", () {
    testWidgets(
      "Wide screen (1200px) shows collapsible sidebar, bounded reading area (<=960px), and search input",
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final ayahToHighlight = AyahToHighlight();
        final ayahScrollInfoCubit = AyahByAyahInScrollInfoCubit();

        await tester.pumpWidget(
          buildWrapper(
            ayahToHighlight: ayahToHighlight,
            ayahScrollInfoCubit: ayahScrollInfoCubit,
            child: const QuranScriptView(
              startKey: "1:1",
              endKey: "1:7",
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 1. Sidebar should be visible on 1200px wide screen
        expect(find.byTooltip("Hide sidebar (Ctrl+B)"), findsOneWidget);
        // BackButton must be present in AppBar alongside sidebar toggle
        expect(find.byType(BackButton), findsOneWidget);

        // 2. Surah Search TextField should be present in sidebar
        expect(find.byType(TextField), findsOneWidget);

        // 3. Reading content should have BoxConstraints with maxWidth 960
        final constrainedBoxFinder = find.byWidgetPredicate(
          (widget) =>
              widget is ConstrainedBox &&
              widget.constraints.maxWidth == 960,
        );
        expect(constrainedBoxFinder, findsWidgets);

        // 4. Desktop font size (13.5) should be present for Surah items
        final textWidgets = tester.widgetList<Text>(find.byType(Text));
        expect(textWidgets.any((t) => t.style?.fontSize == 13.5), isTrue);

        // 5. Test collapsing the sidebar
        await tester.tap(find.byTooltip("Hide sidebar (Ctrl+B)"));
        await tester.pumpAndSettle();

        // Sidebar is now hidden, AppBar should show with "Show sidebar (Ctrl+B)" button and BackButton
        expect(find.byTooltip("Show sidebar (Ctrl+B)"), findsOneWidget);
        expect(find.byType(BackButton), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);

        // 6. Test expanding the sidebar again
        await tester.tap(find.byTooltip("Show sidebar (Ctrl+B)"));
        await tester.pumpAndSettle();
        expect(find.byTooltip("Hide sidebar (Ctrl+B)"), findsOneWidget);
        expect(find.byType(BackButton), findsOneWidget);
      },
    );

    testWidgets(
      "Narrow mobile screen (400px) shows top AppBar and no sidebar",
      (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final ayahToHighlight = AyahToHighlight();
        final ayahScrollInfoCubit = AyahByAyahInScrollInfoCubit();

        await tester.pumpWidget(
          buildWrapper(
            ayahToHighlight: ayahToHighlight,
            ayahScrollInfoCubit: ayahScrollInfoCubit,
            child: const QuranScriptView(
              startKey: "1:1",
              endKey: "1:7",
            ),
          ),
        );
        await tester.pumpAndSettle();

        // On mobile, AppBar is shown and sidebar collapse/expand toggle is absent
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byTooltip("Hide sidebar (Ctrl+B)"), findsNothing);
        expect(find.byTooltip("Show sidebar (Ctrl+B)"), findsNothing);
      },
    );

    testWidgets(
      "Sidebar search field filters Surahs properly",
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final ayahToHighlight = AyahToHighlight();
        final ayahScrollInfoCubit = AyahByAyahInScrollInfoCubit();

        await tester.pumpWidget(
          buildWrapper(
            ayahToHighlight: ayahToHighlight,
            ayahScrollInfoCubit: ayahScrollInfoCubit,
            child: const QuranScriptView(
              startKey: "1:1",
              endKey: "1:7",
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Search for "18" (Al-Kahf)
        await tester.enterText(find.byType(TextField), "18");
        await tester.pumpAndSettle();

        expect(find.text("18. "), findsOneWidget);
        // Surah 1 should not be listed in filtered results
        expect(find.text("1. "), findsNothing);
      },
    );

    testWidgets(
      "Sidebar search supports English meanings, aliases, and Ayah format via SurahSearchEngine",
      (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final ayahToHighlight = AyahToHighlight();
        final ayahScrollInfoCubit = AyahByAyahInScrollInfoCubit();

        await tester.pumpWidget(
          buildWrapper(
            ayahToHighlight: ayahToHighlight,
            ayahScrollInfoCubit: ayahScrollInfoCubit,
            child: const QuranScriptView(
              startKey: "1:1",
              endKey: "1:7",
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 1. Search for "Cow" (English meaning of Al-Baqarah)
        await tester.enterText(find.byType(TextField), "Cow");
        await tester.pumpAndSettle();

        expect(find.text("2. "), findsOneWidget);
        expect(find.text("1. "), findsNothing);

        // 2. Search for "Yaseen" (Phonetic variant alias)
        await tester.enterText(find.byType(TextField), "Yaseen");
        await tester.pumpAndSettle();

        expect(find.text("36. "), findsOneWidget);

        // 3. Search for "2:255" (Ayah format)
        await tester.enterText(find.byType(TextField), "2:255");
        await tester.pumpAndSettle();

        expect(find.text("2. "), findsOneWidget);
        expect(find.text("Al-Baqarah (2:255)"), findsOneWidget);
      },
    );
  });
}
