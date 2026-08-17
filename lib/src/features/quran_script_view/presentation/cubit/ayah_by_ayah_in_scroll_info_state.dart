import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'ayah_by_ayah_in_scroll_info_state.freezed.dart';

@freezed
abstract class AyahByAyahInScrollInfoState with _$AyahByAyahInScrollInfoState {
  const factory AyahByAyahInScrollInfoState({
    SurahInfoModel? surahInfoModel,
    List<String>? expandedForWordByWord,
    @Default(true) bool isAyahByAyah,
    List<int>? pageByPageList,
    dynamic dropdownAyahKey,
  }) = _AyahByAyahInScrollInfoState;

  static Map toMap(AyahByAyahInScrollInfoState state) {
    return {
      "surahInfoModel": state.surahInfoModel?.toMap(),
      "expandedForWordByWord": state.expandedForWordByWord,
      "isAyahByAyah": state.isAyahByAyah,
      "pageByPageList": state.pageByPageList,
      "dropdownAyahKey": state.dropdownAyahKey,
    };
  }
}
