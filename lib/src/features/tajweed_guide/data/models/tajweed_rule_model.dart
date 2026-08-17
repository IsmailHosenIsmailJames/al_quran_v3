import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "../../domain/entities/tajweed_rule_entity.dart";

part 'tajweed_rule_model.freezed.dart';

@freezed
abstract class TajweedExampleModel with _$TajweedExampleModel {
  const TajweedExampleModel._();

  const factory TajweedExampleModel({
    required String arabicText,
    required String transliteration,
    String? surahAyahRef,
    int? surahNumber,
    int? ayahNumber,
    int? wordIndex,
  }) = _TajweedExampleModel;

  factory TajweedExampleModel.fromEntity(TajweedExampleEntity entity) {
    return TajweedExampleModel(
      arabicText: entity.arabicText,
      transliteration: entity.transliteration,
      surahAyahRef: entity.surahAyahRef,
      surahNumber: entity.surahNumber,
      ayahNumber: entity.ayahNumber,
      wordIndex: entity.wordIndex,
    );
  }

  TajweedExampleEntity toEntity() {
    return TajweedExampleEntity(
      arabicText: arabicText,
      transliteration: transliteration,
      surahAyahRef: surahAyahRef,
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      wordIndex: wordIndex,
    );
  }
}

@freezed
abstract class TajweedRuleModel with _$TajweedRuleModel {
  const TajweedRuleModel._();

  const factory TajweedRuleModel({
    required String id,
    required String ruleKey,
    required String name,
    required String arabicName,
    required String description,
    required String howToPronounce,
    required List<TajweedExampleModel> examples,
    required Color lightColor,
    required Color darkColor,
  }) = _TajweedRuleModel;

  factory TajweedRuleModel.fromEntity(TajweedRuleEntity entity) {
    return TajweedRuleModel(
      id: entity.id,
      ruleKey: entity.ruleKey,
      name: entity.name,
      arabicName: entity.arabicName,
      description: entity.description,
      howToPronounce: entity.howToPronounce,
      examples: entity.examples.map(TajweedExampleModel.fromEntity).toList(),
      lightColor: entity.lightColor,
      darkColor: entity.darkColor,
    );
  }

  TajweedRuleEntity toEntity() {
    return TajweedRuleEntity(
      id: id,
      ruleKey: ruleKey,
      name: name,
      arabicName: arabicName,
      description: description,
      howToPronounce: howToPronounce,
      examples: examples.map((e) => e.toEntity()).toList(),
      lightColor: lightColor,
      darkColor: darkColor,
    );
  }
}
