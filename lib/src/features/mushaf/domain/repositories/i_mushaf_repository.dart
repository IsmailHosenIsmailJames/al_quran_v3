abstract class IMushafRepository {
  Future<bool> isMushafDownloaded();
  Future<void> downloadAndExtractMushaf({
    required Function(double progress, String status) onProgress,
  });
  Future<void> deleteMushafData();
  Future<int> getLastReadPage();
  Future<void> saveLastReadPage(int page);
  Future<String> getMushafBasePath();
}
