import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/search/presentation/screens/quran_search_screen.dart";
import "package:al_quran_v3/src/features/search/presentation/widgets/search_scope_tabs.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:shared_preferences/shared_preferences.dart";

import "package:al_quran_v3/src/core/localization/language_cubit.dart";

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

  Widget createTestWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit(null)),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale("en"),
        home: QuranSearchScreen(),
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
  });
}
