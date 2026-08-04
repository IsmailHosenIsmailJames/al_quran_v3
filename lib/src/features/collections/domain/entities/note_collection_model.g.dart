// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteCollectionModel _$NoteCollectionModelFromJson(Map<String, dynamic> json) =>
    _NoteCollectionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      colorHex: json['colorHex'] as String? ?? "808080",
      notes: (json['notes'] as List<dynamic>)
          .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$NoteCollectionModelToJson(
  _NoteCollectionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'colorHex': instance.colorHex,
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
