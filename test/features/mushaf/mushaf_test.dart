import "package:al_quran_v3/src/features/mushaf/domain/repositories/i_mushaf_repository.dart";
import "package:al_quran_v3/src/features/mushaf/domain/usecases/mushaf_usecases.dart";
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
}
