import 'dart:developer' as developer;

import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart';
import 'package:al_quran_v3/src/screen/collections/collection_page.dart';
import 'package:al_quran_v3/src/screen/collections/models/note_collection_model.dart';
import 'package:al_quran_v3/src/screen/collections/models/note_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Orchestrates bidirectional sync between local Hive notes and the
/// Quran Foundation Notes API.
///
/// **Collection Bridging:**
/// The API has no folder/collection concept. To preserve the local folder
/// structure, each note's body is prefixed with a hidden metadata tag:
///   `<!--qcollection:collectionId:collectionName-->`
/// This tag is stripped when displaying notes and parsed when pulling
/// from the server to re-group notes into local collections.
class NotesSyncService {
  static const String _logName = 'NotesSyncService';

  // Regex to match and extract the hidden collection tag
  static final RegExp _collectionTagRegex = RegExp(
    r'^<!--qcollection:([^:]+):([^>]*)-->\n?',
  );

  /// Default collection name for notes pulled from the server
  /// that don't have a collection tag.
  static const String _defaultCloudCollectionName = 'Cloud Notes';
  static const String _defaultCloudCollectionId = '__cloud_notes__';

  /// Whether a sync is currently in progress.
  static bool _isSyncing = false;
  static bool get isSyncing => _isSyncing;

  // ─── Public API ─────────────────────────────────────────────

