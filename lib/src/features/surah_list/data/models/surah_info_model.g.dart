// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurahInfoModel _$SurahInfoModelFromJson(Map<String, dynamic> json) =>
    _SurahInfoModel(
      id: (json['id'] as num).toInt(),
      revelationOrder: (json['ro'] as num).toInt(),
      revelationPlace: json['rp'] as String,
      versesCount: (json['vc'] as num).toInt(),
      pagesRange: json['pr'] as String,
      noBismillah: json['noBismillah'] as bool? ?? false,
    );

Map<String, dynamic> _$SurahInfoModelToJson(_SurahInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ro': instance.revelationOrder,
      'rp': instance.revelationPlace,
      'vc': instance.versesCount,
      'pr': instance.pagesRange,
      'noBismillah': instance.noBismillah,
    };
