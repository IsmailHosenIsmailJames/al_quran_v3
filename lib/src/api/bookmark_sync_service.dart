import 'dart:developer' as developer;

import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/api/quran_bookmark_api.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart'; // For QuranApiException
import 'package:al_quran_v3/src/screen/collections/collection_page.dart';
import 'package:al_quran_v3/src/screen/collections/models/bookmark_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

/// Orchestrates bidirectional sync between local Hive bookmarks and the
/// Quran Foundation Bookmarks API.
class BookmarkSyncService {
  static const String _logName = 'BookmarkSyncService';
  static bool _isSyncing = false;
  static bool get isSyncing => _isSyncing;

  /// Performs a full bidirectional sync.
  static Future<void> fullSync() async {
    if (_isSyncing) return;
    if (!QuranAuthSession.isLoggedIn) return;

    _isSyncing = true;
    try {
      developer.log('Starting bookmark sync...', name: _logName);
      await _pushLocalChanges();
      await _pullServerBookmarks();
      developer.log('Bookmark sync completed', name: _logName);
    } on QuranApiException {
      _isSyncing = false;
      rethrow;
    } catch (e) {
      developer.log('Bookmark sync error: $e', name: _logName, error: e);
      _isSyncing = false;
      rethrow;
    } finally {
      _isSyncing = false;
    }
  }

  // ─── Push (Local → Server) ──────────────────────────────────

  static Future<void> _pushLocalChanges() async {
    final box = Hive.box(CollectionType.bookmark.name);

    for (final key in box.keys) {
      final data = box.get(key);
      if (data == null) continue;

      final bookmark = BookmarkModel.fromJson(Map<String, dynamic>.from(data));

      // Handle soft-deleted bookmarks
      if (bookmark.isDeleted) {
        if (bookmark.serverBookmarkId != null) {
          try {
            await QuranBookmarkApi.deleteBookmark(bookmark.serverBookmarkId!);
          } catch (e) {
            developer.log('Failed to delete bookmark ${bookmark.id} from server', name: _logName);
          }
        }
        await box.delete(bookmark.id);
        continue;
      }

      // Handle new bookmarks
      if (bookmark.serverBookmarkId == null) {
        try {
          final apiBookmark = await QuranBookmarkApi.addBookmark(
            key: bookmark.surahNumber.toString(),
            type: 'ayah',
            verseNumber: bookmark.ayahNumber,
          );
          final updated = bookmark.copyWith(
            serverBookmarkId: apiBookmark.id,
            isSynced: true,
          );
          await box.put(updated.id, updated.toJson());
        } catch (e) {
          developer.log('Failed to push bookmark ${bookmark.id} to server', name: _logName);
        }
      }
    }
  }

  // ─── Pull (Server → Local) ──────────────────────────────────

  static Future<void> _pullServerBookmarks() async {
    final serverBookmarks = await QuranBookmarkApi.getBookmarks();
    final box = Hive.box(CollectionType.bookmark.name);

    // Build a map of serverId -> bookmark for existing local bookmarks
    final localBookmarks = box.values
        .map((e) => BookmarkModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    for (final apiBookmark in serverBookmarks) {
      final verseKey = apiBookmark.type == 'ayah' 
          ? '${apiBookmark.key}:${apiBookmark.verseNumber}' 
          : apiBookmark.key;
      
      final existingLocal = localBookmarks.firstWhere(
        (b) => b.serverBookmarkId == apiBookmark.id,
        orElse: () => localBookmarks.firstWhere(
          (b) => b.verseKey == verseKey && b.serverBookmarkId == null,
          orElse: () => BookmarkModel(
            id: const Uuid().v4(),
            verseKey: verseKey,
            surahNumber: int.parse(apiBookmark.key),
            ayahNumber: apiBookmark.verseNumber ?? 0,
            createdAt: apiBookmark.createdAt,
            serverBookmarkId: apiBookmark.id,
            isSynced: true,
          ),
        ),
      );

      // Update local if not matched or needs server ID
      if (existingLocal.serverBookmarkId == null) {
        final updated = existingLocal.copyWith(
          serverBookmarkId: apiBookmark.id,
          isSynced: true,
        );
        await box.put(updated.id, updated.toJson());
      }
    }
  }
}
