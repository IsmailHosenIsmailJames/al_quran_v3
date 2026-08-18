// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resources_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResourcesModel _$ResourcesModelFromJson(Map<String, dynamic> json) =>
    _ResourcesModel(
      language: json['language'] as String? ?? '',
      languageNative: json['language_native'] as String? ?? '',
      languageCode: json['language_code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      englishName: json['english_name'] as String? ?? '',
      fileName: json['file_name'] as String? ?? '',
      fullPath: json['full_path'] as String? ?? '',
      type:
          $enumDecodeNullable(_$ResourceTypeEnumMap, json['type']) ??
          ResourceType.simple,
      isTajweed: json['is_tajweed'] as bool? ?? false,
    );

Map<String, dynamic> _$ResourcesModelToJson(_ResourcesModel instance) =>
    <String, dynamic>{
      'language': instance.language,
      'language_native': instance.languageNative,
      'language_code': instance.languageCode,
      'name': instance.name,
      'english_name': instance.englishName,
      'file_name': instance.fileName,
      'full_path': instance.fullPath,
      'type': _$ResourceTypeEnumMap[instance.type]!,
      'is_tajweed': instance.isTajweed,
    };

const _$ResourceTypeEnumMap = {
  ResourceType.tafsir: 'tafsir',
  ResourceType.simple: 'simple',
  ResourceType.word_by_word: 'word_by_word',
  ResourceType.with_footnote: 'with_footnote',
};
