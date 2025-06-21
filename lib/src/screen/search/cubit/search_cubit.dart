import "package:al_quran_v3/src/screen/search/cubit/search_state.dart";
import "package:al_quran_v3/src/screen/search/models/search_options.dart";
import "package:bloc/bloc.dart";
import "package:hive_flutter/hive_flutter.dart";

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
    : super(
        SearchState(
          searchFields: SearchFieldsExtension.fromString(
            Hive.box(
              "user",
            ).get("defaultSearchField", defaultValue: SearchFields.quran.name),
          ),
        ),
      );

  void changeSearchField(SearchFields searchFields) {
    Hive.box("user").put("defaultSearchField", searchFields.name);
    emit(SearchState(searchFields: searchFields));
  }
}
