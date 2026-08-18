import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_juz.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/get_page_number.dart";
import "package:al_quran_v3/src/features/search/data/datasources/quran_search_datasource.dart";
import "package:al_quran_v3/src/features/search/data/models/search_filter_model.dart";
import "package:al_quran_v3/src/features/search/data/models/search_result_model.dart";
import "package:al_quran_v3/src/features/search/domain/utils/arabic_text_normalizer.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_list/domain/utils/surah_search_engine.dart";
import "package:injectable/injectable.dart";

@injectable
class SearchQuranUseCase {
  final QuranSearchDataSource _dataSource;

  SearchQuranUseCase(this._dataSource);

  /// Executes a multi-resource search across Surahs, Arabic text, translations, and tafsirs.
  Future<QuranSearchResults> execute({
    required String query,
    required SearchFilterModel filter,
  }) async {
    final stopwatch = Stopwatch()..start();
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      return const QuranSearchResults(
        query: "",
        executionTime: Duration.zero,
        totalCount: 0,
      );
    }

    // 1. Ensure Arabic Quran text is loaded into memory
    await _dataSource.ensureArabicScriptLoaded();

    // 2. Check for direct Ayah Jump patterns (e.g. "2:255", "18:10", "Ayatul Kursi")
    final directJump = _parseDirectAyahJump(trimmedQuery);

    // 3. Match Surah titles
    final List<SurahInfoModel> surahMatches = [];
    if (filter.scope == SearchScope.all || filter.scope == SearchScope.surahs) {
      surahMatches.addAll(_matchSurahs(trimmedQuery));
    }

    // 4. If scope is only Surahs, return early
    if (filter.scope == SearchScope.surahs) {
      stopwatch.stop();
      return QuranSearchResults(
        query: query,
        executionTime: stopwatch.elapsed,
        directJump: directJump,
        surahMatches: surahMatches,
        totalCount: surahMatches.length + (directJump != null ? 1 : 0),
      );
    }

    // 5. Full-Text Verse Search
    final Map<String, _AyahMatchCollector> collectedAyahs = {};
    final normalizedQuery = ArabicTextNormalizer.normalize(trimmedQuery);

    // --- Search in Arabic Quran Script ---
    if (filter.scope == SearchScope.all || filter.scope == SearchScope.arabic) {
      final normalizedMap = _dataSource.getAllNormalizedArabic();
      final plainMap = _dataSource.getAllPlainArabic();

      for (final entry in normalizedMap.entries) {
        final ayahKey = entry.key;
        final normalizedText = entry.value;

        if (!_passesSurahFilter(ayahKey, filter)) continue;

        if (normalizedText.contains(normalizedQuery)) {
          final collector = collectedAyahs.putIfAbsent(
            ayahKey,
            () => _AyahMatchCollector(ayahKey: ayahKey),
          );
          collector.matchedInArabic = true;
          collector.arabicText = plainMap[ayahKey] ?? "";
          collector.score += 3.0; // Higher weight for Arabic direct match
        }
      }
    }

    // --- Search in Translations ---
    if (filter.scope == SearchScope.all || filter.scope == SearchScope.translations) {
      final translationBooks = filter.selectedTranslations.isNotEmpty
          ? filter.selectedTranslations
          : _dataSource.getDownloadedTranslations();

      for (final book in translationBooks) {
        final boxData = await _dataSource.loadTranslationBoxData(book);

        for (final entry in boxData.entries) {
          final ayahKey = entry.key;
          if (!_passesSurahFilter(ayahKey, filter)) continue;

          final verseMap = entry.value;
          final String translationText = verseMap["t"]?.toString() ?? "";
          final Map footnotes = verseMap["f"] is Map ? verseMap["f"] as Map : {};

          final bool matchInTranslation = _textMatchesQuery(
            translationText,
            trimmedQuery,
            exactPhrase: filter.matchExactPhrase,
          );

          String? matchedFootnote;
          bool matchInFootnote = false;
          if (!matchInTranslation && footnotes.isNotEmpty) {
            for (final fnEntry in footnotes.entries) {
              final fnText = fnEntry.value.toString();
              if (_textMatchesQuery(
                fnText,
                trimmedQuery,
                exactPhrase: filter.matchExactPhrase,
              )) {
                matchInFootnote = true;
                matchedFootnote = "${fnEntry.key}. $fnText";
                break;
              }
            }
          }

          if (matchInTranslation || matchInFootnote) {
            final collector = collectedAyahs.putIfAbsent(
              ayahKey,
              () => _AyahMatchCollector(ayahKey: ayahKey),
            );
            collector.translationMatches.add(
              TranslationMatchItem(
                bookInfo: book,
                text: translationText,
                footnote: matchedFootnote,
                matchedInFootnote: matchInFootnote,
              ),
            );
            collector.score += matchInTranslation ? 2.0 : 1.0;
          }
        }
      }
    }

