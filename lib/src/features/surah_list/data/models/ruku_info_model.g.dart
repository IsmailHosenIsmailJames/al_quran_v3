// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruku_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RukuInfoModel _$RukuInfoModelFromJson(Map<String, dynamic> json) =>
    _RukuInfoModel(
      rukuNumber: (json['rn'] as num).toInt(),
      surahRukuNumber: (json['srn'] as num).toInt(),
      versesCount: (json['vc'] as num).toInt(),
      firstVerseKey: json['fvk'] as String,
      lastVerseKey: json['lvk'] as String,
      verseMapping: Map<String, String>.from(json['vm'] as Map),
    );

Map<String, dynamic> _$RukuInfoModelToJson(_RukuInfoModel instance) =>
    <String, dynamic>{
      'rn': instance.rukuNumber,
      'srn': instance.surahRukuNumber,
      'vc': instance.versesCount,
      'fvk': instance.firstVerseKey,
      'lvk': instance.lastVerseKey,
      'vm': instance.verseMapping,
    };
