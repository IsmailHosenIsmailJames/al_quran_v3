import "../../domain/entities/tajweed_rule_entity.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'tajweed_guide_state.freezed.dart';

@freezed
abstract class TajweedGuideState with _$TajweedGuideState {
  const factory TajweedGuideState.initial() = TajweedGuideInitial;
  const factory TajweedGuideState.loading() = TajweedGuideLoading;
  const factory TajweedGuideState.loaded({
    required List<TajweedRuleEntity> rules,
    required List<TajweedRuleEntity> filteredRules,
    @Default("") String searchQuery,
  }) = TajweedGuideLoaded;
  const factory TajweedGuideState.error(String message) = TajweedGuideError;
}
