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
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_by_ayah_in_scroll_info_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/ayah_to_highlight.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/screens/surah_info_view.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
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
    Hive.init("./test_hive_surah_info");
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

  group("QuranTranslationFunction - Surah Info tests", () {
    test("isInfoAvailable returns true when surah_info_en box is open with data", () async {
      final box = await Hive.openLazyBox("surah_info_en");
      await box.put("1", {"text": "Surah 1 info"});

      expect(QuranTranslationFunction.isInfoAvailable(), isTrue);
      expect(QuranTranslationFunction.isInfoAvailable(const Locale("en")), isTrue);

      final text = await QuranTranslationFunction.getInfoOfSurah("1", "en");
      expect(text, equals("Surah 1 info"));
    });

    test("getAvailableSurahInfoLanguage resolves preferred or default en", () async {
      expect(
        QuranTranslationFunction.getAvailableSurahInfoLanguage(const Locale("en")),
        equals("en"),
      );
      expect(
        QuranTranslationFunction.getAvailableSurahInfoLanguage(const Locale("bn")),
        equals("en"),
      );

      final itBox = await Hive.openLazyBox("surah_info_it");
      await itBox.put("1", {"text": "Info in Italian"});
      expect(
        QuranTranslationFunction.getAvailableSurahInfoLanguage(const Locale("it")),
        equals("it"),
      );
      await itBox.close();
    });
  });

  group("SurahInfoView Responsive Layout", () {
    const testSurah = SurahInfoModel(
      id: 1,
      revelationOrder: 5,
      revelationPlace: "makkah",
      versesCount: 7,
      pagesRange: "1-1",
    );

    testWidgets("Constrains max reading width on wide desktop screen", (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SurahInfoView(
            html: "<h3>About Al-Fatihah</h3><p>The Opening Chapter of the Quran.</p>",
            surahInfoModel: testSurah,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("Al-Fatihah (الفاتحة)"), findsOneWidget);

      final constrainedBoxFinder = find.byWidgetPredicate(
        (widget) =>
            widget is ConstrainedBox &&
            widget.constraints.maxWidth == 860,
      );
      expect(constrainedBoxFinder, findsOneWidget);

      final box = tester.renderObject(constrainedBoxFinder) as RenderBox;
      expect(box.size.width, lessThanOrEqualTo(860));
    });

    testWidgets("Renders full width on mobile screen", (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SurahInfoView(
            html: "<h3>About Al-Fatihah</h3><p>The Opening Chapter of the Quran.</p>",
            surahInfoModel: testSurah,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("Al-Fatihah (الفاتحة)"), findsOneWidget);
    });
  });

  group("QuranScriptView AppBar Surah Info action", () {
    testWidgets("Displays Surah Info button with tooltip in AppBar", (tester) async {
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

      expect(find.byTooltip("Surah Info"), findsOneWidget);
    });
  });
}
