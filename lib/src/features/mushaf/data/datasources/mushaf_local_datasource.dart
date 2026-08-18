import "dart:io";
import "package:injectable/injectable.dart";
import "package:path_provider/path_provider.dart";
import "package:shared_preferences/shared_preferences.dart";

@lazySingleton
class MushafLocalDataSource {
  static const String _lastPageKey = "kfgqpc_mushaf_last_page";
  static const String _folderName = "mushaf_demo_data";

  Future<String> getMushafBasePath() async {
    final rootDir = await getApplicationDocumentsDirectory();
    return "${rootDir.path}/$_folderName";
  }

  Future<bool> isMushafDownloaded() async {
    final basePath = await getMushafBasePath();
    final directory = Directory(basePath);
    if (await directory.exists()) {
      final indexFile = File("$basePath/index.html");
      return await indexFile.exists();
    }
    return false;
  }

  Future<void> deleteMushafData() async {
    final basePath = await getMushafBasePath();
    final directory = Directory(basePath);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }

  Future<int> getLastReadPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastPageKey) ?? 1;
  }

  Future<void> saveLastReadPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastPageKey, page);
  }
}