    // --- Search in Tafsirs ---
    if (filter.scope == SearchScope.all || filter.scope == SearchScope.tafsir) {
      final tafsirBooks = filter.selectedTafsirs.isNotEmpty
          ? filter.selectedTafsirs
          : _dataSource.getDownloadedTafsirs();

      for (final book in tafsirBooks) {
        final boxData = await _dataSource.loadTafsirBoxData(book);

        for (final entry in boxData.entries) {
          final ayahKey = entry.key;
          if (!_passesSurahFilter(ayahKey, filter)) continue;

          final String tafsirText = entry.value;
          if (_textMatchesQuery(
            tafsirText,
            trimmedQuery,
            exactPhrase: filter.matchExactPhrase,
          )) {
            final collector = collectedAyahs.putIfAbsent(
              ayahKey,
              () => _AyahMatchCollector(ayahKey: ayahKey),
            );
            collector.tafsirMatches.add(
              TafsirMatchItem(
                bookInfo: book,
                text: tafsirText,
              ),
            );
            collector.score += 1.5;
          }
        }
      }
    }

    // 6. Build final sorted result list
    final List<AyahSearchResultModel> ayahResults = [];
    final plainArabic = _dataSource.getAllPlainArabic();

    for (final collector in collectedAyahs.values) {
      final parts = collector.ayahKey.split(":");
      final surahNum = int.tryParse(parts.first) ?? 1;
      final ayahNum = int.tryParse(parts.last) ?? 1;

      ayahResults.add(
        AyahSearchResultModel(
          ayahKey: collector.ayahKey,
          surahNumber: surahNum,
          ayahNumber: ayahNum,
          pageNumber: getPageNumber(collector.ayahKey) ?? 1,
          juzNumber: _getJuzNumber(collector.ayahKey),
          arabicText: collector.arabicText.isNotEmpty
              ? collector.arabicText
              : (plainArabic[collector.ayahKey] ?? ""),
          translationMatches: collector.translationMatches,
          tafsirMatches: collector.tafsirMatches,
          matchedInArabic: collector.matchedInArabic,
          score: collector.score,
        ),
      );
    }

    // Sort by relevance score (descending), then Quran canonical order (surah, ayah)
    ayahResults.sort((a, b) {
      if ((b.score - a.score).abs() > 0.01) {
        return b.score.compareTo(a.score);
      }
      if (a.surahNumber != b.surahNumber) {
        return a.surahNumber.compareTo(b.surahNumber);
      }
      return a.ayahNumber.compareTo(b.ayahNumber);
    });

    stopwatch.stop();

