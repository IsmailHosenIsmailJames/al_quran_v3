// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SetupConfig _$SetupConfigFromJson(Map<String, dynamic> json) => _SetupConfig(
  appLanguageCode: json['appLanguageCode'] as String,
  selectedTranslation: json['selectedTranslation'] == null
      ? null
      : ResourceEntity.fromJson(
          json['selectedTranslation'] as Map<String, dynamic>,
        ),
  selectedTafsir: json['selectedTafsir'] == null
      ? null
      : ResourceEntity.fromJson(json['selectedTafsir'] as Map<String, dynamic>),
  isSetupComplete: json['isSetupComplete'] as bool? ?? false,
);

Map<String, dynamic> _$SetupConfigToJson(_SetupConfig instance) =>
    <String, dynamic>{
      'appLanguageCode': instance.appLanguageCode,
      'selectedTranslation': instance.selectedTranslation,
      'selectedTafsir': instance.selectedTafsir,
      'isSetupComplete': instance.isSetupComplete,
    };
