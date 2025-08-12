import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:hive_flutter/hive_flutter.dart";

class QuranViewCubit extends Cubit<QuranViewState> {
  QuranViewCubit()
    : super(
        QuranViewState(
          ayahKey: Hive.box(
            "user",
          ).get("preview_quran_script_ayah", defaultValue: "1:1"),
          fontSize: Hive.box(
            "user",
          ).get("preview_quran_script_font_size", defaultValue: 24.0),
          translationFontSize: Hive.box(
            "user",
          ).get("preview_translation_font_size", defaultValue: 14.0),
          lineHeight: Hive.box(
            "user",
          ).get("quran_script_heigh_of_line", defaultValue: 2.0),
          quranScriptType: QuranScriptType.values.firstWhere(
            (element) =>
                Hive.box("user").get(
                  "selected_quran_script_type",
                  defaultValue: QuranScriptType.values.first.name,
                ) ==
                element.name,
          ),
          hideFootnote: Hive.box(
            "user",
          ).get("view_hideFootnote", defaultValue: false),
          hideWordByWord: Hive.box(
            "user",
          ).get("view_hideWordByWord", defaultValue: false),
          hideTranslation: Hive.box(
            "user",
          ).get("view_hideTranslation", defaultValue: false),
          hideToolbar: Hive.box(
            "user",
          ).get("view_hideToolbar", defaultValue: false),
          hideQuranAyah: Hive.box(
            "user",
          ).get("view_hideQuranAyah", defaultValue: false),
          alwaysOpenWordByWord: Hive.box(
            "user",
          ).get("view_alwaysOpenWordByWord", defaultValue: false),
          enableWordByWordHighlight: Hive.box(
            "user",
          ).get("view_enableWordByWordHighlight", defaultValue: true),
          scrollWithRecitation: Hive.box(
            "user",
          ).get("view_scrollWithRecitation", defaultValue: false),
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

  void changeQuranScriptType(QuranScriptType quranScriptType) {
    Hive.box("user").put("selected_quran_script_type", quranScriptType.name);
    emit(state.copyWith(quranScriptType: quranScriptType));
  }

  void changeTranslationFontSize(double fontSize) {
    Hive.box("user").put("preview_translation_font_size", fontSize);
    emit(state.copyWith(translationFontSize: fontSize));
  }

  void setViewOptions({
    bool? hideFootnote,
    bool? hideWordByWord,
    bool? hideTranslation,
    bool? hideToolbar,
    bool? hideQuranAyah,
    bool? alwaysOpenWordByWord,
    bool? enableWordByWordHighlight,
    bool? scrollWithRecitation,
  }) {
    // if all are false, show toast that must be selected one
    final newState = state.copyWith(
      hideFootnote: hideFootnote,
      hideWordByWord: hideWordByWord,
      hideTranslation: hideTranslation,
      hideToolbar: hideToolbar,
      hideQuranAyah: hideQuranAyah,
      alwaysOpenWordByWord: alwaysOpenWordByWord,
      enableWordByWordHighlight: enableWordByWordHighlight,
      scrollWithRecitation: scrollWithRecitation,
    );
    if (newState.hideWordByWord == true &&
        newState.hideTranslation == true &&
        newState.hideQuranAyah == true) {
      Fluttertoast.showToast(
        msg:
            AppLocalizations.of(
              navigatorKey.currentContext!,
            ).quranTranslationAyahOneMustEnabled,
      );
      return;
    }
    if (hideFootnote != null) {
      Hive.box("user").put("view_hideFootnote", hideFootnote);
    }
    if (hideWordByWord != null) {
      Hive.box("user").put("view_hideWordByWord", hideWordByWord);
    }
    if (hideTranslation != null) {
      Hive.box("user").put("view_hideTranslation", hideTranslation);
    }
    if (hideToolbar != null) {
      Hive.box("user").put("view_hideToolbar", hideToolbar);
    }
    if (hideQuranAyah != null) {
      Hive.box("user").put("view_hideQuranAyah", hideQuranAyah);
    }
    if (alwaysOpenWordByWord != null) {
      Hive.box("user").put("view_alwaysOpenWordByWord", alwaysOpenWordByWord);
    }
    if (enableWordByWordHighlight != null) {
      Hive.box(
        "user",
      ).put("view_enableWordByWordHighlight", enableWordByWordHighlight);
    }
    if (scrollWithRecitation != null) {
      Hive.box("user").put("view_scrollWithRecitation", scrollWithRecitation);
    }

    emit(newState);
  }
}
