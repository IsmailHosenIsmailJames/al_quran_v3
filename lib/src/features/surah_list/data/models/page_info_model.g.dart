// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageInfoModel _$PageInfoModelFromJson(Map<String, dynamic> json) =>
    _PageInfoModel(
      start: (json['s'] as num).toInt(),
      end: (json['e'] as num).toInt(),
      surahNumber: (json['sn'] as num).toInt(),
      pageNumber: (json['i'] as num).toInt(),
    );

Map<String, dynamic> _$PageInfoModelToJson(_PageInfoModel instance) =>
    <String, dynamic>{
      's': instance.start,
      'e': instance.end,
      'sn': instance.surahNumber,
      'i': instance.pageNumber,
    };
