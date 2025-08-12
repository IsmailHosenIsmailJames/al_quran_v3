import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";

Future<String?> getTafsirFromDb(
  String ayahKey, {
  bool returnAyahKeyIfLinked = true,
}) async {
  String currentAyahKey = ayahKey;

  for (int i = 0; i < 5; i++) {
    Map? data = await QuranTafsirFunction.getTafsir(currentAyahKey);

    if (data == null) {
      return null;
    }

    try {
      final String? text = data["text"] as String?;

      if (text == null) {
        return null;
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
      return null;
    }
  }
  return null;
}
