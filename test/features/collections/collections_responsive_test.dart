import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/functions/theme_functions.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/repositories/collections_repository.dart";
import "package:al_quran_v3/src/features/collections/presentation/screens/collection_content_view.dart";
import "package:al_quran_v3/src/features/collections/presentation/screens/collection_page.dart";
import "package:al_quran_v3/src/features/collections/presentation/widgets/list_of_ayahs_views.dart";
import "package:al_quran_v3/src/features/collections/presentation/widgets/popups/add_note_popup.dart";
import "package:al_quran_v3/src/features/collections/presentation/widgets/popups/add_to_pinned_popup.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

class FakeCollectionsRepository implements CollectionsRepository {
  List<NoteCollectionModel> noteCollections = [];
  List<PinnedCollectionModel> pinnedCollections = [];

  @override
  Future<List<NoteCollectionModel>> fetchNoteCollections() async =>
      noteCollections;

  @override
  Future<List<PinnedCollectionModel>> fetchPinnedCollections() async =>
      pinnedCollections;

  @override
  Future<NoteCollectionModel?> handleAddNewNoteCollection(
    String noteText,
    AppLocalizations l10n,
  ) async => null;

  @override
  Future<PinnedCollectionModel?> handleAddNewCollection(
    String text,
    AppLocalizations l10n,
  ) async => null;

