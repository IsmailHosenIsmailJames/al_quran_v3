import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'tajweed_rule_entity.freezed.dart';

@freezed
abstract class TajweedExampleEntity with _$TajweedExampleEntity {
  const factory TajweedExampleEntity({
    required String arabicText,
    required String transliteration,
    String? surahAyahRef,
    int? surahNumber,
    int? ayahNumber,
    int? wordIndex,
  }) = _TajweedExampleEntity;
}

@freezed
abstract class TajweedRuleEntity with _$TajweedRuleEntity {
  const factory TajweedRuleEntity({
    required String id,
    required String ruleKey,
    required String name,
    required String arabicName,
    required String description,
    required String howToPronounce,
    required List<TajweedExampleEntity> examples,
    required Color lightColor,
    required Color darkColor,
  }) = _TajweedRuleEntity;
}
