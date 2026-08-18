// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResourceEntity _$ResourceEntityFromJson(Map<String, dynamic> json) =>
    _ResourceEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      englishName: json['english_name'] as String,
      languageCode: json['language_code'] as String,
      language: json['language'] as String,
      languageNative: json['language_native'] as String,
      type: $enumDecode(_$ResourceTypeEnumMap, json['type']),
      fullPath: json['full_path'] as String,
      fileName: json['file_name'] as String,
      isDownloaded: json['isDownloaded'] as bool? ?? false,
    );

Map<String, dynamic> _$ResourceEntityToJson(_ResourceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'english_name': instance.englishName,
      'language_code': instance.languageCode,
      'language': instance.language,
      'language_native': instance.languageNative,
      'type': _$ResourceTypeEnumMap[instance.type]!,
      'full_path': instance.fullPath,
      'file_name': instance.fileName,
      'isDownloaded': instance.isDownloaded,
    };

const _$ResourceTypeEnumMap = {
  ResourceType.tafsir: 'tafsir',
  ResourceType.simple: 'simple',
  ResourceType.word_by_word: 'word_by_word',
  ResourceType.with_footnote: 'with_footnote',
};
