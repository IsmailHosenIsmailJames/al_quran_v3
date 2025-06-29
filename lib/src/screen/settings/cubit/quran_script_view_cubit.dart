import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/hive_flutter.dart";

class QuranViewCubit extends Cubit<QuranViewState> {
  QuranViewCubit()
    : super(
        QuranViewState(
          ayahKey: Hive.box(
            "user",
          ).get("preview_quran_script_ayah", defaultValue: "2:2"),
          fontSize: Hive.box(
            "user",
          ).get("preview_quran_script_font_size", defaultValue: 24.0),
        ),
      );

  void changeAyah(String ayah) {
    Hive.box("user").put("preview_quran_script_ayah", ayah);
    emit(state.copyWith(ayahKey: ayah));
  }

  void changeFontSize(double fontSize) {
    Hive.box("user").put("preview_quran_script_font_size", fontSize);
    emit(state.copyWith(fontSize: fontSize));
  }

  void changeLineHeight(double lineHeight) {
    Hive.box("user").put("quran_script_heigh_of_line", lineHeight);
    emit(state.copyWith(lineHeight: lineHeight));
  }

  void changeTranslationFontSize(double fontSize) {
    Hive.box("user").put("preview_translation_font_size", fontSize);
    emit(state.copyWith(translationFontSize: fontSize));
  }
}
