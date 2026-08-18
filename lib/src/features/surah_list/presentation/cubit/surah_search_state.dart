import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart';

part 'surah_search_state.freezed.dart';
part 'surah_search_state.g.dart';

@freezed
abstract class SurahSearchState with _$SurahSearchState {
  @JsonSerializable(explicitToJson: true)
  const factory SurahSearchState({
    @Default("") String query,
    @Default([]) List<SurahInfoModel> filteredSurahs,
  }) = _SurahSearchState;

  factory SurahSearchState.fromJson(Map<String, dynamic> json) =>
      _$SurahSearchStateFromJson(json);
}
