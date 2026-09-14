import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/search/data/models/search_result_model.dart";
import "package:al_quran_v3/src/features/search/presentation/screens/quran_search_screen.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/direct_jump_card.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_result_card.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_filter_sheet.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_scope_tabs.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class TestNavigatorObserver extends NavigatorObserver {
  Route<dynamic>? lastPushedRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    lastPushedRoute = route;
    super.didPush(route, previousRoute);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    Hive.init("./test_hive_search_ui");
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
  });

  tearDownAll(() async {
    await Hive.close();
  });

  Widget createTestWidget({Widget? child, NavigatorObserver? observer}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit(null)),
      ],
      child: MaterialApp(
        navigatorObservers: observer != null ? [observer] : const [],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale("en"),
        home: child ?? const QuranSearchScreen(),
      ),
    );
  }

  group("QuranSearchScreen UI Widget Tests", () {
    testWidgets("renders search input, scope tabs, and search guide card", (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify search input field exists
      expect(find.byType(TextField), findsOneWidget);

      // Verify Scope tabs exist
      expect(find.byType(SearchScopeTabs), findsOneWidget);
      expect(find.text("All"), findsOneWidget);
      expect(find.text("Arabic"), findsOneWidget);

      // Verify search guide card exists
      expect(find.text("Search the Holy Quran"), findsOneWidget);
    });

    testWidgets("opens filter bottom sheet when filter icon is tapped", (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      final filterBtn = find.byIcon(FluentIcons.options_20_regular);
      expect(filterBtn, findsOneWidget);

      await tester.tap(filterBtn);
      await tester.pumpAndSettle();

      // Verify filter bottom sheet options
      expect(find.text("Search Filters & Options"), findsOneWidget);
      expect(find.text("Exact Phrase Match"), findsOneWidget);
      expect(find.text("Filter by Surah"), findsOneWidget);
      expect(find.text("Revelation Type"), findsOneWidget);
      expect(find.text("Apply"), findsOneWidget);
    });

    testWidgets("SearchResultCard opens QuranScriptView with full Surah ayah range (e.g. 2:286 for Baqarah)", (tester) async {
      final observer = TestNavigatorObserver();
      const ayahResult = AyahSearchResultModel(
        ayahKey: "2:8",
        surahNumber: 2,
        ayahNumber: 8,
        pageNumber: 2,
        juzNumber: 1,
        arabicText: "وَمِنَ النَّاسِ مَن يَقُولُ",
        matchedInArabic: true,
      );

      await tester.pumpWidget(
        createTestWidget(
          observer: observer,
          child: const Scaffold(
            body: SearchResultCard(
              ayahResult: ayahResult,
              query: "people",
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SearchResultCard));

      expect(observer.lastPushedRoute, isNotNull);
      final route = observer.lastPushedRoute as MaterialPageRoute;
      final BuildContext context = tester.element(find.byType(SearchResultCard));
      final widget = route.builder(context) as QuranScriptView;

      expect(widget.startKey, equals("2:1"));
      expect(widget.endKey, equals("2:286"));
      expect(widget.toScrollKey, equals("2:8"));
    });

    testWidgets("DirectAyahJumpCard opens QuranScriptView with full Surah ayah range (e.g. 2:286 for Baqarah)", (tester) async {
      final observer = TestNavigatorObserver();
      const directJump = DirectAyahJumpModel(
        ayahKey: "2:9",
        surahNumber: 2,
        ayahNumber: 9,
        surahName: "Al-Baqarah",
      );

      await tester.pumpWidget(
        createTestWidget(
          observer: observer,
          child: const Scaffold(
            body: DirectAyahJumpCard(
              directJump: directJump,
            ),
          ),
        ),
      );

      await tester.tap(find.text("Open"));

      expect(observer.lastPushedRoute, isNotNull);
      final route = observer.lastPushedRoute as MaterialPageRoute;
      final BuildContext context = tester.element(find.byType(DirectAyahJumpCard));
      final widget = route.builder(context) as QuranScriptView;

      expect(widget.startKey, equals("2:1"));
      expect(widget.endKey, equals("2:286"));
      expect(widget.toScrollKey, equals("2:9"));
    });

    testWidgets("Mobile layout (<700px) opens filter as a modal bottom sheet", (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      final filterBtn = find.byIcon(FluentIcons.options_20_regular);
      expect(filterBtn, findsOneWidget);

      await tester.tap(filterBtn);
      await tester.pumpAndSettle();

      // Verify bottom sheet modal
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text("Search Filters & Options"), findsOneWidget);
    });

    testWidgets("Tablet layout (700-980px) opens filter as a modal dialog", (tester) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      final filterBtn = find.byIcon(FluentIcons.options_20_regular);
      expect(filterBtn, findsOneWidget);

      await tester.tap(filterBtn);
      await tester.pumpAndSettle();

      // Verify dialog modal
      expect(find.byType(Dialog), findsOneWidget);
      expect(find.text("Search Filters & Options"), findsOneWidget);
    });

    testWidgets("Desktop layout (>=980px) renders responsive sidebar and keyboard shortcut hint", (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify 'Esc' shortcut hint is visible on desktop
      expect(find.text("Esc"), findsOneWidget);

      // On 1200px width (>=1100px), sidebar is open by default
      expect(find.byType(SearchFilterSheet), findsOneWidget);

      // Tap toggle button to collapse sidebar
      final toggleBtn = find.byIcon(FluentIcons.panel_right_contract_20_filled);
      expect(toggleBtn, findsOneWidget);
      await tester.tap(toggleBtn);
      await tester.pumpAndSettle();

      // Sidebar is now closed
      expect(find.byType(SearchFilterSheet), findsNothing);

      // Tap toggle button to open sidebar again
      final expandBtn = find.byIcon(FluentIcons.panel_right_expand_20_regular);
      expect(expandBtn, findsOneWidget);
      await tester.tap(expandBtn);
      await tester.pumpAndSettle();

      // Sidebar is back
      expect(find.byType(SearchFilterSheet), findsOneWidget);
    });
  });
}
