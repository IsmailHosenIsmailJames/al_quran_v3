import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";

abstract class CollectionsRepository {
  Future<List<PinnedCollectionModel>> fetchPinnedCollections();
  Future<List<NoteCollectionModel>> fetchNoteCollections();
  Future<NoteCollectionModel?> handleAddNewNoteCollection(
    String noteText,
    AppLocalizations l10n,
  );
  Future<PinnedCollectionModel?> handleAddNewCollection(
    String text,
    AppLocalizations l10n,
  );
  Future<void> deleteNoteCollectionByID(String id);
  Future<void> deletePinnedCollectionByID(String id);
  Future<void> saveNoteCollectionModelAsMap(NoteCollectionModel noteCollection);
  Future<void> savePinnedCollectionModelAsMap(PinnedCollectionModel pinnedCollection);
}
