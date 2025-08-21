import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/screen/search/cubit/search_state.dart";
import "package:al_quran_v3/src/screen/search/models/search_catagory.dart";
import "package:al_quran_v3/src/screen/search/models/search_options.dart";
import "package:al_quran_v3/src/screen/search/models/search_result_model.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:bloc/bloc.dart";
import "package:hive_flutter/hive_flutter.dart";

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
    : super(
        SearchState(
          searchFields: SearchFieldsExtension.fromString(
            Hive.box("user").get(
              "defaultSearchField",
              defaultValue: SearchFields.translation.name,
            ),
          ),
          searchCatagory: SearchCatagoryExtension.fromString(
            Hive.box("user").get(
              "defaultSearchCatagory",
              defaultValue: SearchCatagory.normal.name,
            ),
          ),
          selectedTafsirBoxName: [
            QuranTafsirFunction.getSelectedTafsirBoxName()!,
          ],
          selectedTranslationBoxName: [
            QuranTranslationFunction.getSelectedTranslationBoxName()!,
          ],
        ),
      );

  void changeSearchField(SearchFields searchFields) {
    Hive.box("user").put("defaultSearchField", searchFields.name);
    emit(state.copyWith(searchFields: searchFields));
  }

  void changeSearchCatagory(SearchCatagory searchCatagory) {
    Hive.box("user").put("defaultSearchCatagory", searchCatagory.name);
    emit(state.copyWith(searchCatagory: searchCatagory));
  }

  void addTranslationBoxName(TranslationBookModel translationBook) {
    String boxName = QuranTranslationFunction.getTranslationBoxName(
      translationBook: translationBook,
    );
    if (!state.selectedTranslationBoxName.contains(boxName)) {
      state.selectedTranslationBoxName.add(boxName);
      emit(
        state.copyWith(
          selectedTranslationBoxName: state.selectedTranslationBoxName,
        ),
      );
    }
  }

  void removeTranslationBoxName(TranslationBookModel translationBook) {
    String boxName = QuranTranslationFunction.getTranslationBoxName(
      translationBook: translationBook,
    );
    if (state.selectedTranslationBoxName.contains(boxName)) {
      state.selectedTranslationBoxName.remove(boxName);
      emit(
        state.copyWith(
          selectedTranslationBoxName: state.selectedTranslationBoxName,
        ),
      );
    }
  }

  void addTafsirBoxName(TafsirBookModel tafsirBook) {
    String boxName = QuranTafsirFunction.getTafsirBoxName(
      tafsirBook: tafsirBook,
    );
    if (!state.selectedTafsirBoxName.contains(boxName)) {
      state.selectedTafsirBoxName.add(boxName);
      emit(state.copyWith(selectedTafsirBoxName: state.selectedTafsirBoxName));
    }
  }

  void removeTafsirBoxName(TafsirBookModel tafsirBook) {
    String boxName = QuranTafsirFunction.getTafsirBoxName(
      tafsirBook: tafsirBook,
    );
    if (state.selectedTafsirBoxName.contains(boxName)) {
      state.selectedTafsirBoxName.remove(boxName);
      emit(state.copyWith(selectedTafsirBoxName: state.selectedTafsirBoxName));
    }
  }

  Future<List<SearchResultModel>> search({
    required String searchQuery,
    required QuranScriptType scriptType,
  }) async {
    return [];
  }
}
