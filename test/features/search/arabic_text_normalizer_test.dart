import "package:al_quran_v3/src/features/search/domain/utils/arabic_text_normalizer.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ArabicTextNormalizer Unit Tests", () {
    test("strips Harakat / Tashkeel from Arabic words", () {
      const input = "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ";
      final normalized = ArabicTextNormalizer.normalize(input);

      // Should strip Fathah, Kasrah, Shaddah, Dagger Alef, and normalize Wasla Alef
      expect(normalized, "بسم الله الرحمن الرحيم");
    });

    test("normalizes Alef variants (أ, إ, آ, ٱ) to standard Alef (ا)", () {
      expect(ArabicTextNormalizer.normalize("أحمد"), "احمد");
      expect(ArabicTextNormalizer.normalize("إيمان"), "ايمان");
      expect(ArabicTextNormalizer.normalize("آدم"), "ادم");
      expect(ArabicTextNormalizer.normalize("ٱلحمد"), "الحمد");
    });

    test("normalizes Yaa / Alef Maksura variants (ى, ئ, ے) to standard Yaa (ي)", () {
      expect(ArabicTextNormalizer.normalize("موسى"), "موسي");
      expect(ArabicTextNormalizer.normalize("شاطئ"), "شاطي");
    });

    test("normalizes Taa Marbuta (ة) to Haa (ه)", () {
      expect(ArabicTextNormalizer.normalize("رحمة"), " رحمه".trim());
      expect(ArabicTextNormalizer.normalize("جنة"), " جنه".trim());
    });

    test("correctly detects Arabic characters", () {
      expect(ArabicTextNormalizer.containsArabic("بِسْمِ اللَّهِ"), isTrue);
      expect(ArabicTextNormalizer.containsArabic("Al-Baqarah"), isFalse);
      expect(ArabicTextNormalizer.containsArabic("বাংলা"), isFalse);
    });
  });
}
