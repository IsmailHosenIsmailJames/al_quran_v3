String? getStringFromTafsirFromDb(
  Map? data, {
  bool returnAyahKeyIfLinked = true,
}) {
  if (data == null) return null;
  for (int i = 0; i < 5; i++) {
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
      } else {
        return text;
      }
    } catch (e) {
      return null;
    }
  }
  return null;
}
