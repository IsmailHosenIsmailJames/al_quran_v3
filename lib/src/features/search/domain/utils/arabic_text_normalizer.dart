/// High-performance Arabic text normalization utility for Quranic search.
///
/// Strips diacritics (Harakat/Tashkeel), Quranic pause marks, and normalizes
/// letter variations (Alef, Yaa, Taa Marbuta) so users can search in Arabic
/// without worrying about exact vowel marks.
class ArabicTextNormalizer {
  ArabicTextNormalizer._();

  // Unicode ranges for Arabic diacritics (Tashkeel)
  // \u064B - \u0652: Fathatan, Dammatan, Kasratan, Fatha, Damma, Kasra, Shadda, Sukun
  // \u0653 - \u0655: Maddah, Hamza Above, Hamza Below
  // \u0656 - \u065F: Subscript Alef, Inverted Damma, Noon Ghunna, etc.
  // \u0670: Superscript Alef (Dagger Alef)
  // \u06D6 - \u06ED: Quranic pause marks and small signs
  static final RegExp _tashkeelRegex = RegExp(
    r"[\u064B-\u065F\u0670\u06D6-\u06ED\u0610-\u061A\u08D4-\u08E1\u08E3-\u08FF]",
  );

  // Tatweel / Kashida (\u0640)
  static final RegExp _tatweelRegex = RegExp(r"\u0640");

  // Alef variations: أ (0623), إ (0625), آ (0622), ٱ (0671) -> ا (0627)
  static final RegExp _alefRegex = RegExp(r"[\u0622\u0623\u0625\u0671]");

  // Yaa / Alef Maksura variations: ى (0649), ئ (0626), ے (06D2) -> ي (064A)
  static final RegExp _yaaRegex = RegExp(r"[\u0649\u0626\u06D2]");

  // Taa Marbuta: ة (0629) -> ه (0647)
  static final RegExp _taaMarbutaRegex = RegExp(r"\u0629");

  // Non-letter symbols / Quranic glyphs
  static final RegExp _extraSymbolsRegex = RegExp(r"[\uFD3E\uFD3F\u060C\u061B\u061F]");

  /// Normalizes Arabic text by stripping Tashkeel, Tatweel, pause marks, and unifying letter forms.
  static String normalize(String text) {
    if (text.isEmpty) return "";

    return text
        .replaceAll(_tashkeelRegex, "")
        .replaceAll(_tatweelRegex, "")
        .replaceAll(_alefRegex, "\u0627") // Replace with standard Alef 'ا'
        .replaceAll(_yaaRegex, "\u064A")  // Replace with standard Yaa 'ي'
        .replaceAll(_taaMarbutaRegex, "\u0647") // Replace with standard Haa 'ه'
        .replaceAll(_extraSymbolsRegex, "")
        .trim();
  }

  /// Strips Tashkeel while preserving original letter forms.
  static String stripTashkeelOnly(String text) {
    if (text.isEmpty) return "";
    return text
        .replaceAll(_tashkeelRegex, "")
        .replaceAll(_tatweelRegex, "")
        .replaceAll(_extraSymbolsRegex, "")
        .trim();
  }

  /// Checks if a string contains Arabic characters.
  static bool containsArabic(String text) {
    return RegExp(r"[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]").hasMatch(text);
  }
}
