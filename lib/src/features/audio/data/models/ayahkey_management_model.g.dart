// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayahkey_management_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AyahKeyManagement _$AyahKeyManagementFromJson(Map<String, dynamic> json) =>
    _AyahKeyManagement(
      start: json['start'] as String,
      end: json['end'] as String,
      current: json['current'] as String,
      ayahList: (json['ayahList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastScrolledPageNumber: (json['lastScrolledPageNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AyahKeyManagementToJson(_AyahKeyManagement instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'current': instance.current,
      'ayahList': instance.ayahList,
      'lastScrolledPageNumber': instance.lastScrolledPageNumber,
    };
