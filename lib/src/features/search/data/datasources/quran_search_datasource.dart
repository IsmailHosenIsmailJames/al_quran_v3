import "dart:convert";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_tafsir_function.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/search/domain/utils/arabic_text_normalizer.dart";
import "package:flutter/services.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class QuranSearchDataSource {
  static const String _searchHistoryKey = "quran_search_history";

  // In-memory cache for plain Arabic Ayahs to avoid parsing JSON during each search
  final Map<String, String> _plainArabicAyahs = {};
  final Map<String, String> _normalizedArabicAyahs = {};
  bool _arabicLoaded = false;

  /// Loads and prepares the Arabic Quran text in memory for fast lookup.
  Future<void> ensureArabicScriptLoaded() async {
    if (_arabicLoaded && _plainArabicAyahs.isNotEmpty) return;

    try {
      await QuranScriptFunction.loadScript(QuranScriptType.uthmani);
      final scriptMap = QuranScriptFunction.quranScriptMap;

      for (final surahKey in scriptMap.keys) {
        final surahMap = scriptMap[surahKey] as Map<String, dynamic>;
        for (final ayahKey in surahMap.keys) {
          final words = List<String>.from(surahMap[ayahKey] as List);
          // Strip rule tags e.g. <rule class=...> and r0..r18
          final buffer = StringBuffer();
          for (final rawWord in words) {
            final cleanWord = rawWord.replaceAll(RegExp(r"<[^>]*>|r\d+"), "");
            if (buffer.isNotEmpty) buffer.write(" ");
            buffer.write(cleanWord);
          }
          final fullAyah = buffer.toString();
          final key = "$surahKey:$ayahKey";
          _plainArabicAyahs[key] = fullAyah;
          _normalizedArabicAyahs[key] = ArabicTextNormalizer.normalize(fullAyah);
        }
      }
      _arabicLoaded = true;
    } catch (_) {
      // Fallback: load directly from asset
      final rawJson = await rootBundle.loadString(
        "assets/quran_script/QPC_Hafs_Tajweed_Compress.json",
      );
      final scriptMap = jsonDecode(rawJson) as Map<String, dynamic>;
      for (final surahKey in scriptMap.keys) {
        final surahMap = scriptMap[surahKey] as Map<String, dynamic>;
        for (final ayahKey in surahMap.keys) {
          final words = List<String>.from(surahMap[ayahKey] as List);
          final buffer = StringBuffer();
          for (final rawWord in words) {
            final cleanWord = rawWord.replaceAll(RegExp(r"<[^>]*>|r\d+"), "");
            if (buffer.isNotEmpty) buffer.write(" ");
            buffer.write(cleanWord);
          }
          final fullAyah = buffer.toString();
          final key = "$surahKey:$ayahKey";
          _plainArabicAyahs[key] = fullAyah;
          _normalizedArabicAyahs[key] = ArabicTextNormalizer.normalize(fullAyah);
        }
      }
      _arabicLoaded = true;
    }
  }

  /// Returns cached plain Arabic text for a verse.
  String? getArabicAyah(String ayahKey) => _plainArabicAyahs[ayahKey];

  /// Returns cached normalized Arabic text for a verse.
  String? getNormalizedArabicAyah(String ayahKey) =>
      _normalizedArabicAyahs[ayahKey];

  /// Returns map of all normalized Arabic Ayahs for batch scanning.
  Map<String, String> getAllNormalizedArabic() => _normalizedArabicAyahs;

  /// Returns map of all plain Arabic Ayahs.
  Map<String, String> getAllPlainArabic() => _plainArabicAyahs;

  /// Returns list of downloaded Translation books from Hive.
  List<ResourcesModel> getDownloadedTranslations() {
    return QuranTranslationFunction.getDownloadedTranslationBooks();
  }

  /// Returns list of currently selected Translation books.
  Future<List<ResourcesModel>> getSelectedTranslations() async {
    return (await QuranTranslationFunction.getTranslationSelections()) ?? [];
  }

  /// Returns list of downloaded Tafsir books from Hive.
  List<ResourcesModel> getDownloadedTafsirs() {
    return QuranTafsirFunction.getDownloadedTafsirBooks();
  }

  /// Returns list of currently selected Tafsir books.
  Future<List<ResourcesModel>> getSelectedTafsirs() async {
    return (await QuranTafsirFunction.getTafsirSelections()) ?? [];
  }

  /// Loads all verse texts from a specific Translation box into memory.
  Future<Map<String, Map<String, dynamic>>> loadTranslationBoxData(
    ResourcesModel book,
  ) async {
    final boxName = QuranTranslationFunction.getTranslationBoxName(
      translationBook: book,
    );

    LazyBox box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.lazyBox(boxName);
    } else {
      box = await Hive.openLazyBox(boxName);
    }

    final result = <String, Map<String, dynamic>>{};
    for (final key in box.keys) {
      if (key == "meta_data") continue;
      final raw = await box.get(key);
      if (raw != null && raw is Map) {
        result[key.toString()] = Map<String, dynamic>.from(raw);
      }
    }
    return result;
  }

  /// Loads all verse texts from a specific Tafsir box into memory.
  Future<Map<String, String>> loadTafsirBoxData(ResourcesModel book) async {
    final boxName = QuranTafsirFunction.getTafsirBoxName(tafsirBook: book);

    LazyBox box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.lazyBox(boxName);
    } else {
      box = await Hive.openLazyBox(boxName);
    }

    final result = <String, String>{};
    for (final key in box.keys) {
      if (key == "meta_data") continue;
      final raw = await box.get(key);
      if (raw != null) {
        if (raw is Map) {
          result[key.toString()] = raw["t"]?.toString() ?? "";
        } else {
          result[key.toString()] = raw.toString();
        }
      }
    }
    return result;
  }

  // --------------------------------------------------------------------------
  // Search History Management
  // --------------------------------------------------------------------------

  /// Returns recent search queries from the user Hive box.
  List<String> getSearchHistory() {
    if (!Hive.isBoxOpen("user")) return [];
    final userBox = Hive.box("user");
    final list = userBox.get(_searchHistoryKey, defaultValue: <dynamic>[]);
    return List<String>.from(list);
  }

  /// Adds a query to recent search history (max 20 items, most recent first).
  Future<void> addSearchHistory(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    if (!Hive.isBoxOpen("user")) await Hive.openBox("user");
    final userBox = Hive.box("user");
    final List<String> history = List<String>.from(
      userBox.get(_searchHistoryKey, defaultValue: <dynamic>[]),
    );

    history.remove(trimmed);
    history.insert(0, trimmed);
    if (history.length > 20) {
      history.removeRange(20, history.length);
    }

    await userBox.put(_searchHistoryKey, history);
  }

  /// Removes a single query from search history.
  Future<void> removeSearchHistoryItem(String query) async {
    if (!Hive.isBoxOpen("user")) await Hive.openBox("user");
    final userBox = Hive.box("user");
    final List<String> history = List<String>.from(
      userBox.get(_searchHistoryKey, defaultValue: <dynamic>[]),
    );

    history.remove(query);
    await userBox.put(_searchHistoryKey, history);
  }

  /// Clears all search history.
  Future<void> clearSearchHistory() async {
    if (!Hive.isBoxOpen("user")) await Hive.openBox("user");
    final userBox = Hive.box("user");
    await userBox.delete(_searchHistoryKey);
  }
}