  /// Performs a full bidirectional sync.
  /// 1. Push local changes (new, modified, deleted) to the server.
  /// 2. Pull server notes and merge into local storage.
  static Future<void> fullSync() async {
    if (_isSyncing) {
      developer.log('Sync already in progress, skipping', name: _logName);
      return;
    }
    if (!QuranAuthSession.isLoggedIn) {
      developer.log('Not logged in, skipping sync', name: _logName);
      return;
    }

    _isSyncing = true;
    try {
      developer.log('Starting full sync...', name: _logName);
      await _pushLocalChanges();
      await _pullServerNotes();
      developer.log('Full sync completed', name: _logName);
    } on QuranApiException {
      _isSyncing = false;
      rethrow;
    } catch (e) {
      developer.log('Full sync error: $e', name: _logName, error: e);
      _isSyncing = false;
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  /// Syncs a single newly created note to the server immediately.
  /// Called right after the user saves a note locally.
  static Future<void> syncSingleNote({
    required NoteModel note,
    required String collectionId,
    required String collectionName,
  }) async {
    if (!QuranAuthSession.isLoggedIn) return;

    try {
      final bodyWithTag = _addCollectionTag(
        note.text,
        collectionId,
        collectionName,
      );

      // Build verse ranges from ayahKey
      final ranges = _buildRangesFromAyahKeys(note.ayahKey);

      final apiNote = await QuranNotesApi.addNote(
        body: bodyWithTag,
        ranges: ranges,
      );

      // Update the local note with the server ID
      note.serverNoteId = apiNote.id;
      note.isSynced = true;
      _updateNoteInCollection(collectionId, note);
      developer.log(
        'Note ${note.id} synced → server ID: ${apiNote.id}',
        name: _logName,
      );
    } catch (e) {
      developer.log('syncSingleNote error: $e', name: _logName, error: e);
    }
  }

  /// Syncs an updated note to the server.
  static Future<void> syncUpdatedNote({
    required NoteModel note,
    required String collectionId,
    required String collectionName,
  }) async {
    if (!QuranAuthSession.isLoggedIn) return;
    if (note.serverNoteId == null) {
      // Note was never synced — do a full push instead
      await syncSingleNote(
        note: note,
        collectionId: collectionId,
        collectionName: collectionName,
      );
      return;
    }

    try {
      final bodyWithTag = _addCollectionTag(
        note.text,
        collectionId,
        collectionName,
      );

      await QuranNotesApi.updateNote(
        noteId: note.serverNoteId!,
        body: bodyWithTag,
      );

      note.isSynced = true;
      _updateNoteInCollection(collectionId, note);
      developer.log('Note ${note.id} updated on server', name: _logName);
    } catch (e) {
      developer.log('syncUpdatedNote error: $e', name: _logName, error: e);
    }
  }

  /// Deletes a note from the server.
  static Future<void> syncDeletedNote(NoteModel note) async {
    if (!QuranAuthSession.isLoggedIn) return;
    if (note.serverNoteId == null) return; // Never synced, nothing to delete

    try {
      await QuranNotesApi.deleteNote(note.serverNoteId!);
      developer.log('Note ${note.id} deleted from server', name: _logName);
    } catch (e) {
      developer.log('syncDeletedNote error: $e', name: _logName, error: e);
    }
  }

  // ─── Push (Local → Server) ──────────────────────────────────

  static Future<void> _pushLocalChanges() async {
    final box = Hive.box(CollectionType.notes.name);

    for (final key in box.keys) {
      final data = box.get(key);
      if (data == null) continue;

      final collection = NoteCollectionModel.fromJson(
        Map<String, dynamic>.from(data),
      );

      // Process each note in the collection
      for (int i = 0; i < collection.notes.length; i++) {
        final note = collection.notes[i];

        // Handle soft-deleted notes
        if (note.isDeleted) {
          if (note.serverNoteId != null) {
            await QuranNotesApi.deleteNote(note.serverNoteId!);
          }
          collection.notes.removeAt(i);
          i--; // Adjust index after removal
          continue;
        }

        // Handle new notes (never synced)
        if (note.serverNoteId == null) {
          final bodyWithTag = _addCollectionTag(
            note.text,
            collection.id,
            collection.name,
          );
          final ranges = _buildRangesFromAyahKeys(note.ayahKey);

          final apiNote = await QuranNotesApi.addNote(
            body: bodyWithTag,
            ranges: ranges,
          );

          note.serverNoteId = apiNote.id;
          note.isSynced = true;
          developer.log(
            'Pushed new note ${note.id} → ${apiNote.id}',
            name: _logName,
          );
          continue;
        }

        // Handle modified notes (has serverNoteId but not synced)
        if (!note.isSynced) {
          final bodyWithTag = _addCollectionTag(
            note.text,
            collection.id,
            collection.name,
          );

          await QuranNotesApi.updateNote(
            noteId: note.serverNoteId!,
            body: bodyWithTag,
          );

          note.isSynced = true;
          developer.log('Pushed update for note ${note.id}', name: _logName);
        }
      }

      // Save the updated collection back to Hive
      await box.put(collection.id, collection.toJson());
    }
  }

  // ─── Pull (Server → Local) ─────────────────────────────────

  static Future<void> _pullServerNotes() async {
    final serverNotes = await QuranNotesApi.getAllNotes();
    if (serverNotes.isEmpty) return;

    final box = Hive.box(CollectionType.notes.name);

    // Build a map of serverNoteId → (collectionId, noteIndex) for quick lookup
    final Map<String, _LocalNoteRef> localIndex = {};
    for (final key in box.keys) {
      final data = box.get(key);
      if (data == null) continue;
      final collection = NoteCollectionModel.fromJson(
        Map<String, dynamic>.from(data),
      );
      for (int i = 0; i < collection.notes.length; i++) {
        final note = collection.notes[i];
        if (note.serverNoteId != null) {
          localIndex[note.serverNoteId!] = _LocalNoteRef(
            collectionId: collection.id,
            noteIndex: i,
          );
        }
      }
    }

    for (final serverNote in serverNotes) {
      if (localIndex.containsKey(serverNote.id)) {
        // Note exists locally — check if server version is newer
        final ref = localIndex[serverNote.id]!;
        final collectionData = box.get(ref.collectionId);
        if (collectionData == null) continue;

        final collection = NoteCollectionModel.fromJson(
          Map<String, dynamic>.from(collectionData),
        );

        if (ref.noteIndex < collection.notes.length) {
          final localNote = collection.notes[ref.noteIndex];
          if (serverNote.updatedAt.isAfter(localNote.updatedAt)) {
            // Server is newer — update local
            final cleanBody = _removeCollectionTag(serverNote.body);
            localNote.text = cleanBody;
            localNote.updatedAt = serverNote.updatedAt;
            localNote.isSynced = true;
            await box.put(collection.id, collection.toJson());
            developer.log(
              'Updated local note from server: ${serverNote.id}',
              name: _logName,
            );
          }
        }
      } else {
        // Note doesn't exist locally — create it
        final tagInfo = _extractCollectionTag(serverNote.body);
        final cleanBody = _removeCollectionTag(serverNote.body);

        final targetCollectionId =
            tagInfo?.collectionId ?? _defaultCloudCollectionId;
        final targetCollectionName =
            tagInfo?.collectionName ?? _defaultCloudCollectionName;

        // Find or create the target collection
        NoteCollectionModel? collection;
        final existingData = box.get(targetCollectionId);
        if (existingData != null) {
          collection = NoteCollectionModel.fromJson(
            Map<String, dynamic>.from(existingData),
          );
        } else {
          collection = NoteCollectionModel(
            id: targetCollectionId,
            name: targetCollectionName,
            notes: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
        }

        // Build ayahKey from ranges
        final ayahKeys = _extractAyahKeysFromRanges(serverNote.ranges);

        final newNote = NoteModel(
          id: serverNote.id, // Use server ID as local ID for pulled notes
          ayahKey: ayahKeys,
          text: cleanBody,
          createdAt: serverNote.createdAt,
          updatedAt: serverNote.updatedAt,
          serverNoteId: serverNote.id,
          isSynced: true,
        );

        collection.notes.add(newNote);
        collection.updatedAt = DateTime.now();
        await box.put(collection.id, collection.toJson());

        developer.log(
          'Pulled new note from server: ${serverNote.id} → collection "${collection.name}"',
          name: _logName,
        );
      }
    }
  }

  // ─── Collection Tag Helpers ─────────────────────────────────

  /// Prepends the hidden collection metadata tag to a note body.
  static String _addCollectionTag(
    String body,
    String collectionId,
    String collectionName,
  ) {
    return '<!--qcollection:$collectionId:$collectionName-->\n$body';
  }

  /// Removes the collection tag from a note body for display.
  static String removeCollectionTag(String body) {
    return _removeCollectionTag(body);
  }

  static String _removeCollectionTag(String body) {
    return body.replaceFirst(_collectionTagRegex, '');
  }

  /// Extracts collection info from a tagged note body.
  static _CollectionTagInfo? _extractCollectionTag(String body) {
    final match = _collectionTagRegex.firstMatch(body);
    if (match == null) return null;
    return _CollectionTagInfo(
      collectionId: match.group(1)!,
      collectionName: match.group(2)!,
    );
  }

  // ─── Verse Range Helpers ────────────────────────────────────

  /// Converts ayahKey list (e.g. ["2:255"]) to API range format
  /// (e.g. ["2:255-2:255"]).
  static List<String> _buildRangesFromAyahKeys(List<String> ayahKeys) {
    if (ayahKeys.isEmpty) return [];
    // Each ayahKey becomes a single-verse range
    return ayahKeys.map((key) => '$key-$key').toList();
  }

  /// Extracts ayah keys from API range format.
  /// e.g. ["2:255-2:257"] → ["2:255"]
  static List<String> _extractAyahKeysFromRanges(List<String>? ranges) {
    if (ranges == null || ranges.isEmpty) return [];
    return ranges.map((range) {
      // Take the start of the range
      final parts = range.split('-');
      return parts.first;
    }).toList();
  }

  // ─── Local Storage Helpers ──────────────────────────────────

  /// Updates a note within its collection in Hive.
  static void _updateNoteInCollection(String collectionId, NoteModel note) {
    final box = Hive.box(CollectionType.notes.name);
    final data = box.get(collectionId);
    if (data == null) return;

    final collection = NoteCollectionModel.fromJson(
      Map<String, dynamic>.from(data),
    );

    final noteIndex = collection.notes.indexWhere((n) => n.id == note.id);
    if (noteIndex >= 0) {
      collection.notes[noteIndex] = note;
      box.put(collection.id, collection.toJson());
    }
  }
}

/// Internal helper to reference a note's location in local storage.
class _LocalNoteRef {
  final String collectionId;
  final int noteIndex;

  _LocalNoteRef({required this.collectionId, required this.noteIndex});
}

/// Internal helper to hold parsed collection tag info.
class _CollectionTagInfo {
  final String collectionId;
  final String collectionName;

  _CollectionTagInfo({
    required this.collectionId,
    required this.collectionName,
  });
}
