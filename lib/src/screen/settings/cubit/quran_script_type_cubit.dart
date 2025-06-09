import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";
import "package:bloc/bloc.dart";
import "package:hive/hive.dart";

class QuranScriptTypeCubit extends Cubit<QuranScriptType> {
  QuranScriptTypeCubit()
    : super(
        QuranScriptType.values.firstWhere(
          (element) =>
              Hive.box("user").get(
                "selected_script",
                defaultValue: QuranScriptType.values.first.name,
              ) ==
              element.name,
        ),
      );

  void setQuranScriptType(QuranScriptType quranScriptType) {
    emit(quranScriptType);
  }
}
