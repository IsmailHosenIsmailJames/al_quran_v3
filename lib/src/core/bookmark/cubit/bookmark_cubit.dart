import 'package:al_quran_v3/src/screen/collections/collection_page.dart';
import 'package:al_quran_v3/src/screen/collections/models/bookmark_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class BookmarkState {
  final List<BookmarkModel> bookmarks;
  final bool isLoading;

  BookmarkState({this.bookmarks = const [], this.isLoading = false});

  Set<String> get bookmarkedKeys => bookmarks.where((b) => !b.isDeleted).map((b) => b.verseKey).toSet();

  BookmarkState copyWith({List<BookmarkModel>? bookmarks, bool? isLoading}) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BookmarkCubit extends Cubit<BookmarkState> {
  final Box _box = Hive.box(CollectionType.bookmark.name);
  static const _uuid = Uuid();

  BookmarkCubit() : super(BookmarkState()) {
    loadBookmarks();
  }

  void loadBookmarks() {
    final list = _box.values
        .map((e) => BookmarkModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    emit(state.copyWith(bookmarks: list));
  }

  Future<void> toggleBookmark({
    required int surahNumber,
    required int ayahNumber,
    required String verseKey,
  }) async {
    final existingIndex = state.bookmarks.indexWhere((b) => b.verseKey == verseKey && !b.isDeleted);
    
    if (existingIndex != -1) {
      // Remove bookmark (soft delete)
      final bookmark = state.bookmarks[existingIndex];
      if (bookmark.serverBookmarkId == null) {
        // Just remove locally if not synced
        await _box.delete(bookmark.id);
      } else {
        // Mark for deletion on server
        final updated = bookmark.copyWith(isDeleted: true, isSynced: false);
        await _box.put(updated.id, updated.toJson());
      }
    } else {
      // Add bookmark
      final newBookmark = BookmarkModel(
        id: _uuid.v4(),
        verseKey: verseKey,
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
        createdAt: DateTime.now(),
        isSynced: false,
      );
      await _box.put(newBookmark.id, newBookmark.toJson());
    }
    loadBookmarks();
  }

  bool isBookmarked(String verseKey) {
    return state.bookmarkedKeys.contains(verseKey);
  }
}
