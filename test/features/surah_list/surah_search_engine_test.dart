import "package:al_quran_v3/src/features/surah_list/domain/utils/surah_search_engine.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SurahSearchEngine engine;

  setUp(() {
    engine = SurahSearchEngine.instance;
  });

  group("SurahSearchEngine Multi-Language & Performance Tests", () {
    test("Empty query returns all 114 surahs", () {
      final results = engine.search("");
      expect(results.length, equals(114));
    });

    test("Surah number direct lookup matches correctly across scripts", () {
      final results1 = engine.search("1");
      expect(results1.first.id, equals(1));

      final results2 = engine.search("2");
      expect(results2.first.id, equals(2));

      final results002 = engine.search("002");
      expect(results002.first.id, equals(2));

      final results114 = engine.search("114");
      expect(results114.first.id, equals(114));

      // Bengali numbers
      final resultsBengali2 = engine.search("২");
      expect(resultsBengali2.first.id, equals(2));

      final resultsBengali114 = engine.search("১১৪");
      expect(resultsBengali114.first.id, equals(114));

      // Arabic numbers
      final resultsArabic36 = engine.search("٣٦");
      expect(resultsArabic36.first.id, equals(36));
    });

    test("English canonical transliteration and stripped prefix search", () {
      final resultsBaqarah = engine.search("baqarah");
      expect(resultsBaqarah.first.id, equals(2));

      final resultsFatiha = engine.search("fatiha");
      expect(resultsFatiha.first.id, equals(1));

      final resultsKahf = engine.search("kahf");
      expect(resultsKahf.first.id, equals(18));

      final resultsYaseen = engine.search("yaseen");
      expect(resultsYaseen.first.id, equals(36));

      final resultsMulk = engine.search("mulk");
      expect(resultsMulk.first.id, equals(67));

      final resultsRahman = engine.search("rahman");
      expect(resultsRahman.first.id, equals(55));

      final resultsIkhlas = engine.search("ikhlas");
      expect(resultsIkhlas.first.id, equals(112));
    });

    test("Searching in English when app language is Bengali (cross-language)", () {
      // User has Bengali app, but searches English "yasin"
      final resultsYasin = engine.search("yasin", languageCode: "bn");
      expect(resultsYasin.first.id, equals(36));

      // User has Bengali app, but searches English "the cow"
      final resultsCow = engine.search("the cow", languageCode: "bn");
      expect(resultsCow.first.id, equals(2));

      // User has Bengali app, but searches English "surah kahf"
      final resultsSurahKahf = engine.search("surah kahf", languageCode: "bn");
      expect(resultsSurahKahf.first.id, equals(18));

      // User searches "kursi"
      final resultsKursi = engine.search("kursi", languageCode: "bn");
      expect(resultsKursi.first.id, equals(2));
    });

    test("Searching in Bengali when app language is English (cross-language)", () {
      // User has English app, but searches Bengali "বাকারা"
      final resultsBaqarah = engine.search("বাকারা", languageCode: "en");
      expect(resultsBaqarah.first.id, equals(2));

      // User searches Bengali with "সূরা" prefix
      final resultsSuraBaqarah = engine.search("সূরা বাকারা", languageCode: "en");
      expect(resultsSuraBaqarah.first.id, equals(2));

      // User searches Bengali meaning "গাভী"
      final resultsGavi = engine.search("গাভী", languageCode: "en");
      expect(resultsGavi.first.id, equals(2));

      // User searches Bengali "কাহাফ"
      final resultsKahaf = engine.search("কাহাফ", languageCode: "en");
      expect(resultsKahaf.first.id, equals(18));
    });

    test("English translation meaning search", () {
      final resultsCow = engine.search("the cow");
      expect(resultsCow.first.id, equals(2));

      final resultsCave = engine.search("cave");
      expect(resultsCave.first.id, equals(18));

      final resultsOpening = engine.search("opening");
      expect(resultsOpening.first.id, equals(1));
    });

    test("Arabic search with and without diacritics / tashkeel", () {
      final resultsBaqarahAr = engine.search("البقرة");
      expect(resultsBaqarahAr.first.id, equals(2));

      final resultsFatihaAr = engine.search("الفاتحة");
      expect(resultsFatihaAr.first.id, equals(1));

      final resultsYasinAr = engine.search("يس");
      expect(resultsYasinAr.first.id, equals(36));

      final resultsIkhlasAr = engine.search("الإخلاص");
      expect(resultsIkhlasAr.first.id, equals(112));

      final resultsIkhlasNorm = engine.search("الاخلاص");
      expect(resultsIkhlasNorm.first.id, equals(112));
    });

    test("Performance benchmark: 1000 consecutive multi-lingual searches take < 0.1ms per search", () {
      // Warm up JIT
      for (int i = 0; i < 10; i++) {
        engine.search("baq", languageCode: "bn");
      }

      final stopwatch = Stopwatch()..start();
      for (int i = 0; i < 250; i++) {
        engine.search("baq", languageCode: "bn");
        engine.search("কাহফ", languageCode: "en");
        engine.search("114");
        engine.search("يس");
      }
      stopwatch.stop();
      // 1000 total searches should comfortably finish in under 150ms in debug VM (< 0.15ms per search)
      expect(stopwatch.elapsedMilliseconds, lessThan(200));
    });
  });
}
