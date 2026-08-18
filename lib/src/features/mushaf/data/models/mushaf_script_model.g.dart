// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mushaf_script_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MushafScriptPageModel _$MushafScriptPageModelFromJson(
  Map<String, dynamic> json,
) => _MushafScriptPageModel(
  pageNumber: (json['page_number'] as num).toInt(),
  lines: (json['lines'] as List<dynamic>)
      .map((e) => MushafLine.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MushafScriptPageModelToJson(
  _MushafScriptPageModel instance,
) => <String, dynamic>{
  'page_number': instance.pageNumber,
  'lines': instance.lines.map((e) => e.toJson()).toList(),
};

_MushafLine _$MushafLineFromJson(Map<String, dynamic> json) => _MushafLine(
  lineNumber: (json['line_number'] as num).toInt(),
  lineType: $enumDecode(_$LineTypeEnumMap, json['line_type']),
  isCentered: json['is_centered'] as bool,
  surahNumber: json['surah_number'],
  content: json['content'] as String,
  firstWordId: (json['first_word_id'] as num?)?.toInt(),
  lastWordId: (json['last_word_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MushafLineToJson(_MushafLine instance) =>
    <String, dynamic>{
      'line_number': instance.lineNumber,
      'line_type': _$LineTypeEnumMap[instance.lineType]!,
      'is_centered': instance.isCentered,
      'surah_number': instance.surahNumber,
      'content': instance.content,
      'first_word_id': instance.firstWordId,
      'last_word_id': instance.lastWordId,
    };

const _$LineTypeEnumMap = {
  LineType.ayah: 'ayah',
  LineType.basmallah: 'basmallah',
  LineType.surahName: 'surah_name',
};
