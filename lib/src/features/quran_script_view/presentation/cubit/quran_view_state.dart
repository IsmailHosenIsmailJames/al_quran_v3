import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'quran_view_state.freezed.dart';

@freezed
abstract class QuranViewState with _$QuranViewState {
  const factory QuranViewState({
    required String ayahKey,
    required double fontSize,
    required double lineHeight,
    required QuranScriptType quranScriptType,
    required double translationFontSize,
    required bool useTajweedOnUthmani,
    required bool useTajweedOnIndopak,
    @Default("QPC_Hafs") String uthmaniFontName,
    @Default("AlQuranNeov5x1") String indopakFontName,
    @Default(false) bool circleJojom,
    @Default(false) bool hideFootnote,
    @Default(false) bool hideWordByWord,
    @Default(false) bool hideTranslation,
    @Default(false) bool hideToolbar,
    @Default(false) bool hideQuranAyah,
    @Default(false) bool alwaysOpenWordByWord,
    @Default(true) bool enableWordByWordHighlight,
    @Default(false) bool scrollWithRecitation,
    @Default(true) bool useAudioStream,
    @Default(1.0) double playbackSpeed,
  }) = _QuranViewState;
}
