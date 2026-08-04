// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReciterInfoModel _$ReciterInfoModelFromJson(Map<String, dynamic> json) =>
    _ReciterInfoModel(
      link: json['link'] as String,
      name: json['name'] as String,
      supportWordSegmentation: json['supportWordSegmentation'] as bool?,
      source: json['source'] as String?,
      style: json['style'] as String?,
      img: json['img'] as String?,
      bio: json['bio'] as String?,
      segmentsUrl: json['segments_url'] as String?,
      isDownloading: json['isDownloading'] as bool? ?? false,
      showAyahHighlight: json['showAyahHighlight'] as String?,
    );

Map<String, dynamic> _$ReciterInfoModelToJson(_ReciterInfoModel instance) =>
    <String, dynamic>{
      'link': instance.link,
      'name': instance.name,
      'supportWordSegmentation': instance.supportWordSegmentation,
      'source': instance.source,
      'style': instance.style,
      'img': instance.img,
      'bio': instance.bio,
      'segments_url': instance.segmentsUrl,
      'isDownloading': instance.isDownloading,
      'showAyahHighlight': instance.showAyahHighlight,
    };
