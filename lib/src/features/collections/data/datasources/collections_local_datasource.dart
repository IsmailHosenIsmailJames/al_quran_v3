import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/sorting_methods_type.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:uuid/uuid.dart";

const Uuid _uuid = Uuid();

enum CollectionType { pinned, notes }

class CollectionsLocalDataSource {
  static Future<void> saveDemoPinnedCollection() async {
    final box = Hive.box(CollectionType.pinned.name);
    if (box.isEmpty) {
      final now = DateTime.now();
      final demoCollection = PinnedCollectionModel(
        id: "favourites",
        name: "Favourites",
        pinned: [
          PinnedModel(
            id: "demo_pinned_1",
            ayahKey: "1:1",
            createdAt: now,
            updatedAt: now,
          ),
        ],
        createdAt: now,
        updatedAt: now,
      );
      await box.put(demoCollection.id, demoCollection.toJson());
    }
  }

  static Future<void> saveDemoNoteCollection() async {
    final box = Hive.box(CollectionType.notes.name);
    if (box.isEmpty) {
      final now = DateTime.now();
      final demoCollection = NoteCollectionModel(
        id: "demo_notes",
        name: "My Notes",
        notes: [
          NoteModel(
            id: "demo_note_1",
            ayahKey: ["1:1"],
            text: "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
            createdAt: now,
            updatedAt: now,
          ),
        ],
        createdAt: now,
        updatedAt: now,
      );
      await box.put(demoCollection.id, demoCollection.toJson());
    }
  }

  static Future<List<PinnedCollectionModel>> fetchPinnedCollections() async {
    final box = Hive.box(CollectionType.pinned.name);
    await saveDemoPinnedCollection();
    List<PinnedCollectionModel> availablePinnedCollections =
        box.values
            .map(
              (e) => PinnedCollectionModel.fromJson(Map<String, dynamic>.from(e)),
            )
            .toList();
    String sortMethod = Hive.box("user").get(
      "selected_sorting_method",
      defaultValue: SortingMethodsType.values.first.name,
    );
    SortingMethodsType sortingMethodsType = SortingMethodsType.values.firstWhere(
      (element) => element.name == sortMethod,
    );
    switch (sortingMethodsType) {
      case SortingMethodsType.byNameAtoZ:
        availablePinnedCollections.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
      case SortingMethodsType.byNameZtoA:
        availablePinnedCollections.sort(
          (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
        );
      case SortingMethodsType.byElementNumberAscending:
        availablePinnedCollections.sort(
          (a, b) => a.pinned.length.compareTo(b.pinned.length),
        );
      case SortingMethodsType.byElementNumberDescending:
        availablePinnedCollections.sort(
          (a, b) => b.pinned.length.compareTo(a.pinned.length),
        );
      case SortingMethodsType.byUpdateDateAscending:
        availablePinnedCollections.sort(
          (a, b) => b.updatedAt.compareTo(a.updatedAt),
        );
      case SortingMethodsType.byUpdateDateDescending:
        availablePinnedCollections.sort(
          (a, b) => a.updatedAt.compareTo(b.updatedAt),
        );
      case SortingMethodsType.byCreateDateAscending:
        availablePinnedCollections.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
      case SortingMethodsType.byCreateDateDescending:
        availablePinnedCollections.sort(
          (a, b) => a.createdAt.compareTo(b.createdAt),
        );
    }
    return availablePinnedCollections;
  }

  static Future<List<NoteCollectionModel>> fetchNoteCollections() async {
    final box = Hive.box(CollectionType.notes.name);
    await saveDemoNoteCollection();
    List<NoteCollectionModel> availableNoteCollections =
        box.values
            .map(
              (e) => NoteCollectionModel.fromJson(Map<String, dynamic>.from(e)),
            )
            .toList();
    String sortMethod = Hive.box("user").get(
      "selected_sorting_method",
      defaultValue: SortingMethodsType.values.first.name,
    );
    SortingMethodsType sortingMethodsType = SortingMethodsType.values.firstWhere(
      (element) => element.name == sortMethod,
    );
    switch (sortingMethodsType) {
      case SortingMethodsType.byNameAtoZ:
        availableNoteCollections.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
      case SortingMethodsType.byNameZtoA:
        availableNoteCollections.sort(
          (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
        );
      case SortingMethodsType.byElementNumberAscending:
        availableNoteCollections.sort(
          (a, b) => a.notes.length.compareTo(b.notes.length),
        );
      case SortingMethodsType.byElementNumberDescending:
        availableNoteCollections.sort(
          (a, b) => b.notes.length.compareTo(a.notes.length),
        );
      case SortingMethodsType.byUpdateDateAscending:
        availableNoteCollections.sort(
          (a, b) => b.updatedAt.compareTo(a.updatedAt),
        );
      case SortingMethodsType.byUpdateDateDescending:
        availableNoteCollections.sort(
          (a, b) => a.updatedAt.compareTo(b.updatedAt),
        );
      case SortingMethodsType.byCreateDateAscending:
        availableNoteCollections.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
      case SortingMethodsType.byCreateDateDescending:
        availableNoteCollections.sort(
          (a, b) => a.createdAt.compareTo(b.createdAt),
        );
    }
    return availableNoteCollections;
  }

  static Future<NoteCollectionModel?> handleAddNewNoteCollection(
    String noteText,
    AppLocalizations l10n,
  ) async {
    if (noteText.isEmpty) {
      Fluttertoast.showToast(msg: l10n.collectionNameCannotBeEmpty);
      return null;
    }
    final now = DateTime.now();
    String newId = _uuid.v4();

    final newCollection = NoteCollectionModel(
      id: newId,
      name: noteText,
      notes: [],
      createdAt: now,
      updatedAt: now,
    );

    final noteCollectionModel = Hive.box(CollectionType.notes.name);
    await noteCollectionModel.put(newCollection.id, newCollection.toJson());
    Fluttertoast.showToast(msg: l10n.addedNewCollection);
    return newCollection;
  }

  static Future<PinnedCollectionModel?> handleAddNewCollection(
    String text,
    AppLocalizations l10n,
  ) async {
    if (text.isEmpty) {
      Fluttertoast.showToast(msg: l10n.collectionNameCannotBeEmpty);
      return null;
    }
    final now = DateTime.now();
    String newId = _uuid.v4();

    final newCollection = PinnedCollectionModel(
      id: newId,
      name: text,
      pinned: [],
      createdAt: now,
      updatedAt: now,
    );

    final noteCollectionModel = Hive.box(CollectionType.pinned.name);
    await noteCollectionModel.put(newCollection.id, newCollection.toJson());

    Fluttertoast.showToast(msg: l10n.addedNewCollection);
    return newCollection;
  }

  static Future<void> deleteNoteCollectionByID(String id) async {
    final noteCollectionModel = Hive.box(CollectionType.notes.name);
    await noteCollectionModel.delete(id);
  }

  static Future<void> deletePinnedCollectionByID(String id) async {
    final noteCollectionModel = Hive.box(CollectionType.pinned.name);
    await noteCollectionModel.delete(id);
  }

  static Future<void> saveNoteCollectionModelAsMap(
    NoteCollectionModel noteCollection,
  ) async {
    Hive.box(
      CollectionType.notes.name,
    ).put(noteCollection.id, noteCollection.toJson());
  }

  static Future<void> savePinnedCollectionModelAsMap(
    PinnedCollectionModel pinnedCollection,
  ) async {
    Hive.box(
      CollectionType.pinned.name,
    ).put(pinnedCollection.id, pinnedCollection.toJson());
  }
}
