import 'dart:convert';

/// Model representing a bookmark as returned by the Quran Foundation API.
class ApiBookmarkModel {
  final String id;
  final String key; // This is the verseKey e.g. "1:1" or surahNumber
  final String type; // e.g. "ayah"
  final int? verseNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  ApiBookmarkModel({
    required this.id,
    required this.key,
    required this.type,
    this.verseNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApiBookmarkModel.fromJson(Map<String, dynamic> json) {
    return ApiBookmarkModel(
      id: json['id'] as String,
      key: json['key'] as String,
      type: json['type'] as String,
      verseNumber: json['verseNumber'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'type': type,
      if (verseNumber != null) 'verseNumber': verseNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String toJsonString() => json.encode(toJson());
}
