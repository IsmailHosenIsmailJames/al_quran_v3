import 'dart:convert';

// For generating unique IDs, consider using the `uuid` package:
// import 'package:uuid/uuid.dart';
// var uuid = Uuid();

class NoteCollectionModel {
  final String id;
  final String name;
  final String colorHex; // e.g., "FFC107" for yellow, "4CAF50" for green
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteCollectionModel({
    required this.id,
    required this.name,
    this.colorHex = "808080", // Default to gray if not specified
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a NoteCollectionModel from a map (JSON)
  factory NoteCollectionModel.fromJson(Map<String, dynamic> json) {
    return NoteCollectionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      colorHex: json['colorHex'] as String? ?? "808080",
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Method to convert a NoteCollectionModel instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'colorHex': colorHex,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Helper method to convert a NoteCollectionModel instance to a JSON string
  String toJsonString() => json.encode(toJson());

  // Helper static method to create a NoteCollectionModel from a JSON string
  factory NoteCollectionModel.fromJsonString(String jsonString) =>
      NoteCollectionModel.fromJson(
        json.decode(jsonString) as Map<String, dynamic>,
      );

  NoteCollectionModel copyWith({
    String? id,
    String? name,
    String? colorHex,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteCollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
