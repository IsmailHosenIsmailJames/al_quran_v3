// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segments_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SegmentsInfoModel _$SegmentsInfoModelFromJson(Map<String, dynamic> json) =>
    _SegmentsInfoModel(
      surahNumber: (json['surah_number'] as num?)?.toInt(),
      ayahNumber: (json['ayah_number'] as num?)?.toInt(),
      audioUrl: json['audio_url'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      segments: (json['segments'] as List<dynamic>?)
          ?.map(
            (e) => (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
          )
          .toList(),
    );

Map<String, dynamic> _$SegmentsInfoModelToJson(_SegmentsInfoModel instance) =>
    <String, dynamic>{
      'surah_number': instance.surahNumber,
      'ayah_number': instance.ayahNumber,
      'audio_url': instance.audioUrl,
      'duration': instance.duration,
      'segments': instance.segments,
    };
