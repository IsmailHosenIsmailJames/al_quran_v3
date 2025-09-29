import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/core/audio/resources/recitations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

class AudioTabReciterCubit extends Cubit<ReciterInfoModel> {
  AudioTabReciterCubit()
    : super(
        ReciterInfoModel.fromMap(
          Map<String, dynamic>.from(
            Hive.box("user").get(
              "last_selected_reciter",
              defaultValue: recitationsInfoList[0],
            ),
          ),
        ),
      );

  void changeReciter(ReciterInfoModel reciterInfoModel) {
    emit(reciterInfoModel);
    saveReciterSelection(reciterInfoModel);
  }

  void saveReciterSelection(ReciterInfoModel reciterInfoModel) {
    Hive.box("user").put("last_selected_reciter", reciterInfoModel.toMap());
  }
}
