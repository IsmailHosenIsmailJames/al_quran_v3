import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/repositories/collections_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: CollectionsRepository)
class CollectionsRepositoryImpl implements CollectionsRepository {
  final CollectionsLocalDataSource _localDataSource;

  CollectionsRepositoryImpl(this._localDataSource);

  @override
  Future<List<PinnedCollectionModel>> fetchPinnedCollections() {
    return _localDataSource.fetchPinnedCollections();
  }

  @override
  Future<List<NoteCollectionModel>> fetchNoteCollections() {
    return _localDataSource.fetchNoteCollections();
  }

  @override
  Future<NoteCollectionModel?> handleAddNewNoteCollection(
    String noteText,
    AppLocalizations l10n,
  ) {
    return _localDataSource.handleAddNewNoteCollection(noteText, l10n);
  }

  @override
  Future<PinnedCollectionModel?> handleAddNewCollection(
    String text,
    AppLocalizations l10n,
  ) {
    return _localDataSource.handleAddNewCollection(text, l10n);
  }

  @override
  Future<void> deleteNoteCollectionByID(String id) {
    return _localDataSource.deleteNoteCollectionByID(id);
  }

  @override
  Future<void> deletePinnedCollectionByID(String id) {
    return _localDataSource.deletePinnedCollectionByID(id);
  }

  @override
  Future<void> saveNoteCollectionModelAsMap(NoteCollectionModel noteCollection) {
    return _localDataSource.saveNoteCollectionModelAsMap(noteCollection);
  }

  @override
  Future<void> savePinnedCollectionModelAsMap(
    PinnedCollectionModel pinnedCollection,
  ) {
    return _localDataSource.savePinnedCollectionModelAsMap(pinnedCollection);
  }
}
