import "dart:convert";

class NoteModel {
  String id;
  List<String> ayahKey;
  String text;
  DateTime createdAt;
  DateTime updatedAt;

  /// The server-assigned note ID from the Quran Foundation API.
  /// Null if this note has never been synced to the server.
  String? serverNoteId;

  /// Whether the local version matches the server version.
  /// False when local edits haven't been pushed yet.
  bool isSynced;

  /// Soft-delete flag. When true, the note should be deleted from the server
  /// on the next sync, then removed locally.
  bool isDeleted;

  NoteModel({
    required this.id,
    required this.ayahKey,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    this.serverNoteId,
    this.isSynced = false,
    this.isDeleted = false,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["id"] as String,
      ayahKey: List<String>.from(json["ayahKey"] ?? []),
      text: json["text"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
      serverNoteId: json["serverNoteId"] as String?,
      isSynced: json["isSynced"] as bool? ?? false,
      isDeleted: json["isDeleted"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ayahKey": ayahKey,
      "text": text,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "serverNoteId": serverNoteId,
      "isSynced": isSynced,
      "isDeleted": isDeleted,
    };
  }

  String toJsonString() => json.encode(toJson());

  factory NoteModel.fromJsonString(String jsonString) =>
      NoteModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);

  NoteModel copyWith({
    String? id,
    List<String>? ayahKey,
    String? text,
    List<String>? collectionIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? serverNoteId,
    bool? isSynced,
    bool? isDeleted,
  }) {
    return NoteModel(
      id: id ?? this.id,
      ayahKey: ayahKey ?? this.ayahKey,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serverNoteId: serverNoteId ?? this.serverNoteId,
      isSynced: isSynced ?? this.isSynced,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
