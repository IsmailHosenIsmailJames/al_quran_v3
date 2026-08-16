import 'package:al_quran_v3/src/features/quran_resources/data/datasources/quran_resources_local_datasource.dart';
import 'package:al_quran_v3/src/features/quran_resources/data/datasources/quran_resources_remote_datasource.dart';
import 'package:al_quran_v3/src/features/quran_resources/data/models/quran_resource_model.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/resource_group_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/repositories/i_quran_resources_repository.dart';
import 'package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart';
import 'package:al_quran_v3/src/features/surah_list/domain/utils/search_pattern_in_text.dart';
import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IQuranResourcesRepository)
class QuranResourcesRepositoryImpl implements IQuranResourcesRepository {
  final QuranResourcesLocalDataSource _localDataSource;
  final QuranResourcesRemoteDataSource _remoteDataSource;

  QuranResourcesRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  bool _matchesQuery(String query, String target) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    final t = target.toLowerCase();
    if (t.contains(q)) return true;
    return searchPatternInText(q, t) > 80.0;
  }

  @override
  Future<List<ResourceGroupEntity>> getTranslationResources({
    String query = '',
  }) async {
    final rawMap = _localDataSource.getRawTranslationsMap();
    final downloaded = _localDataSource.getDownloadedTranslations();
    final selected = await _localDataSource.getSelectedTranslations();

    final List<ResourceGroupEntity> groups = [];
    final sortedKeys = rawMap.keys.sorted();

    for (final languageKey in sortedKeys) {
      final list = rawMap[languageKey] ?? [];
      final books = list
          .map((e) => QuranResourceModel.fromJson(Map<String, dynamic>.from(e)))
          .where((e) => e.type != ResourceType.word_by_word)
          .toList();

      if (books.isEmpty) continue;

      final first = books.first;
      bool matchesSearch = query.isEmpty ||
          _matchesQuery(query, first.language) ||
          _matchesQuery(query, first.languageNative) ||
          books.any(
            (b) =>
                _matchesQuery(query, b.name) ||
                _matchesQuery(query, b.englishName),
          );

      if (!matchesSearch) continue;

      final resourceEntities = books.map((book) {
        final isDownloaded = downloaded.any(
          (d) => d.fullPath == book.fullPath,
        );
        final isSelected =
            isDownloaded &&
            (selected?.any((s) => s.fullPath == book.fullPath) ?? false);
        return book.toEntity(
          isDownloaded: isDownloaded,
          isSelected: isSelected,
        );
      }).toList();

      groups.add(
        ResourceGroupEntity(
          languageKey: languageKey,
          languageNative: first.languageNative,
          languageEnglish: first.language.replaceAll("_", " ").capitalize(),
          resources: resourceEntities,
        ),
      );
    }

    return groups;
  }

  @override
  Future<List<ResourceGroupEntity>> getTafsirResources({
    String query = '',
  }) async {
    final rawMap = _localDataSource.getRawTafsirsMap();
    final downloaded = _localDataSource.getDownloadedTafsirs();
    final selected = await _localDataSource.getSelectedTafsirs();

    final List<ResourceGroupEntity> groups = [];
    final sortedKeys = rawMap.keys.sorted();

    for (final languageKey in sortedKeys) {
      final list = rawMap[languageKey] ?? [];
      final books = list
          .map((e) => QuranResourceModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      if (books.isEmpty) continue;

      final first = books.first;
      bool matchesSearch = query.isEmpty ||
          _matchesQuery(query, first.language) ||
          _matchesQuery(query, first.languageNative) ||
          books.any(
            (b) =>
                _matchesQuery(query, b.name) ||
                _matchesQuery(query, b.englishName),
          );

      if (!matchesSearch) continue;

      final resourceEntities = books.map((book) {
        final isDownloaded = downloaded.any(
          (d) => d.fullPath == book.fullPath,
        );
        final isSelected =
            isDownloaded &&
            (selected?.any((s) => s.fullPath == book.fullPath) ?? false);
        return book.toEntity(
          isDownloaded: isDownloaded,
          isSelected: isSelected,
        );
      }).toList();

      groups.add(
        ResourceGroupEntity(
          languageKey: languageKey,
          languageNative: first.languageNative,
          languageEnglish: first.language.replaceAll("_", " ").capitalize(),
          resources: resourceEntities,
        ),
      );
    }

    return groups;
  }

  @override
  Future<List<QuranResourceEntity>> getWordByWordResources({
    String query = '',
  }) async {
    await _localDataSource.initWordByWord();
    final rawMap = _localDataSource.getRawTranslationsMap();
    final downloaded = _localDataSource.getDownloadedWordByWords();
    final selected = _localDataSource.getSelectedWordByWord();

    final List<QuranResourceModel> allWbW = rawMap.values
        .expand((element) => element)
        .map((e) => QuranResourceModel.fromJson(Map<String, dynamic>.from(e)))
        .where((e) => e.type == ResourceType.word_by_word)
        .sortedBy((e) => e.englishName)
        .toList();

    final filtered = allWbW.where((book) {
      if (query.isEmpty) return true;
      return _matchesQuery(query, book.language) ||
          _matchesQuery(query, book.languageNative) ||
          _matchesQuery(query, book.name) ||
          _matchesQuery(query, book.englishName);
    }).toList();

    return filtered.map((book) {
      final isDownloaded = downloaded.any((d) => d.fullPath == book.fullPath);
      final isSelected = isDownloaded && selected?.fullPath == book.fullPath;
      return book.toEntity(
        isDownloaded: isDownloaded,
        isSelected: isSelected,
      );
    }).toList();
  }

  @override
  Future<bool> downloadResource(
    QuranResourceEntity resource, {
    void Function(double progress, String name)? onProgress,
  }) async {
    final model = QuranResourceModel.fromEntity(resource).toResourcesModel();
    void progressCallback(double? percentage, String name) {
      if (onProgress != null && percentage != null) {
        onProgress(percentage, name);
      }
    }

    if (resource.isWordByWord) {
      return await _remoteDataSource.downloadWordByWordResource(
        model,
        onProgress: progressCallback,
      );
    } else if (resource.isTafsir) {
      return await _remoteDataSource.downloadTafsirResource(
        model,
        onProgress: progressCallback,
      );
    } else {
      return await _remoteDataSource.downloadTranslationResource(
        model,
        onProgress: progressCallback,
      );
    }
  }

  @override
  Future<void> toggleResourceSelection(QuranResourceEntity resource) async {
    final model = QuranResourceModel.fromEntity(resource).toResourcesModel();
    if (resource.isWordByWord) {
      await _localDataSource.toggleWordByWordSelection(model);
    } else if (resource.isTafsir) {
      await _localDataSource.toggleTafsirSelection(model);
    } else {
      await _localDataSource.toggleTranslationSelection(model);
    }
  }

  @override
  Future<void> deleteResource(QuranResourceEntity resource) async {
    final model = QuranResourceModel.fromEntity(resource).toResourcesModel();
    if (resource.isWordByWord) {
      await _localDataSource.deleteWordByWord(model);
    } else if (resource.isTafsir) {
      await _localDataSource.deleteTafsir(model);
    } else {
      await _localDataSource.deleteTranslation(model);
    }
  }
}