  @override
  Future<void> deleteNoteCollectionByID(String id) async {
    noteCollections.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> deletePinnedCollectionByID(String id) async {
    pinnedCollections.removeWhere((c) => c.id == id);
  }

  @override
  Future<void> saveNoteCollectionModelAsMap(
    NoteCollectionModel noteCollection,
  ) async {}

  @override
  Future<void> savePinnedCollectionModelAsMap(
    PinnedCollectionModel pinnedCollection,
  ) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeCollectionsRepository fakeRepo;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await ThemeFunctions.initThemeFunction();
    Hive.init("./test_hive_collections_responsive");
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
  });

  tearDownAll(() async {
    await Hive.close();
  });

  setUp(() {
    fakeRepo = FakeCollectionsRepository();
    if (getIt.isRegistered<CollectionsRepository>()) {
      getIt.unregister<CollectionsRepository>();
    }
    getIt.registerSingleton<CollectionsRepository>(fakeRepo);
  });

  tearDown(() {
    if (getIt.isRegistered<CollectionsRepository>()) {
      getIt.unregister<CollectionsRepository>();
    }
  });

  Widget createTestWidget({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit(null)),
        BlocProvider(create: (context) => QuranViewCubit()),
        BlocProvider(create: (context) => AyahToHighlight()),
        BlocProvider(create: (context) => AyahKeyCubit()),
        BlocProvider(create: (context) => AudioUiCubit()),
        BlocProvider(create: (context) => PlayerPositionCubit()),
        BlocProvider(create: (context) => PlayerStateCubit()),
        BlocProvider(create: (context) => SegmentedQuranReciterCubit()),
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

  final sampleNoteCollections = [
    NoteCollectionModel(
      id: "note_1",
      name: "Tafsir Reflection",
      colorHex: "FF4CAF50",
      notes: [
        NoteModel(
          id: "n1",
          ayahKey: ["1:1"],
          text: "Reflection on Bismillah",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    NoteCollectionModel(
      id: "note_2",
      name: "Dua List",
      colorHex: "FF2196F3",
      notes: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    NoteCollectionModel(
      id: "note_3",
      name: "Grammar Notes",
      colorHex: "FFFF9800",
      notes: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  group("CollectionPage Responsive UI Tests", () {
    testWidgets(
      "Mobile screen (<640px) renders 1-column ListView and bounded header",
      (tester) async {
        fakeRepo.noteCollections = sampleNoteCollections;
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: const CollectionPage(collectionType: CollectionType.notes),
          ),
        );
        await tester.pumpAndSettle();

        // Check segmented switch is bounded to 480px max width
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(
          find.byType(ConstrainedBox),
        );
        final hasHeaderConstraint = constrainedBoxes.any(
          (box) => box.constraints.maxWidth == 480,
        );
        expect(hasHeaderConstraint, isTrue);

        // Check search bar is bounded to 800px max width
        final hasSearchBarConstraint = constrainedBoxes.any(
          (box) => box.constraints.maxWidth == 800,
        );
        expect(hasSearchBarConstraint, isTrue);

        // On mobile, items should be rendered using ListView (not GridView)
        expect(find.byType(ListView), findsWidgets);
        expect(find.byType(GridView), findsNothing);
      },
    );

    testWidgets(
      "Tablet screen (768px) renders 2-column GridView and bounded controls",
      (tester) async {
        fakeRepo.noteCollections = sampleNoteCollections;
        tester.view.physicalSize = const Size(768, 1024);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: const CollectionPage(collectionType: CollectionType.notes),
          ),
        );
        await tester.pumpAndSettle();

        // On tablet, items should be rendered using GridView
        final gridFinder = find.byType(GridView);
        expect(gridFinder, findsOneWidget);

        final grid = tester.widget<GridView>(gridFinder);
        final delegate =
            grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.crossAxisCount, equals(2));
      },
    );

    testWidgets(
      "Desktop screen (1280px) renders 3-column GridView bounded to 1200px",
      (tester) async {
        fakeRepo.noteCollections = sampleNoteCollections;
        tester.view.physicalSize = const Size(1280, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: const CollectionPage(collectionType: CollectionType.notes),
          ),
        );
        await tester.pumpAndSettle();

        // On desktop >= 1024px, 3-column GridView
        final gridFinder = find.byType(GridView);
        expect(gridFinder, findsOneWidget);

        final grid = tester.widget<GridView>(gridFinder);
        final delegate =
            grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.crossAxisCount, equals(3));

        // Grid content is bounded by ConstrainedBox(maxWidth: 1200)
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(
          find.byType(ConstrainedBox),
        );
        final hasGridConstraint = constrainedBoxes.any(
          (box) => box.constraints.maxWidth == 1200,
        );
        expect(hasGridConstraint, isTrue);
      },
    );
  });

  group("CollectionContentView Responsive UI Tests", () {
    testWidgets(
      "Desktop screen constrains notes list reading width to maxWidth 960px",
      (tester) async {
        tester.view.physicalSize = const Size(1400, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final noteCollection = sampleNoteCollections.first;
        await tester.pumpWidget(
          createTestWidget(
            child: CollectionContentView(noteCollectionModel: noteCollection),
          ),
        );
        await tester.pumpAndSettle();

        // Verify ListView is bounded to 960px
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(
          find.byType(ConstrainedBox),
        );
        final hasContentConstraint = constrainedBoxes.any(
          (box) => box.constraints.maxWidth == 960,
        );
        expect(hasContentConstraint, isTrue);
      },
    );
  });

  group("ListOfAyahsViews Responsive UI Tests", () {
    testWidgets(
      "Desktop screen constrains ayahs list reading width to maxWidth 960px",
      (tester) async {
        tester.view.physicalSize = const Size(1400, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: const ListOfAyahsViews(ayahsKey: ["1:1", "1:2"]),
          ),
        );
        await tester.pump(const Duration(seconds: 1));

        // Verify reading column is bounded to 960px
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(
          find.byType(ConstrainedBox),
        );
        final hasConstraint = constrainedBoxes.any(
          (box) => box.constraints.maxWidth == 960,
        );
        expect(hasConstraint, isTrue);
      },
    );
  });

  group("Popups Responsive UI Tests", () {
    testWidgets(
      "showAddNotePopup uses maxWidth 560px on wide screen",
      (tester) async {
        tester.view.physicalSize = const Size(1000, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => showAddNotePopup(context, "1:1"),
                  child: const Text("Open Add Note"),
                );
              },
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text("Open Add Note"));
        await tester.pumpAndSettle();

        // Bottom sheet modal should be bounded to maxWidth 560
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(
          find.byType(ConstrainedBox),
        );
        final hasPopupConstraint = constrainedBoxes.any(
          (box) => box.constraints.maxWidth == 560,
        );
        expect(hasPopupConstraint, isTrue);
      },
    );

    testWidgets(
      "showAddToPinnedPopup uses maxWidth 560px on wide screen",
      (tester) async {
        tester.view.physicalSize = const Size(1000, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          createTestWidget(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => showAddToPinnedPopup(context, "1:1"),
                  child: const Text("Open Add Pinned"),
                );
              },
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text("Open Add Pinned"));
        await tester.pumpAndSettle();

        // Bottom sheet modal should be bounded to maxWidth 560
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(
          find.byType(ConstrainedBox),
        );
        final hasPopupConstraint = constrainedBoxes.any(
          (box) => box.constraints.maxWidth == 560,
        );
        expect(hasPopupConstraint, isTrue);
      },
    );
  });
}
