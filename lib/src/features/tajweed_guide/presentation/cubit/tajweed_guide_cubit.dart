import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";
import "../../domain/usecases/get_tajweed_rules_usecase.dart";
import "tajweed_guide_state.dart";

@injectable
class TajweedGuideCubit extends Cubit<TajweedGuideState> {
  final GetTajweedRulesUseCase getTajweedRulesUseCase;

  TajweedGuideCubit({required this.getTajweedRulesUseCase})
      : super(const TajweedGuideState.initial());

  void loadTajweedRules() {
    emit(const TajweedGuideState.loading());
    try {
      final rules = getTajweedRulesUseCase();
      emit(TajweedGuideState.loaded(rules: rules, filteredRules: rules));
    } catch (e) {
      emit(TajweedGuideState.error(e.toString()));
    }
  }

  void filterRules(String query) {
    if (state is TajweedGuideLoaded) {
      final currentState = state as TajweedGuideLoaded;
      if (query.trim().isEmpty) {
        emit(TajweedGuideState.loaded(
          rules: currentState.rules,
          filteredRules: currentState.rules,
          searchQuery: "",
        ));
      } else {
        final lower = query.toLowerCase().trim();
        final filtered = currentState.rules.where((rule) {
          return rule.name.toLowerCase().contains(lower) ||
              rule.arabicName.contains(query) ||
              rule.description.toLowerCase().contains(lower) ||
              rule.howToPronounce.toLowerCase().contains(lower);
        }).toList();

        emit(TajweedGuideState.loaded(
          rules: currentState.rules,
          filteredRules: filtered,
          searchQuery: query,
        ));
      }
    }
  }
}
