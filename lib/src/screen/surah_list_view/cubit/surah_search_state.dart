import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";

class SurahSearchState {
  final String query;
  final List<SurahInfoModel> filteredSurahs;

  const SurahSearchState({
    this.query = "",
    this.filteredSurahs = const [],
  });

  SurahSearchState copyWith({
    String? query,
    List<SurahInfoModel>? filteredSurahs,
  }) {
    return SurahSearchState(
      query: query ?? this.query,
      filteredSurahs: filteredSurahs ?? this.filteredSurahs,
    );
  }
}
