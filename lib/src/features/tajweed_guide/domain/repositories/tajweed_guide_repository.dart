import "../entities/tajweed_rule_entity.dart";

abstract class TajweedGuideRepository {
  List<TajweedRuleEntity> getTajweedRules();
}
