import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";

/// A single matched translation or footnote snippet within an Ayah.
class TranslationMatchItem {
  final ResourcesModel bookInfo;
  final String text;
  final String? footnote;
  final bool matchedInFootnote;

  const TranslationMatchItem({
    required this.bookInfo,
    required this.text,
    this.footnote,
    this.matchedInFootnote = false,
  });
}

/// A single matched Tafsir snippet within an Ayah.
class TafsirMatchItem {
  final ResourcesModel bookInfo;
  final String text;

  const TafsirMatchItem({
    required this.bookInfo,
    required this.text,
  });
}

/// A rich search result representing a single Ayah match.
class AyahSearchResultModel {
  final String ayahKey;
  final int surahNumber;
  final int ayahNumber;
  final int pageNumber;
  final int juzNumber;
  final String arabicText;
  final List<TranslationMatchItem> translationMatches;
  final List<TafsirMatchItem> tafsirMatches;
  final bool matchedInArabic;
  final double score;

  const AyahSearchResultModel({
    required this.ayahKey,
    required this.surahNumber,
    required this.ayahNumber,
    required this.pageNumber,
    required this.juzNumber,
    required this.arabicText,
    this.translationMatches = const [],
    this.tafsirMatches = const [],
    this.matchedInArabic = false,
    this.score = 1.0,
  });
}

/// A direct Ayah jump shortcut (e.g. when typing "2:255" or "Ayatul Kursi").
class DirectAyahJumpModel {
  final String ayahKey;
  final int surahNumber;
  final int ayahNumber;
  final String surahName;
  final String? previewArabic;
  final String? previewTranslation;

  const DirectAyahJumpModel({
    required this.ayahKey,
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahName,
    this.previewArabic,
    this.previewTranslation,
  });
}

/// Aggregated search results containing direct jump, Surah matches, and verse matches.
class QuranSearchResults {
  final String query;
  final Duration executionTime;
  final DirectAyahJumpModel? directJump;
  final List<SurahInfoModel> surahMatches;
  final List<AyahSearchResultModel> ayahResults;
  final int totalCount;

  const QuranSearchResults({
    required this.query,
    required this.executionTime,
    this.directJump,
    this.surahMatches = const [],
    this.ayahResults = const [],
    required this.totalCount,
  });

  bool get isEmpty =>
      directJump == null && surahMatches.isEmpty && ayahResults.isEmpty;

  bool get isNotEmpty => !isEmpty;
}
