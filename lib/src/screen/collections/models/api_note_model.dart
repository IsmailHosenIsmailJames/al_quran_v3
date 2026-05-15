import 'dart:convert';

/// Model representing a note as returned by the Quran Foundation API.
///
/// This is separate from the local [NoteModel] to cleanly map between
/// the flat API structure and the local folder-based structure.
class ApiNoteModel {
  final String id;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? source;
  final List<String>? ranges;
  final List<ApiAttachedEntity>? attachedEntities;

  ApiNoteModel({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    this.source,
    this.ranges,
    this.attachedEntities,
  });

  factory ApiNoteModel.fromJson(Map<String, dynamic> json) {
    return ApiNoteModel(
      id: json['id'] as String,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      source: json['source'] as String?,
      ranges: json['ranges'] != null
          ? List<String>.from(json['ranges'] as List)
          : null,
      attachedEntities: json['attachedEntities'] != null
          ? (json['attachedEntities'] as List)
              .map((e) =>
                  ApiAttachedEntity.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (source != null) 'source': source,
      if (ranges != null) 'ranges': ranges,
      if (attachedEntities != null)
        'attachedEntities': attachedEntities!.map((e) => e.toJson()).toList(),
    };
  }

  String toJsonString() => json.encode(toJson());

  factory ApiNoteModel.fromJsonString(String jsonString) =>
      ApiNoteModel.fromJson(json.decode(jsonString) as Map<String, dynamic>);
}

class ApiAttachedEntity {
  final String entityId;
  final String entityType;
  final Map<String, dynamic>? entityMetadata;

  ApiAttachedEntity({
    required this.entityId,
    required this.entityType,
    this.entityMetadata,
  });

  factory ApiAttachedEntity.fromJson(Map<String, dynamic> json) {
    return ApiAttachedEntity(
      entityId: json['entityId'] as String,
      entityType: json['entityType'] as String,
      entityMetadata: json['entityMetadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entityId': entityId,
      'entityType': entityType,
      if (entityMetadata != null) 'entityMetadata': entityMetadata,
    };
  }
}
