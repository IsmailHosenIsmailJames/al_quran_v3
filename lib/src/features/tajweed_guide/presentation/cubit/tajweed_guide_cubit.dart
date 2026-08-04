import "package:flutter_bloc/flutter_bloc.dart";
import "../../domain/usecases/get_tajweed_rules_usecase.dart";
import "tajweed_guide_state.dart";

class TajweedGuideCubit extends Cubit<TajweedGuideState> {
  final GetTajweedRulesUseCase getTajweedRulesUseCase;

  TajweedGuideCubit({required this.getTajweedRulesUseCase})
      : super(const TajweedGuideInitial());

  void loadTajweedRules() {
    emit(const TajweedGuideLoading());
    try {
      final rules = getTajweedRulesUseCase();
      emit(TajweedGuideLoaded(rules: rules, filteredRules: rules));
    } catch (e) {
      emit(TajweedGuideError(e.toString()));
    }
  }

  void filterRules(String query) {
    if (state is TajweedGuideLoaded) {
      final currentState = state as TajweedGuideLoaded;
      if (query.trim().isEmpty) {
        emit(TajweedGuideLoaded(
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

        emit(TajweedGuideLoaded(
          rules: currentState.rules,
          filteredRules: filtered,
          searchQuery: query,
        ));
      }
    }
  }
}
