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
    Hive.init("./test_hive_quran_view");
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

  group("QuranScriptView Scroll & Target Ayah Navigation Tests", () {
    testWidgets("initializes AyahToHighlight and AyahByAyahInScrollInfoCubit with target Ayah when toScrollKey is passed", (
      tester,
    ) async {
      final ayahToHighlight = AyahToHighlight();
      final ayahScrollInfoCubit = AyahByAyahInScrollInfoCubit();

      await tester.pumpWidget(
        buildWrapper(
          ayahToHighlight: ayahToHighlight,
          ayahScrollInfoCubit: ayahScrollInfoCubit,
          child: const QuranScriptView(
            startKey: "2:1",
            endKey: "2:286",
            toScrollKey: "2:9",
          ),
        ),
      );

      // Verify that AyahToHighlight immediately registered 2:9
      expect(ayahToHighlight.state, equals("2:9"));
      // Verify dropdown / scroll state is initialized with 2:9
      expect(ayahScrollInfoCubit.state.dropdownAyahKey, equals("2:9"));
      expect(ayahScrollInfoCubit.state.surahInfoModel?.id, equals(2));
    });

    testWidgets("consecutive navigations to different ayahs (2:8 then 2:9) update target highlight correctly", (
      tester,
    ) async {
      final ayahToHighlight = AyahToHighlight();
      final ayahScrollInfoCubit = AyahByAyahInScrollInfoCubit();

      // First navigation: Click Ayah 8
      await tester.pumpWidget(
        buildWrapper(
          ayahToHighlight: ayahToHighlight,
          ayahScrollInfoCubit: ayahScrollInfoCubit,
          child: const QuranScriptView(
            key: ValueKey("ayah_8"),
            startKey: "2:1",
            endKey: "2:286",
            toScrollKey: "2:8",
          ),
        ),
      );

      expect(ayahToHighlight.state, equals("2:8"));
      expect(ayahScrollInfoCubit.state.dropdownAyahKey, equals("2:8"));

      // Second navigation: User went back and clicked Ayah 9
      await tester.pumpWidget(
        buildWrapper(
          ayahToHighlight: ayahToHighlight,
          ayahScrollInfoCubit: ayahScrollInfoCubit,
          child: const QuranScriptView(
            key: ValueKey("ayah_9"),
            startKey: "2:1",
            endKey: "2:286",
            toScrollKey: "2:9",
          ),
        ),
      );

      expect(ayahToHighlight.state, equals("2:9"));
      expect(ayahScrollInfoCubit.state.dropdownAyahKey, equals("2:9"));
    });
  });
}
