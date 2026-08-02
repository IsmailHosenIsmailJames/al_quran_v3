import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/book_search_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class BookSearchCubit extends Cubit<BookSearchState> {
  final Map<String, List<ResourceEntity>> allResources;

  BookSearchCubit({
    required bool isTafsir,
    required this.allResources,
  }) : super(
          BookSearchState.initial(
            isTafsir: isTafsir,
            allResources: allResources,
          ),
        );

  void updateQuery(String query) {
    emit(state.copyWithQuery(query, allResources));
  }
}
