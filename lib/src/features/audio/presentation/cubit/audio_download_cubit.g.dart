// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_download_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioDownloadState _$AudioDownloadStateFromJson(Map<String, dynamic> json) =>
    _AudioDownloadState(
      surahNumber: (json['surahNumber'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      isDownloading: json['isDownloading'] as bool? ?? false,
    );

Map<String, dynamic> _$AudioDownloadStateToJson(_AudioDownloadState instance) =>
    <String, dynamic>{
      'surahNumber': instance.surahNumber,
      'progress': instance.progress,
      'isDownloading': instance.isDownloading,
    };
