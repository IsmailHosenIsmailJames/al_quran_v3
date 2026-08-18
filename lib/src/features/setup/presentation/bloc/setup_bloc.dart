import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/features/setup/domain/usecases/get_setup_resources_usecase.dart";
import "package:al_quran_v3/src/features/setup/domain/usecases/save_setup_preferences_usecase.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_event.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final GetSetupResourcesUseCase getSetupResourcesUseCase;
  final SaveSetupPreferencesUseCase saveSetupPreferencesUseCase;

  SetupBloc({
    required this.getSetupResourcesUseCase,
    required this.saveSetupPreferencesUseCase,
  }) : super(SetupState.initial()) {
    on<SetupInitRequested>(_onInitRequested);
    on<SetupLanguageChanged>(_onLanguageChanged);
    on<SetupTranslationSelected>(_onTranslationSelected);
    on<SetupTafsirSelected>(_onTafsirSelected);
  }

  Future<void> _onInitRequested(
    SetupInitRequested event,
    Emitter<SetupState> emit,
  ) async {
    emit(state.copyWith(status: SetupStatus.loading));
    try {
      final resources = await getSetupResourcesUseCase.execute();
      final langCode = event.currentLocalization.locale.languageCode;

      final stateWithResources = state.copyWith(
        allResources: resources,
        config: state.config.copyWith(appLanguageCode: langCode),
      );

      emit(_selectDefaultResourcesForLanguage(stateWithResources, langCode));
    } catch (e) {
      emit(
        state.copyWith(status: SetupStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onLanguageChanged(
    SetupLanguageChanged event,
    Emitter<SetupState> emit,
  ) {
    final langCode = event.localization.locale.languageCode;
    final updatedConfig = state.config.copyWith(appLanguageCode: langCode);
    final updatedState = state.copyWith(config: updatedConfig);

    emit(_selectDefaultResourcesForLanguage(updatedState, langCode));
  }

  SetupState _selectDefaultResourcesForLanguage(
    SetupState currentState,
    String langCode,
  ) {
    final langResources = currentState.allResources[langCode] ?? [];

    final selectableTranslations = langResources
        .where((e) => e.isTranslation)
        .toList();

    final selectableTafsirs = langResources.where((e) => e.isTafsir).toList();

    ResourceEntity? defaultTranslation = selectableTranslations.isNotEmpty
        ? selectableTranslations.first
        : currentState.config.selectedTranslation;

    ResourceEntity? defaultTafsir = selectableTafsirs.isNotEmpty
        ? selectableTafsirs.first
        : currentState.config.selectedTafsir;

    return currentState.copyWith(
      status: SetupStatus.loaded,
      selectableTranslations: selectableTranslations,
      selectableTafsirs: selectableTafsirs,
      config: currentState.config.copyWith(
        selectedTranslation: defaultTranslation,
        selectedTafsir: defaultTafsir,
      ),
    );
  }

  void _onTranslationSelected(
    SetupTranslationSelected event,
    Emitter<SetupState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(selectedTranslation: event.translation),
      ),
    );
  }

  void _onTafsirSelected(SetupTafsirSelected event, Emitter<SetupState> emit) {
    emit(
      state.copyWith(
        config: state.config.copyWith(selectedTafsir: event.tafsir),
      ),
    );
  }
}
