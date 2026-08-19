import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/search/data/models/search_result_model.dart";
import "package:al_quran_v3/src/features/search/presentation/screens/quran_search_screen.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/direct_jump_card.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_result_card.dart";
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
  });
}