    return QuranSearchResults(
      query: query,
      executionTime: stopwatch.elapsed,
      directJump: directJump,
      surahMatches: surahMatches,
      ayahResults: ayahResults,
      totalCount: ayahResults.length +
          surahMatches.length +
          (directJump != null ? 1 : 0),
    );
  }

  // --------------------------------------------------------------------------
  // Helper Matchers
  // --------------------------------------------------------------------------

  bool _passesSurahFilter(String ayahKey, SearchFilterModel filter) {
    final surahNum = int.tryParse(ayahKey.split(":").first) ?? 1;

    // Filter by specific Surah
    if (filter.surahNumber != null && filter.surahNumber != surahNum) {
      return false;
    }

    // Filter by Revelation Type (meccan / medinan)
    if (filter.revelationType != "all") {
      final surahData = metaDataSurah[surahNum.toString()];
      if (surahData != null) {
        final rp = surahData["rp"]?.toString().toLowerCase() ?? "";
        final isMakkah = rp.startsWith("mak");
        if (filter.revelationType == "meccan" && !isMakkah) return false;
        if (filter.revelationType == "medinan" && isMakkah) return false;
      }
    }

    return true;
  }

  bool _textMatchesQuery(
    String sourceText,
    String query, {
    bool exactPhrase = false,
  }) {
    if (sourceText.isEmpty) return false;
    final lowerSource = sourceText.toLowerCase();
    final lowerQuery = query.toLowerCase();

    if (exactPhrase) {
      return lowerSource.contains(lowerQuery);
    }

    // Multi-token match: all words must be present
    final queryTokens = lowerQuery
        .split(RegExp(r"\s+"))
        .where((t) => t.trim().isNotEmpty)
        .toList();

    if (queryTokens.isEmpty) return false;

    for (final token in queryTokens) {
      if (!lowerSource.contains(token)) {
        return false;
      }
    }
    return true;
  }

  List<SurahInfoModel> _matchSurahs(String query) {
    return SurahSearchEngine.instance.search(query);
  }

  DirectAyahJumpModel? _parseDirectAyahJump(String query) {
    final trimmed = query.trim().toLowerCase();

    // Check special famous verse names
    if (trimmed == "ayatul kursi" ||
        trimmed == "ayat al kursi" ||
        trimmed == "kursi" ||
        trimmed == "আয়াতুল কুরসী" ||
        trimmed == "আয়াতুল কুরসি") {
      final arabic = _dataSource.getArabicAyah("2:255");
      return DirectAyahJumpModel(
        ayahKey: "2:255",
        surahNumber: 2,
        ayahNumber: 255,
        surahName: "Al-Baqarah",
        previewArabic: arabic,
      );
    }

    // Regex pattern for "2:255", "18:10", "2 255", "surah 2:255"
    final regex = RegExp(
      r"^(?:surah\s+)?(\d{1,3})[:\s,.-]+(\d{1,3})$",
      caseSensitive: false,
    );
    final match = regex.firstMatch(trimmed);

    if (match != null) {
      final surah = int.tryParse(match.group(1) ?? "");
      final ayah = int.tryParse(match.group(2) ?? "");

      if (surah != null && ayah != null && surah >= 1 && surah <= 114) {
        final surahData = metaDataSurah[surah.toString()];
        if (surahData != null) {
          final surahModel = SurahInfoModel.fromMap(surahData);
          if (ayah >= 1 && ayah <= surahModel.versesCount) {
            final ayahKey = "$surah:$ayah";
            final arabic = _dataSource.getArabicAyah(ayahKey);
            return DirectAyahJumpModel(
              ayahKey: ayahKey,
              surahNumber: surah,
              ayahNumber: ayah,
              surahName: canonicalSurahTransliterations[surah - 1],
              previewArabic: arabic,
            );
          }
        }
      }
    }

    return null;
  }

  int _getJuzNumber(String ayahKey) {
    final surah = int.tryParse(ayahKey.split(":").first) ?? 1;
    final ayah = int.tryParse(ayahKey.split(":").last) ?? 1;

    for (final entry in metaDataJuz.entries) {
      final Map<String, dynamic> vm = entry.value["vm"] as Map<String, dynamic>;
      if (vm.containsKey(surah.toString())) {
        final range = vm[surah.toString()]!.toString().split("-");
        final start = int.tryParse(range.first) ?? 1;
        final end = int.tryParse(range.last) ?? 1;
        if (ayah >= start && ayah <= end) {
          return int.tryParse(entry.key) ?? 1;
        }
      }
    }
    return 1;
  }
}

class _AyahMatchCollector {
  final String ayahKey;
  String arabicText = "";
  bool matchedInArabic = false;
  final List<TranslationMatchItem> translationMatches = [];
  final List<TafsirMatchItem> tafsirMatches = [];
  double score = 0.0;

  _AyahMatchCollector({required this.ayahKey});
}
