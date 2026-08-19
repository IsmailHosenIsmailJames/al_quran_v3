import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_juz.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/quran_pages_info.dart";

/// Data model representing Surah navigation info in the Mushaf.
class MushafSurahItem {
  final int surahNumber;
  final String arabicName;
  final String englishName;
  final String revelationType;
  final int versesCount;
  final int startPage;
  final int endPage;

  const MushafSurahItem({
    required this.surahNumber,
    required this.arabicName,
    required this.englishName,
    required this.revelationType,
    required this.versesCount,
    required this.startPage,
    required this.endPage,
  });
}

/// Data model representing Juz navigation info in the Mushaf.
class MushafJuzItem {
  final int juzNumber;
  final int startPage;
  final String firstVerseKey;
  final String lastVerseKey;
  final int versesCount;
  final String startSurahName;

  const MushafJuzItem({
    required this.juzNumber,
    required this.startPage,
    required this.firstVerseKey,
    required this.lastVerseKey,
    required this.versesCount,
    required this.startSurahName,
  });
}

/// Information about a specific Mushaf page.
class MushafPageDetails {
  final int pageNumber;
  final int surahNumber;
  final String surahArabicName;
  final String surahEnglishName;
  final int juzNumber;
  final int startAyah;
  final int endAyah;

  const MushafPageDetails({
    required this.pageNumber,
    required this.surahNumber,
    required this.surahArabicName,
    required this.surahEnglishName,
    required this.juzNumber,
    required this.startAyah,
    required this.endAyah,
  });
}

/// Utility helper for resolving Surah, Juz, and page metadata for KFGQPC 604-page Mushaf.
class MushafPageHelper {
  MushafPageHelper._();

  static const int totalPages = 604;

  /// Standard Madani 604-page Mushaf starting page for each Juz (1..30).
  static const List<int> juzStartPages = [
    1, 22, 42, 62, 82, 102, 122, 142, 162, 182,
    202, 222, 242, 262, 282, 302, 322, 342, 362, 382,
    402, 422, 442, 462, 482, 502, 522, 542, 562, 582,
  ];

  /// Get Juz number (1 to 30) for a given page number (1 to 604).
  static int getJuzForPage(int page) {
    if (page < 1) return 1;
    if (page > totalPages) return 30;

    for (int i = juzStartPages.length - 1; i >= 0; i--) {
      if (page >= juzStartPages[i]) {
        return i + 1;
      }
    }
    return 1;
  }

  /// Get detailed info for a specific Mushaf page (1 to 604).
  static MushafPageDetails getPageDetails(int page) {
    final safePage = page.clamp(1, totalPages);
    final pageIndex = safePage - 1;

    int surahNumber = 1;
    int startAyah = 1;
    int endAyah = 7;

    if (pageIndex < quranPagesInfo.length) {
      final info = quranPagesInfo[pageIndex];
      surahNumber = info["sn"] ?? 1;
      startAyah = info["s"] ?? 1;
      endAyah = info["e"] ?? 7;
    }

    final surahIndex = (surahNumber - 1).clamp(0, 113);
    final surahArabic = surahIndex < canonicalSurahArabicNames.length
        ? canonicalSurahArabicNames[surahIndex]
        : "سورة $surahNumber";
    final surahEnglish = surahIndex < canonicalSurahTransliterations.length
        ? canonicalSurahTransliterations[surahIndex]
        : "Surah $surahNumber";

    final juzNumber = getJuzForPage(safePage);

    return MushafPageDetails(
      pageNumber: safePage,
      surahNumber: surahNumber,
      surahArabicName: surahArabic,
      surahEnglishName: surahEnglish,
      juzNumber: juzNumber,
      startAyah: startAyah,
      endAyah: endAyah,
    );
  }

  /// Retrieve full list of all 114 Surahs with start pages and details.
  static List<MushafSurahItem> getAllSurahs() {
    final List<MushafSurahItem> list = [];

    for (int i = 1; i <= 114; i++) {
      final meta = metaDataSurah[i.toString()];
      final surahIndex = i - 1;

      final arabicName = surahIndex < canonicalSurahArabicNames.length
          ? canonicalSurahArabicNames[surahIndex]
          : "سورة $i";
      final englishName = surahIndex < canonicalSurahTransliterations.length
          ? canonicalSurahTransliterations[surahIndex]
          : "Surah $i";

      int startPage = 1;
      int endPage = 1;

      if (meta != null && meta["pr"] != null) {
        final prParts = (meta["pr"] as String).split("-");
        startPage = int.tryParse(prParts.first) ?? 1;
        endPage = int.tryParse(prParts.last) ?? startPage;
      }

      list.add(
        MushafSurahItem(
          surahNumber: i,
          arabicName: arabicName,
          englishName: englishName,
          revelationType: meta?["rp"] ?? "makkah",
          versesCount: meta?["vc"] ?? 0,
          startPage: startPage,
          endPage: endPage,
        ),
      );
    }

    return list;
  }

  /// Retrieve full list of all 30 Juzs with start pages and details.
  static List<MushafJuzItem> getAllJuzs() {
    final List<MushafJuzItem> list = [];

    for (int i = 1; i <= 30; i++) {
      final meta = metaDataJuz[i.toString()];
      final startPage = juzStartPages[i - 1];

      final fvk = meta?["fvk"] as String? ?? "$i:1";
      final lvk = meta?["lvk"] as String? ?? "$i:1";
      final vc = meta?["vc"] as int? ?? 0;

      final startSurahNum = int.tryParse(fvk.split(":").first) ?? 1;
      final startSurahIndex = (startSurahNum - 1).clamp(0, 113);
      final startSurahName = startSurahIndex < canonicalSurahTransliterations.length
          ? canonicalSurahTransliterations[startSurahIndex]
          : "Surah $startSurahNum";

      list.add(
        MushafJuzItem(
          juzNumber: i,
          startPage: startPage,
          firstVerseKey: fvk,
          lastVerseKey: lvk,
          versesCount: vc,
          startSurahName: startSurahName,
        ),
      );
    }

    return list;
  }
}
