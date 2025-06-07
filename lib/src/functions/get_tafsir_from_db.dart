import "dart:convert";
import "package:hive/hive.dart";

Future<String?> getTafsirFromDb(
  String ayahKey, {
  bool returnAyahKeyIfLinked = true,
}) async {
  LazyBox? box;
  try {
    box = await Hive.openLazyBox("quran_tafsir");
    String currentAyahKey = ayahKey;

    for (int i = 0; i < 5; i++) {
      final rawData = await box.get(currentAyahKey, defaultValue: null);

      if (rawData == null) {
        return null;
      }

      if (rawData is! String) {
        return null;
      }

      try {
        final Map<String, dynamic> data = jsonDecode(rawData);
        final String? text = data["text"] as String?;

        if (text == null) {
          return "Not Found";
        }

        final parts = text.split(":");
        if (parts.length == 2 &&
            int.tryParse(parts[0]) != null &&
            int.tryParse(parts[1]) != null) {
          if (returnAyahKeyIfLinked) {
            return text;
          }
          currentAyahKey = text;
        } else {
          return text;
        }
      } catch (e) {
        return rawData;
      }
    }
    return null;
  } finally {
    await box?.close();
  }
}
