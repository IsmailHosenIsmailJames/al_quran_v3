import 'dart:convert';

class BookmarkModel {
  final String id; // Local UUID
  final String verseKey;
  final int surahNumber;
  final int ayahNumber;
  final DateTime createdAt;
  
  /// The server-assigned bookmark ID from the Quran Foundation API.
  /// Null if this bookmark has never been synced to the server.
  String? serverBookmarkId;

  /// Whether the local version matches the server version.
  bool isSynced;

  /// Soft-delete flag.
  bool isDeleted;

  BookmarkModel({
    required this.id,
    required this.verseKey,
    required this.surahNumber,
    required this.ayahNumber,
    required this.createdAt,
    this.serverBookmarkId,
    this.isSynced = false,
    this.isDeleted = false,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] as String,
      verseKey: json['verseKey'] as String,
      surahNumber: json['surahNumber'] as int,
      ayahNumber: json['ayahNumber'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      serverBookmarkId: json['serverBookmarkId'] as String?,
      isSynced: json['isSynced'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'verseKey': verseKey,
      'surahNumber': surahNumber,
      'ayahNumber': ayahNumber,
      'createdAt': createdAt.toIso8601String(),
      'serverBookmarkId': serverBookmarkId,
      'isSynced': isSynced,
      'isDeleted': isDeleted,
    };
  }

  String toJsonString() => json.encode(toJson());

  BookmarkModel copyWith({
    String? id,
    String? verseKey,
    int? surahNumber,
    int? ayahNumber,
    DateTime? createdAt,
    String? serverBookmarkId,
    bool? isSynced,
    bool? isDeleted,
  }) {
    return BookmarkModel(
      id: id ?? this.id,
      verseKey: verseKey ?? this.verseKey,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      createdAt: createdAt ?? this.createdAt,
      serverBookmarkId: serverBookmarkId ?? this.serverBookmarkId,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
