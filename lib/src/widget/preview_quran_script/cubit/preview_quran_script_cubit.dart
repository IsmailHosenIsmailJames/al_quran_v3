import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/hive_flutter.dart";

class PreviewQuranScriptAyahCubit extends Cubit<String> {
  PreviewQuranScriptAyahCubit()
    : super(
        Hive.box("user").get("preview_quran_script_ayah", defaultValue: "2:2"),
      );

  void changeAyah(String ayah) {
    Hive.box("user").put("preview_quran_script_ayah", ayah);
    emit(ayah);
  }
}
