// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hizb_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HizbModel _$HizbModelFromJson(Map<String, dynamic> json) => _HizbModel(
  hizbNumber: (json['hn'] as num).toInt(),
  versesCount: (json['vc'] as num).toInt(),
  firstVerseKey: json['fvk'] as String,
  lastVerseKey: json['lvk'] as String,
  verseMapping: Map<String, String>.from(json['vm'] as Map),
);

Map<String, dynamic> _$HizbModelToJson(_HizbModel instance) =>
    <String, dynamic>{
      'hn': instance.hizbNumber,
      'vc': instance.versesCount,
      'fvk': instance.firstVerseKey,
      'lvk': instance.lastVerseKey,
      'vm': instance.verseMapping,
    };
