import "package:al_quran_v3/src/features/mushaf/domain/repositories/i_mushaf_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class CheckMushafDownloadedUseCase {
  final IMushafRepository repository;

  CheckMushafDownloadedUseCase(this.repository);

  Future<bool> call() => repository.isMushafDownloaded();
}

@lazySingleton
class DownloadMushafUseCase {
  final IMushafRepository repository;

  DownloadMushafUseCase(this.repository);

  Future<void> call({
    required Function(double progress, String status) onProgress,
  }) => repository.downloadAndExtractMushaf(onProgress: onProgress);
}

@lazySingleton
class DeleteMushafUseCase {
  final IMushafRepository repository;

  DeleteMushafUseCase(this.repository);

  Future<void> call() => repository.deleteMushafData();
}

@lazySingleton
class GetMushafLastPageUseCase {
  final IMushafRepository repository;

  GetMushafLastPageUseCase(this.repository);

  Future<int> call() => repository.getLastReadPage();
}

@lazySingleton
class SaveMushafLastPageUseCase {
  final IMushafRepository repository;

  SaveMushafLastPageUseCase(this.repository);

  Future<void> call(int page) => repository.saveLastReadPage(page);
}

@lazySingleton
class GetMushafBasePathUseCase {
  final IMushafRepository repository;

  GetMushafBasePathUseCase(this.repository);

  Future<String> call() => repository.getMushafBasePath();
}
