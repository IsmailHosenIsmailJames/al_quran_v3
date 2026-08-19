import "package:al_quran_v3/src/features/search/data/datasources/quran_search_datasource.dart";
import "package:al_quran_v3/src/features/search/data/models/search_filter_model.dart";
import "package:al_quran_v3/src/features/search/domain/usecases/search_quran_usecase.dart";
import "package:al_quran_v3/src/features/search/presentation/cubit/quran_search_cubit.dart";
import "package:al_quran_v3/src/features/search/presentation/cubit/quran_search_state.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late QuranSearchDataSource dataSource;
  late SearchQuranUseCase useCase;

  setUpAll(() async {
    Hive.init("./test_hive_search");
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox("user");
    }
  });

  setUp(() {
    dataSource = QuranSearchDataSource();
    useCase = SearchQuranUseCase(dataSource);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  group("SearchQuranUseCase Unit Tests", () {
    test("parses verse reference '2:255' as direct Ayah jump", () async {
      final results = await useCase.execute(
        query: "2:255",
        filter: const SearchFilterModel(),
      );

      expect(results.directJump, isNotNull);
      expect(results.directJump?.ayahKey, "2:255");
      expect(results.directJump?.surahNumber, 2);
      expect(results.directJump?.ayahNumber, 255);
    });

    test("parses 'Ayatul Kursi' as direct Ayah jump to 2:255", () async {
      final results = await useCase.execute(
        query: "ayatul kursi",
        filter: const SearchFilterModel(),
      );

      expect(results.directJump, isNotNull);
      expect(results.directJump?.ayahKey, "2:255");
    });

    test("matches Surah name 'Baqarah' properly", () async {
      final results = await useCase.execute(
        query: "Baqarah",
        filter: const SearchFilterModel(scope: SearchScope.surahs),
      );

      expect(results.surahMatches.any((s) => s.id == 2), isTrue);
    });

    test("matches Surah name 'Yasin' properly", () async {
      final results = await useCase.execute(
        query: "Yasin",
        filter: const SearchFilterModel(scope: SearchScope.surahs),
      );

      expect(results.surahMatches.any((s) => s.id == 36), isTrue);
    });
  });

  group("QuranSearchCubit Unit Tests", () {
    test("initial state has correct default values", () {
      final cubit = QuranSearchCubit(dataSource, useCase);
      expect(cubit.state.status, SearchStatus.initial);
      expect(cubit.state.query, "");
      expect(cubit.state.filter.scope, SearchScope.all);
      cubit.close();
    });

    test("onScopeChanged updates active scope and filter", () {
      final cubit = QuranSearchCubit(dataSource, useCase);
      cubit.onScopeChanged(SearchScope.translations);
      expect(cubit.state.filter.scope, SearchScope.translations);
      cubit.close();
    });

    test("searchImmediate executes search and updates state", () async {
      final cubit = QuranSearchCubit(dataSource, useCase);
      cubit.searchImmediate("2:255");

      // Allow async search to complete
      await Future.delayed(const Duration(milliseconds: 100));

      expect(cubit.state.status, SearchStatus.success);
      expect(cubit.state.results?.directJump?.ayahKey, "2:255");
      expect(cubit.state.searchHistory.contains("2:255"), isTrue);
      cubit.close();
    });

    test("onQueryChanged debounces and does not save intermediate keystrokes to history", () async {
      final cubit = QuranSearchCubit(dataSource, useCase);
      await cubit.clearAllHistory();

      cubit.onQueryChanged("F");
      cubit.onQueryChanged("Fa");
      cubit.onQueryChanged("Fatiha");

      // Wait for debounce duration
      await Future.delayed(const Duration(milliseconds: 400));

      expect(cubit.state.status, SearchStatus.success);
      // History should not contain intermediate keystrokes
      expect(cubit.state.searchHistory.contains("F"), isFalse);
      expect(cubit.state.searchHistory.contains("Fa"), isFalse);
      expect(cubit.state.searchHistory.contains("Fatiha"), isFalse);

      // Now explicitly saving query when tapped
      await cubit.saveQueryToHistory("Fatiha");
      expect(cubit.state.searchHistory.contains("Fatiha"), isTrue);

      cubit.close();
    });
  });
}
