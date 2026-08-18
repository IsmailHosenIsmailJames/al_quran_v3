// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_element_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryElementEntity _$HistoryElementEntityFromJson(
  Map<String, dynamic> json,
) => _HistoryElementEntity(
  surahNumber: (json['surahNumber'] as num).toInt(),
  ayahNumber: (json['ayahNumber'] as num?)?.toInt(),
  pageNumber: (json['pageNumber'] as num?)?.toInt(),
  timestamp: (json['timestamp'] as num).toInt(),
);

Map<String, dynamic> _$HistoryElementEntityToJson(
  _HistoryElementEntity instance,
) => <String, dynamic>{
  'surahNumber': instance.surahNumber,
  'ayahNumber': instance.ayahNumber,
  'pageNumber': instance.pageNumber,
  'timestamp': instance.timestamp,
};
