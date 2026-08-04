// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_info_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurahInfoDetailEntity _$SurahInfoDetailEntityFromJson(
  Map<String, dynamic> json,
) => _SurahInfoDetailEntity(
  surahId: (json['surahId'] as num).toInt(),
  title: json['title'] as String,
  htmlContent: json['htmlContent'] as String,
);

Map<String, dynamic> _$SurahInfoDetailEntityToJson(
  _SurahInfoDetailEntity instance,
) => <String, dynamic>{
  'surahId': instance.surahId,
  'title': instance.title,
  'htmlContent': instance.htmlContent,
};
