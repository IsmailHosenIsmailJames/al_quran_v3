// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppInfoEntity _$AppInfoEntityFromJson(Map<String, dynamic> json) =>
    _AppInfoEntity(
      name: json['name'] as String,
      version: json['version'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AppInfoEntityToJson(_AppInfoEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'description': instance.description,
    };
