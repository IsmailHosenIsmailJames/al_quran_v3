// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinned_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PinnedModel _$PinnedModelFromJson(Map<String, dynamic> json) => _PinnedModel(
  id: json['id'] as String,
  ayahKey: json['ayahKey'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PinnedModelToJson(_PinnedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ayahKey': instance.ayahKey,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
