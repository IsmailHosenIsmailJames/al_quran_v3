import "dart:developer";
import "dart:io";
import "dart:math" as math;

import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

Future<int> justAudioCache() async {
  final path = await getApplicationCacheDirectory();
  String cachePath = join(path.path, "just_audio_cache", "remote");
  int size = await getCacheSize(Directory(cachePath));
  return size;
}

Future<int> getCacheSize(Directory cacheDir) async {
  int totalSize = 0;

  if (cacheDir.existsSync()) {
    int i = 0;
    cacheDir.listSync().forEach((file) {
      log(i.toString());
      i++;
      if (file is File) {
        totalSize += file.lengthSync();
      }
    });
    log("all $i");
  }

  return totalSize;
}

Future<int?> justSingleAudioCache(String name) async {
  final path = await getApplicationCacheDirectory();
  String cachePath = join(path.path, "just_audio_cache", "remote", "$name.mp3");
  File f = File(cachePath);
  if (await f.exists()) {
    return await f.length();
  } else {
    return null;
  }
}

String formatBytes(int bytes, [int decimals = 2]) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB"];
  int i = (math.log(bytes) / math.log(1024)).floor();
  double size = bytes / math.pow(1024, i);
  return "${size.toStringAsFixed(decimals)} ${suffixes[i]}";
}
