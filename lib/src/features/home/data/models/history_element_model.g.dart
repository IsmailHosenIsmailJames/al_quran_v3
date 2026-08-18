// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_element_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryElementModel _$HistoryElementModelFromJson(Map<String, dynamic> json) =>
    _HistoryElementModel(
      surahNumber: (json['surahNumber'] as num).toInt(),
      ayahNumber: (json['ayahNumber'] as num?)?.toInt(),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$HistoryElementModelToJson(
  _HistoryElementModel instance,
) => <String, dynamic>{
  'surahNumber': instance.surahNumber,
  'ayahNumber': instance.ayahNumber,
  'pageNumber': instance.pageNumber,
  'timestamp': instance.timestamp,
};
