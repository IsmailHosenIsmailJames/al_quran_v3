// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_access_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuickAccessModel _$QuickAccessModelFromJson(Map<String, dynamic> json) =>
    _QuickAccessModel(
      surahNumber: (json['surahNumber'] as num).toInt(),
      scrollIndex: (json['scrollIndex'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$QuickAccessModelToJson(_QuickAccessModel instance) =>
    <String, dynamic>{
      'surahNumber': instance.surahNumber,
      'scrollIndex': instance.scrollIndex,
      'createdAt': instance.createdAt.toIso8601String(),
    };
