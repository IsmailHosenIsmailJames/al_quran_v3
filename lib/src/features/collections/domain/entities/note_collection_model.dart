import "dart:convert";

import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";

class NoteCollectionModel {
  String id;
  String name;
  String colorHex;
  List<NoteModel> notes;
  DateTime createdAt;
  DateTime updatedAt;

  NoteCollectionModel({
    required this.id,
    required this.name,
    this.colorHex = "808080",
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteCollectionModel.fromJson(Map<String, dynamic> json) {
    return NoteCollectionModel(
      id: json["id"] as String,
      name: json["name"] as String,
      colorHex: json["colorHex"] as String? ?? "808080",
      createdAt: DateTime.parse(json["createdAt"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
      notes:
          ((json["notes"] ?? []) as List<dynamic>)
              .map(
                (noteJson) =>
                    NoteModel.fromJson(Map<String, dynamic>.from(noteJson)),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "colorHex": colorHex,
      "notes": notes.map((note) => note.toJson()).toList(),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  String toJsonString() => json.encode(toJson());

  factory NoteCollectionModel.fromJsonString(String jsonString) =>
      NoteCollectionModel.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );

  NoteCollectionModel copyWith({
    String? id,
    String? name,
    String? colorHex,
    List<NoteModel>? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteCollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
