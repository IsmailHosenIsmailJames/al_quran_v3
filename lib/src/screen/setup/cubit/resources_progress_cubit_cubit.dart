import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/tafsir_resources.dart";
import "package:al_quran_v3/src/resources/quran_resources/translation_resources.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:al_quran_v3/src/resources/translation/languages.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ResourcesProcceessCubit extends Cubit<ResourcesProcceessCubitState> {
  ResourcesProcceessCubit()
    : super(
        ResourcesProcceessCubitState(
          allResources:
              (tafsirResources.values.toList() +
                      translationResources.values.toList())
                  .expand((e) => e)
                  .map((e) => ResourcesModel.fromMap(e))
                  .toList()
                  .groupBy((element) => element.languageCode),
        ),
      );

  void updateProgress(double? percentage, String processName) {
    emit(state.copyWith(percentage: percentage, processName: processName));
  }

  void success() {
    emit(state.copyWith(isSuccess: true));
  }

  void failure(String errorMessage) {
    emit(state.copyWith(isSuccess: false, errorMessage: errorMessage));
  }

  void onProcess() {
    emit(state.copyWith(onProcess: true));
  }

  void changeTranslationBook(ResourcesModel? selectedTranslationResources) {
    emit(
      state.copyWith(
        selectedTranslationResources: selectedTranslationResources,
      ),
    );
  }

  void changeAppLanguage(BuildContext context, MyAppLocalization localeInfo) {
    emit(state.copyWith(appLanguageCode: localeInfo.locale.languageCode));
    context.read<LanguageCubit>().changeLanguage(localeInfo);
    Map<String, List<ResourcesModel>> allResources = state.allResources;
    List<ResourcesModel> selectableTafsirBook = [];
    List<ResourcesModel> selectableTranslationBook = [];
    if (allResources.keys.contains(state.appLanguageCode)) {
      selectableTranslationBook =
          state.allResources[state.appLanguageCode]
              ?.where(
                (element) =>
                    element.type != ResourceType.tafsir &&
                    element.type != ResourceType.word_by_word,
              )
              .toList() ??
          [];
      if (selectableTranslationBook.isNotEmpty) {
        changeTranslationBook(selectableTranslationBook.first);
        changeSelectabeResources(selectableTranslationBook, null);
      }
    }

    if (allResources.keys.contains(state.appLanguageCode)) {
      selectableTafsirBook =
          allResources[state.appLanguageCode]
              ?.where((element) => element.type == ResourceType.tafsir)
              .toList() ??
          [];
      if (selectableTafsirBook.isNotEmpty) {
        changeTafsirBook(selectableTafsirBook.first);
        changeSelectabeResources(null, selectableTafsirBook);
      }
    }
  }

  void changeSelectabeResources(
    List<ResourcesModel>? translation,
    List<ResourcesModel>? tafsir,
  ) {
    emit(
      state.copyWith(
        selectableTranslationResources: translation,
        selectableTafsirResources: tafsir,
      ),
    );
  }

  void changeTafsirBook(ResourcesModel? selectedTafsirResources) {
    emit(state.copyWith(selectedTafsirResources: selectedTafsirResources));
  }

  bool doesHaveFootNote(String languageCode) {
    return state.allResources[languageCode]?.any(
          (element) => element.type == ResourceType.with_footnote,
        ) ??
        false;
  }

  bool doesHaveWordByWordTranslation(String languageCode) {
    return state.allResources[languageCode]?.any(
          (element) => element.type == ResourceType.word_by_word,
        ) ??
        false;
  }

  bool doesHaveTafsirSupport(String languageCode) {
    return state.allResources[languageCode]?.any(
          (element) => element.type == ResourceType.tafsir,
        ) ??
        false;
  }
}
