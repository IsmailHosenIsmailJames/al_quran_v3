import "package:al_quran_v3/src/features/mushaf/domain/repositories/i_mushaf_repository.dart";
import "package:al_quran_v3/src/features/mushaf/domain/usecases/mushaf_usecases.dart";
import "package:al_quran_v3/src/features/mushaf/domain/utils/mushaf_page_helper.dart";
import "package:flutter_test/flutter_test.dart";

class FakeMushafRepository implements IMushafRepository {
  bool downloaded = false;
  int lastPage = 1;

  @override
  Future<bool> isMushafDownloaded() async => downloaded;

  @override
  Future<void> downloadAndExtractMushaf({
    required Function(double progress, String status) onProgress,
  }) async {
    onProgress(0.5, "Downloading");
    onProgress(1.0, "Done");
    downloaded = true;
  }

  @override
  Future<void> deleteMushafData() async {
    downloaded = false;
    lastPage = 1;
  }

  @override
  Future<int> getLastReadPage() async => lastPage;

  @override
  Future<void> saveLastReadPage(int page) async {
    lastPage = page;
  }

  @override
  Future<String> getMushafBasePath() async => "/fake/path/mushaf";
}

void main() {
  group("Mushaf Clean Architecture Tests", () {
    late FakeMushafRepository fakeRepo;
    late CheckMushafDownloadedUseCase checkDownloadedUseCase;
    late DownloadMushafUseCase downloadUseCase;
    late DeleteMushafUseCase deleteUseCase;
    late GetMushafLastPageUseCase getLastPageUseCase;
    late SaveMushafLastPageUseCase saveLastPageUseCase;

    setUp(() {
      fakeRepo = FakeMushafRepository();
      checkDownloadedUseCase = CheckMushafDownloadedUseCase(fakeRepo);
      downloadUseCase = DownloadMushafUseCase(fakeRepo);
      deleteUseCase = DeleteMushafUseCase(fakeRepo);
      getLastPageUseCase = GetMushafLastPageUseCase(fakeRepo);
      saveLastPageUseCase = SaveMushafLastPageUseCase(fakeRepo);
    });

    test("Initial state is not downloaded", () async {
      expect(await checkDownloadedUseCase(), isFalse);
      expect(await getLastPageUseCase(), equals(1));
    });

    test("Download and save page lifecycle", () async {
      final List<double> progressUpdates = [];
      await downloadUseCase(
        onProgress: (progress, status) {
          progressUpdates.add(progress);
        },
      );

      expect(await checkDownloadedUseCase(), isTrue);
      expect(progressUpdates, contains(1.0));

      await saveLastPageUseCase(150);
      expect(await getLastPageUseCase(), equals(150));

      await deleteUseCase();
      expect(await checkDownloadedUseCase(), isFalse);
    });
  });

  group("MushafPageHelper Tests", () {
    test("Juz calculation for standard boundary pages", () {
      expect(MushafPageHelper.getJuzForPage(1), equals(1));
      expect(MushafPageHelper.getJuzForPage(21), equals(1));
      expect(MushafPageHelper.getJuzForPage(22), equals(2));
      expect(MushafPageHelper.getJuzForPage(293), equals(15));
      expect(MushafPageHelper.getJuzForPage(582), equals(30));
      expect(MushafPageHelper.getJuzForPage(604), equals(30));
    });

    test("Page details lookup returns accurate metadata", () {
      final page1 = MushafPageHelper.getPageDetails(1);
      expect(page1.surahNumber, equals(1));
      expect(page1.surahEnglishName, equals("Al-Fatihah"));
      expect(page1.surahArabicName, equals("الفاتحة"));
      expect(page1.juzNumber, equals(1));

      final page2 = MushafPageHelper.getPageDetails(2);
      expect(page2.surahNumber, equals(2));
      expect(page2.surahEnglishName, equals("Al-Baqarah"));
      expect(page2.juzNumber, equals(1));

      final page604 = MushafPageHelper.getPageDetails(604);
      expect(page604.juzNumber, equals(30));
    });

    test("Lists of all Surahs and Juzs are complete", () {
      final surahs = MushafPageHelper.getAllSurahs();
      expect(surahs.length, equals(114));
      expect(surahs.first.englishName, equals("Al-Fatihah"));
      expect(surahs.first.startPage, equals(1));
      expect(surahs.last.englishName, equals("An-Nas"));

      final juzs = MushafPageHelper.getAllJuzs();
      expect(juzs.length, equals(30));
      expect(juzs.first.juzNumber, equals(1));
      expect(juzs.first.startPage, equals(1));
      expect(juzs.last.juzNumber, equals(30));
      expect(juzs.last.startPage, equals(582));
    });

    test("Clamps out-of-bounds pages safely", () {
      final underflow = MushafPageHelper.getPageDetails(0);
      expect(underflow.pageNumber, equals(1));

      final overflow = MushafPageHelper.getPageDetails(999);
      expect(overflow.pageNumber, equals(604));
    });
  });
}
