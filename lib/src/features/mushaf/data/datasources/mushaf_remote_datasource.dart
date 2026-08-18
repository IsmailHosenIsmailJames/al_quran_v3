import "dart:io";
import "package:archive/archive.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:path_provider/path_provider.dart";

@lazySingleton
class MushafRemoteDataSource {
  static const String _downloadUrl =
      "https://github.com/IsmailHosenIsmailJames/al_quran_mushaf/releases/download/v1.0.0/KFGQPC_V4_layout.zip";

  Future<void> downloadAndExtractMushaf({
    required Function(double progress, String status) onProgress,
  }) async {
    final rootDir = await getApplicationDocumentsDirectory();
    final baseDirPath = "${rootDir.path}/mushaf_demo_data";
    final zipFilePath = "${rootDir.path}/KFGQPC_V4_layout.zip";

    final dio = Dio();
    await Directory(baseDirPath).create(recursive: true);

    onProgress(0.0, "Downloading Mushaf Data...");

    await dio.download(
      _downloadUrl,
      zipFilePath,
      onReceiveProgress: (count, total) {
        if (total != -1) {
          onProgress(count / total * 0.5, "Downloading Mushaf Data...");
        }
      },
    );

    onProgress(0.5, "Extracting Data...");

    final zipFile = File(zipFilePath);
    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    int extractCount = 0;
    for (final file in archive) {
      String filename = file.name;
      if (filename.startsWith("KFGQPC_V4_layout/")) {
        filename = filename.replaceFirst("KFGQPC_V4_layout/", "");
      }
      if (filename.trim().isEmpty) continue;

      if (file.isFile) {
        final data = file.content as List<int>;
        final extractedFile = File("$baseDirPath/$filename");
        await extractedFile.create(recursive: true);
        await extractedFile.writeAsBytes(data);
      } else {
        await Directory("$baseDirPath/$filename").create(recursive: true);
      }

      extractCount++;
      if (extractCount % 10 == 0) {
        onProgress(
          0.5 + ((extractCount / archive.length) * 0.5),
          "Extracting Data...",
        );
      }
    }

    if (await zipFile.exists()) {
      await zipFile.delete();
    }

    onProgress(1.0, "Done");
  }
}
