import "package:al_quran_v3/src/features/mushaf/data/datasources/mushaf_local_datasource.dart";
import "package:al_quran_v3/src/features/mushaf/data/datasources/mushaf_remote_datasource.dart";
import "package:al_quran_v3/src/features/mushaf/domain/repositories/i_mushaf_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: IMushafRepository)
class MushafRepositoryImpl implements IMushafRepository {
  final MushafLocalDataSource localDataSource;
  final MushafRemoteDataSource remoteDataSource;

  MushafRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<bool> isMushafDownloaded() => localDataSource.isMushafDownloaded();

  @override
  Future<void> downloadAndExtractMushaf({
    required Function(double progress, String status) onProgress,
  }) => remoteDataSource.downloadAndExtractMushaf(onProgress: onProgress);

  @override
  Future<void> deleteMushafData() => localDataSource.deleteMushafData();

  @override
  Future<int> getLastReadPage() => localDataSource.getLastReadPage();

  @override
  Future<void> saveLastReadPage(int page) =>
      localDataSource.saveLastReadPage(page);

  @override
  Future<String> getMushafBasePath() => localDataSource.getMushafBasePath();
}
