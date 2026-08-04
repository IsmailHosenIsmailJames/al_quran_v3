import "package:flutter/material.dart";

class TajweedExampleEntity {
  final String arabicText;
  final String transliteration;
  final String? surahAyahRef;
  final int? surahNumber;
  final int? ayahNumber;
  final int? wordIndex;

  const TajweedExampleEntity({
    required this.arabicText,
    required this.transliteration,
    this.surahAyahRef,
    this.surahNumber,
    this.ayahNumber,
    this.wordIndex,
  });
}

class TajweedRuleEntity {
  final String id;
  final String ruleKey;
  final String name;
  final String arabicName;
  final String description;
  final String howToPronounce;
  final List<TajweedExampleEntity> examples;
  final Color lightColor;
  final Color darkColor;

  const TajweedRuleEntity({
    required this.id,
    required this.ruleKey,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.howToPronounce,
    required this.examples,
    required this.lightColor,
    required this.darkColor,
  });
}
