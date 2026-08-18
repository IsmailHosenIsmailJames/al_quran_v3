// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juz_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JuzInfoModel _$JuzInfoModelFromJson(Map<String, dynamic> json) =>
    _JuzInfoModel(
      juzNumber: (json['jn'] as num).toInt(),
      versesCount: (json['vc'] as num).toInt(),
      firstVerseKey: json['fvk'] as String,
      lastVerseKey: json['lvk'] as String,
      verseMapping: Map<String, String>.from(json['vm'] as Map),
    );

Map<String, dynamic> _$JuzInfoModelToJson(_JuzInfoModel instance) =>
    <String, dynamic>{
      'jn': instance.juzNumber,
      'vc': instance.versesCount,
      'fvk': instance.firstVerseKey,
      'lvk': instance.lastVerseKey,
      'vm': instance.verseMapping,
    };
