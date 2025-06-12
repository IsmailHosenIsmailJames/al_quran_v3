import 'dart:convert';

// For generating unique IDs, consider using the `uuid` package:
// import 'package:uuid/uuid.dart';
// var uuid = Uuid();

class NoteModel {
  final String id;
  final String ayahKey; // e.g., "2:255"
  final String text;
  final List<String> collectionIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.ayahKey,
    required this.text,
    this.collectionIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a NoteModel from a map (JSON)
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      ayahKey: json['ayahKey'] as String,
      text: json['text'] as String,
      collectionIds: List<String>.from(json['collectionIds'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Method to convert a NoteModel instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ayahKey': ayahKey,
      'text': text,
      'collectionIds': collectionIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Helper method to convert a NoteModel instance to a JSON string
  String toJsonString() => json.encode(toJson());

  // Helper static method to create a NoteModel from a JSON string
  factory NoteModel.fromJsonString(String jsonString) =>
      NoteModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);

  NoteModel copyWith({
    String? id,
    String? ayahKey,
    String? text,
    List<String>? collectionIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      ayahKey: ayahKey ?? this.ayahKey,
      text: text ?? this.text,
      collectionIds: collectionIds ?? this.collectionIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
