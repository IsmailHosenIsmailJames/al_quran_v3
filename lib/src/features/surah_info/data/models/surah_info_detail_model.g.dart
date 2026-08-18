// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah_info_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurahInfoDetailModel _$SurahInfoDetailModelFromJson(
  Map<String, dynamic> json,
) => _SurahInfoDetailModel(
  surahId: (json['surahId'] as num).toInt(),
  title: json['title'] as String,
  htmlContent: json['htmlContent'] as String,
);

Map<String, dynamic> _$SurahInfoDetailModelToJson(
  _SurahInfoDetailModel instance,
) => <String, dynamic>{
  'surahId': instance.surahId,
  'title': instance.title,
  'htmlContent': instance.htmlContent,
};
