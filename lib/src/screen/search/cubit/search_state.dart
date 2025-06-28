import "package:al_quran_v3/src/screen/search/models/search_catagory.dart";
import "package:al_quran_v3/src/screen/search/models/search_options.dart";

class SearchState {
  SearchFields searchFields;
  SearchCatagory searchCatagory;
  List<String> selectedTranslationBoxName;
  List<String> selectedTafsirBoxName;
  SearchState({
    required this.searchFields,
    required this.searchCatagory,
    required this.selectedTranslationBoxName,
    required this.selectedTafsirBoxName,
  });
  SearchState copyWith({
    SearchFields? searchFields,
    SearchCatagory? searchCatagory,
    List<String>? selectedTranslationBoxName,
    List<String>? selectedTafsirBoxName,
  }) {
    return SearchState(
      searchFields: searchFields ?? this.searchFields,
      searchCatagory: searchCatagory ?? this.searchCatagory,
      selectedTranslationBoxName:
          selectedTranslationBoxName ?? this.selectedTranslationBoxName,
      selectedTafsirBoxName:
          selectedTafsirBoxName ?? this.selectedTafsirBoxName,
    );
  }
}
