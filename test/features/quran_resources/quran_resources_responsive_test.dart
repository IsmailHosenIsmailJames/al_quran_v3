import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart";
import "package:al_quran_v3/src/features/quran_resources/domain/entities/resource_group_entity.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/screens/quran_resources_screen.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_language_group_card.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_tab_bar.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/translation_resources_tab.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/widgets/word_by_word_resources_tab.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class FakeQuranResourcesCubit extends Cubit<QuranResourcesState>
    implements QuranResourcesCubit {
  FakeQuranResourcesCubit([QuranResourcesState? initialState])
      : super(initialState ?? const QuranResourcesState());

  @override
  Future<void> loadResources({int? initTab}) async {}

  @override
  void changeTab(int index) {
    emit(state.copyWith(activeTabIndex: index));
  }

  @override
  void toggleSearching() {
    emit(state.copyWith(isSearching: !state.isSearching));
  }

  @override
  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  @override
  Future<void> downloadResource(QuranResourceEntity resource) async {}

  @override
  Future<void> toggleSelection(QuranResourceEntity resource) async {}

  @override
  Future<void> deleteResource(QuranResourceEntity resource) async {}

  @override
  Future<void> redownloadResource(QuranResourceEntity resource) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testResource1 = QuranResourceEntity(
    id: "1",
    name: "Sahih International",
    englishName: "Sahih International",
    language: "English",
    languageCode: "en",
    languageNative: "English",
    fileName: "en.sahih.json",
    fullPath: "en/en.sahih.json",
    type: ResourceType.with_footnote,
    isDownloaded: true,
    isSelected: true,
  );

  const testResource2 = QuranResourceEntity(
    id: "2",
    name: "Clear Quran",
    englishName: "Dr. Mustafa Khattab",
    language: "English",
    languageCode: "en",
    languageNative: "English",
    fileName: "en.clear.json",
    fullPath: "en/en.clear.json",
    type: ResourceType.simple,
    isDownloaded: false,
    isSelected: false,
  );

  const testGroup = ResourceGroupEntity(
    languageKey: "en",
    languageNative: "English",
    languageEnglish: "English",
    resources: [testResource1, testResource2],
  );

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    Hive.init("./test_hive_quran_resources_responsive");
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
  });

  tearDownAll(() async {
    await Hive.close();
  });

  Widget buildTestableWidget({
    required Widget child,
    required QuranResourcesCubit cubit,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider<QuranResourcesCubit>.value(value: cubit),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale("en"),
        home: child,
      ),
    );
  }

  group("QuranResources Responsive Tests", () {
    testWidgets("ResourceTabBar is constrained to maxWidth 540 on wide screen",
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final cubit = FakeQuranResourcesCubit();
      final tabController = TabController(length: 3, vsync: const TestVSync());

      await tester.pumpWidget(
        buildTestableWidget(
          cubit: cubit,
          child: Scaffold(
            body: ResourceTabBar(tabController: tabController),
          ),
        ),
      );

      final constrainedBoxFinder = find.byWidgetPredicate(
        (widget) =>
            widget is ConstrainedBox &&
            widget.constraints.maxWidth == 540,
      );
      expect(constrainedBoxFinder, findsOneWidget);

      final RenderBox box = tester.renderObject(constrainedBoxFinder);
      expect(box.size.width, lessThanOrEqualTo(540));
    });

    testWidgets(
        "ResourceLanguageGroupCard uses 2-column grid when wide and expanded",
        (tester) async {
      tester.view.physicalSize = const Size(1000, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final cubit = FakeQuranResourcesCubit();
      const state = QuranResourcesState();

      await tester.pumpWidget(
        buildTestableWidget(
          cubit: cubit,
          child: const Scaffold(
            body: SingleChildScrollView(
              child: ResourceLanguageGroupCard(
                group: testGroup,
                state: state,
                forceExpanded: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should render 2 items side-by-side in a Row on wide screen
      final rowFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.whereType<Expanded>().length == 2,
      );
      expect(rowFinder, findsOneWidget);
    });

    testWidgets(
        "ResourceLanguageGroupCard uses single-column Column when narrow",
        (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final cubit = FakeQuranResourcesCubit();
      const state = QuranResourcesState();

      await tester.pumpWidget(
        buildTestableWidget(
          cubit: cubit,
          child: const Scaffold(
            body: SingleChildScrollView(
              child: ResourceLanguageGroupCard(
                group: testGroup,
                state: state,
                forceExpanded: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsNothing);
      expect(find.text("Sahih International"), findsOneWidget);
      expect(find.text("Clear Quran"), findsOneWidget);
    });

    testWidgets(
        "WordByWordResourcesTab renders GridView with 2 columns on wide screen",
        (tester) async {
      tester.view.physicalSize = const Size(1000, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final cubit = FakeQuranResourcesCubit(
        const QuranResourcesState(
          status: QuranResourcesStatus.success,
          wordByWordResources: [testResource1, testResource2],
        ),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          cubit: cubit,
          child: const Scaffold(
            body: WordByWordResourcesTab(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final gridFinder = find.byType(GridView);
      expect(gridFinder, findsOneWidget);

      final GridView grid = tester.widget(gridFinder);
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, equals(2));
    });

    testWidgets("ResourceFilterChips filters items properly",
        (tester) async {
      tester.view.physicalSize = const Size(1000, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final cubit = FakeQuranResourcesCubit(
        const QuranResourcesState(
          status: QuranResourcesStatus.success,
          translationGroups: [testGroup],
        ),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          cubit: cubit,
          child: const Scaffold(
            body: TranslationResourcesTab(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Initial state: shows All (2), Downloaded (1), Active (1)
      expect(find.text("All (2)"), findsOneWidget);
      expect(find.text("Downloaded (1)"), findsOneWidget);
      expect(find.text("Active (1)"), findsOneWidget);

      // Tap on Downloaded filter chip
      await tester.tap(find.text("Downloaded (1)"));
      await tester.pumpAndSettle();

      // Only 1 downloaded resource should be shown (Sahih International), Clear Quran not shown
      expect(find.text("Sahih International"), findsOneWidget);
      expect(find.text("Clear Quran"), findsNothing);
    });

    testWidgets(
        "QuranResourcesScreen shows embedded search field on wide screen (>=768px)",
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      if (getIt.isRegistered<QuranResourcesCubit>()) {
        getIt.unregister<QuranResourcesCubit>();
      }
      getIt.registerFactory<QuranResourcesCubit>(() => FakeQuranResourcesCubit());

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale("en"),
            home: QuranResourcesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Embedded TextField in AppBar actions should be visible
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text("Quran Resources"), findsOneWidget);
    });
  });
}
