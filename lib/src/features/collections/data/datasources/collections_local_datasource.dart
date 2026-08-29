import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/sorting_methods_type.dart";
import "package:al_quran_v3/src/features/collections/presentation/helpers/collection_ui_helpers.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";
import "package:uuid/uuid.dart";

enum CollectionType { pinned, notes }

abstract class CollectionsLocalDataSource {
  Future<void> saveDemoPinnedCollection();
  Future<void> saveDemoNoteCollection();
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
  Future<void> saveNoteCollectionModelAsMap(
    NoteCollectionModel noteCollection,
  );
  Future<void> savePinnedCollectionModelAsMap(
    PinnedCollectionModel pinnedCollection,
  );
}

@LazySingleton(as: CollectionsLocalDataSource)
class CollectionsLocalDataSourceImpl implements CollectionsLocalDataSource {
  static const Uuid _uuid = Uuid();

  @override
  Future<void> saveDemoPinnedCollection() async {
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

  @override
  Future<void> saveDemoNoteCollection() async {
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
            text:
                "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
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

  @override
  Future<List<PinnedCollectionModel>> fetchPinnedCollections() async {
    final box = Hive.box(CollectionType.pinned.name);
    await saveDemoPinnedCollection();
    List<PinnedCollectionModel> availablePinnedCollections =
        box.values
            .map(
              (e) => PinnedCollectionModel.fromJson(
                deepConvertMap(e as Map),
              ),
            )
            .where((collection) => !collection.isDeleted)
            .map((collection) => collection.copyWith(
                  pinned: collection.pinned.where((p) => !p.isDeleted).toList(),
                ))
            .toList();
    String sortMethod = Hive.box("user").get(
      "selected_sorting_method",
      defaultValue: SortingMethodsType.values.first.name,
    );
    SortingMethodsType sortingMethodsType =
        SortingMethodsType.values.firstWhere(
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

  @override
  Future<List<NoteCollectionModel>> fetchNoteCollections() async {
    final box = Hive.box(CollectionType.notes.name);
    await saveDemoNoteCollection();
    List<NoteCollectionModel> availableNoteCollections =
        box.values
            .map(
              (e) =>
                  NoteCollectionModel.fromJson(deepConvertMap(e as Map)),
            )
            .where((collection) => !collection.isDeleted)
            .map((collection) => collection.copyWith(
                  notes: collection.notes.where((n) => !n.isDeleted).toList(),
                ))
            .toList();
    String sortMethod = Hive.box("user").get(
      "selected_sorting_method",
      defaultValue: SortingMethodsType.values.first.name,
    );
    SortingMethodsType sortingMethodsType =
        SortingMethodsType.values.firstWhere(
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

  @override
  Future<NoteCollectionModel?> handleAddNewNoteCollection(
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

  @override
  Future<PinnedCollectionModel?> handleAddNewCollection(
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

  @override
  Future<void> deleteNoteCollectionByID(String id) async {
    final noteCollectionModel = Hive.box(CollectionType.notes.name);
    final raw = noteCollectionModel.get(id);
    if (raw != null && raw is Map) {
      final now = DateTime.now();
      final model = NoteCollectionModel.fromJson(deepConvertMap(raw));
      final updated = model.copyWith(
        isDeleted: true,
        deletedAt: now,
        updatedAt: now,
      );
      await noteCollectionModel.put(id, updated.toJson());
    } else {
      await noteCollectionModel.delete(id);
    }
  }

  @override
  Future<void> deletePinnedCollectionByID(String id) async {
    final pinnedCollectionModel = Hive.box(CollectionType.pinned.name);
    final raw = pinnedCollectionModel.get(id);
    if (raw != null && raw is Map) {
      final now = DateTime.now();
      final model = PinnedCollectionModel.fromJson(deepConvertMap(raw));
      final updated = model.copyWith(
        isDeleted: true,
        deletedAt: now,
        updatedAt: now,
      );
      await pinnedCollectionModel.put(id, updated.toJson());
    } else {
      await pinnedCollectionModel.delete(id);
    }
  }

  @override
  Future<void> saveNoteCollectionModelAsMap(
    NoteCollectionModel noteCollection,
  ) async {
    final updatedCollection = noteCollection.copyWith(updatedAt: DateTime.now());
    await Hive.box(
      CollectionType.notes.name,
    ).put(updatedCollection.id, updatedCollection.toJson());
  }

  @override
  Future<void> savePinnedCollectionModelAsMap(
    PinnedCollectionModel pinnedCollection,
  ) async {
    final updatedCollection = pinnedCollection.copyWith(updatedAt: DateTime.now());
    await Hive.box(
      CollectionType.pinned.name,
    ).put(updatedCollection.id, updatedCollection.toJson());
  }
}
