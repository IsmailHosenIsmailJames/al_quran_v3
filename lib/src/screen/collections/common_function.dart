import "dart:developer";

import "package:fluttertoast/fluttertoast.dart";
import "package:hive/hive.dart";

import "../../widget/add_collection_popup/add_note_popup.dart";
import "../../widget/add_collection_popup/add_to_pinned_popup.dart";
import "collection_page.dart";
import "models/note_collection_model.dart";
import "models/pinned_collection_model.dart";

Future<List<PinnedCollectionModel>> fetchPinnedCollections() async {
  final box = Hive.box(CollectionType.pinned.name);
  await saveDemoPinnedCollection();
  List<PinnedCollectionModel> availablePinnedCollections =
      box.values
          .map(
            (e) => PinnedCollectionModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
  // sort availablePinnedCollections by update date. Most recent is first.
  availablePinnedCollections.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
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

  log(availableNoteCollections.length.toString(), name: "XYZ");
  // sort availablePinnedCollections by update date. Most recent is first.
  availableNoteCollections.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  log(availableNoteCollections.length.toString());
  return availableNoteCollections;
}

Future<NoteCollectionModel?> handleAddNewNoteCollection(String noteText) async {
  if (noteText.isEmpty) {
    Fluttertoast.showToast(msg: "Collection name cannot be empty.");
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
  Fluttertoast.showToast(msg: "Added New Collection");
  return newCollection;
}

Future<PinnedCollectionModel?> handleAddNewCollection(String text) async {
  if (text.isEmpty) {
    Fluttertoast.showToast(msg: "Collection name cannot be empty.");
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

  Fluttertoast.showToast(msg: "Added New Collection");
  return newCollection;
}
