import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:flutter/material.dart";
import "package:al_quran_v3/src/utils/show_toast_message.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

import "../../widget/add_collection_popup/add_note_popup.dart";
import "../../widget/add_collection_popup/add_to_pinned_popup.dart";
import "collection_page.dart";
import "models/note_collection_model.dart";
import "models/pinned_collection_model.dart";
import "models/sorting_methods_type.dart";

Future<List<PinnedCollectionModel>> fetchPinnedCollections() async {
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

Future<List<NoteCollectionModel>> fetchNoteCollections() async {
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

Future<NoteCollectionModel?> handleAddNewNoteCollection(
  String noteText,
  AppLocalizations l10n,
) async {
  if (noteText.isEmpty) {
    if (navigatorKey.currentState?.context != null) {
      showToastMessage(
        context: navigatorKey.currentState!.context,
        msg: l10n.collectionNameCannotBeEmpty,
      );
    }
    return null;
  }
  final now = DateTime.now();
  String newId = uuid.v4();

  final newCollection = NoteCollectionModel(
    id: newId,
    name: noteText,
    notes: [],
    createdAt: now,
    updatedAt: now,
  );

  final noteCollectionModel = Hive.box(CollectionType.notes.name);
  await noteCollectionModel.put(newCollection.id, newCollection.toJson());
  if (navigatorKey.currentState?.context != null) {
    showToastMessage(
      context: navigatorKey.currentState!.context,
      msg: l10n.addedNewCollection,
    );
    return newCollection;
  }
  return null;
}

Future<PinnedCollectionModel?> handleAddNewCollection(
  String text,
  AppLocalizations l10n,
) async {
  if (text.isEmpty) {
    if (navigatorKey.currentState?.context != null) {
      showToastMessage(
        context: navigatorKey.currentState!.context,
        msg: l10n.collectionNameCannotBeEmpty,
      );
    }
    return null;
  }
  final now = DateTime.now();
  String newId = uuid.v4();

  final newCollection = PinnedCollectionModel(
    id: newId,
    name: text,
    pinned: [],
    createdAt: now,
    updatedAt: now,
  );

  final noteCollectionModel = Hive.box(CollectionType.pinned.name);
  await noteCollectionModel.put(newCollection.id, newCollection.toJson());

  if (navigatorKey.currentState?.context != null) {
    showToastMessage(
      context: navigatorKey.currentState!.context,
      msg: l10n.addedNewCollection,
    );
  }
  return newCollection;
}

Future<void> deleteNoteCollectionByID(String id) async {
  final noteCollectionModel = Hive.box(CollectionType.notes.name);
  await noteCollectionModel.delete(id);
}

Future<void> deletePinnedCollectionByID(String id) async {
  final noteCollectionModel = Hive.box(CollectionType.pinned.name);
  await noteCollectionModel.delete(id);
}

Color safeParseColor(String? hexColor, {Color defaultColor = Colors.grey}) {
  if (hexColor == null || hexColor.isEmpty) return defaultColor;
  try {
    return Color(int.parse("0xFF$hexColor"));
  } catch (e) {
    return defaultColor;
  }
}

Future<void> saveNoteCollectionModelAsMap(
  NoteCollectionModel noteCollection,
) async {
  Hive.box(
    CollectionType.notes.name,
  ).put(noteCollection.id, noteCollection.toJson());
}

Future<void> savePinnedCollectionModelAsMap(
  PinnedCollectionModel pinnedCollection,
) async {
  Hive.box(
    CollectionType.pinned.name,
  ).put(pinnedCollection.id, pinnedCollection.toJson());
}
