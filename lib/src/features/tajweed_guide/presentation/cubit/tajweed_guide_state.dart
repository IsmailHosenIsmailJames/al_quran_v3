import "../../domain/entities/tajweed_rule_entity.dart";

abstract class TajweedGuideState {
  const TajweedGuideState();
}

class TajweedGuideInitial extends TajweedGuideState {
  const TajweedGuideInitial();
}

class TajweedGuideLoading extends TajweedGuideState {
  const TajweedGuideLoading();
}

class TajweedGuideLoaded extends TajweedGuideState {
  final List<TajweedRuleEntity> rules;
  final List<TajweedRuleEntity> filteredRules;
  final String searchQuery;

  const TajweedGuideLoaded({
    required this.rules,
    required this.filteredRules,
    this.searchQuery = "",
  });
}

class TajweedGuideError extends TajweedGuideState {
  final String message;

  const TajweedGuideError(this.message);
}
