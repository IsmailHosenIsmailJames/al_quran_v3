import "package:injectable/injectable.dart";
import "../entities/tajweed_rule_entity.dart";
import "../repositories/tajweed_guide_repository.dart";

@lazySingleton
class GetTajweedRulesUseCase {
  final TajweedGuideRepository repository;

  GetTajweedRulesUseCase(this.repository);

  List<TajweedRuleEntity> call() {
    return repository.getTajweedRules();
  }
}
