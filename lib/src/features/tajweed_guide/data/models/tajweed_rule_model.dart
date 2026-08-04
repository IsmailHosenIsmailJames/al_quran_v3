import "../../domain/entities/tajweed_rule_entity.dart";

class TajweedExampleModel extends TajweedExampleEntity {
  const TajweedExampleModel({
    required super.arabicText,
    required super.transliteration,
    super.surahAyahRef,
    super.surahNumber,
    super.ayahNumber,
    super.wordIndex,
  });
}

class TajweedRuleModel extends TajweedRuleEntity {
  const TajweedRuleModel({
    required super.id,
    required super.ruleKey,
    required super.name,
    required super.arabicName,
    required super.description,
    required super.howToPronounce,
    required super.examples,
    required super.lightColor,
    required super.darkColor,
  });
}
