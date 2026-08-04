// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinned_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PinnedCollectionModel _$PinnedCollectionModelFromJson(
  Map<String, dynamic> json,
) => _PinnedCollectionModel(
  id: json['id'] as String,
  name: json['name'] as String,
  colorHex: json['colorHex'] as String? ?? "808080",
  pinned: (json['pinned'] as List<dynamic>)
      .map((e) => PinnedModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PinnedCollectionModelToJson(
  _PinnedCollectionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'colorHex': instance.colorHex,
  'pinned': instance.pinned.map((e) => e.toJson()).toList(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
