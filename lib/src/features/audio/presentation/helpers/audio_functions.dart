import "dart:io";
import "dart:math" as math;

import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

/// Resolves the `just_audio_cache/remote` directory inside [getTemporaryDirectory],
/// matching `just_audio`'s `LockCachingAudioSource` implementation.
Future<Directory> getJustAudioCacheDirectory() async {
  final tempDir = await getTemporaryDirectory();
  return Directory(join(tempDir.path, "just_audio_cache", "remote"));
}

Future<int> justAudioCache() async {
  final cacheDir = await getJustAudioCacheDirectory();
  return getCacheSize(cacheDir);
}

Future<int> getCacheSize(Directory cacheDir) async {
  int totalSize = 0;

  if (await cacheDir.exists()) {
    await for (final entity in cacheDir.list(followLinks: false)) {
      if (entity is File) {
        try {
          totalSize += await entity.length();
        } catch (_) {}
      }
    }
  }

  return totalSize;
}

Future<int?> justSingleAudioCache(String name) async {
  final cacheDir = await getJustAudioCacheDirectory();
  final f = File(join(cacheDir.path, "$name.mp3"));
  if (await f.exists()) {
    return await f.length();
  }
  return null;
}

String formatBytes(int bytes, [int decimals = 2]) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB"];
  int i = (math.log(bytes) / math.log(1024)).floor();
  if (i >= suffixes.length) i = suffixes.length - 1;
  double size = bytes / math.pow(1024, i);
  return "${size.toStringAsFixed(decimals)} ${suffixes[i]}";
}
