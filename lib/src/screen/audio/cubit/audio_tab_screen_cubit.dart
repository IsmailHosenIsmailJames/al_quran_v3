import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:al_quran_v3/src/screen/audio/cubit/audio_tab_screen_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/hive_flutter.dart";

class AudioTabScreenCubit extends Cubit<AudioTabScreenState> {
  AudioTabScreenCubit()
    : super(
        AudioTabScreenState(
          reciterInfoModel: ReciterInfoModel.fromMap(
            Hive.box("user").get(
              "last_selected_reciter",
              defaultValue: recitationsInfoList[0],
            ),
          ),
          ayahKey: Hive.box(
            "user",
          ).get("last_player_ayah_key", defaultValue: "1:1"),
        ),
      );

  void changeReciter(ReciterInfoModel reciterInfoModel) {
    emit(state.copyWith(reciterInfoModel: reciterInfoModel));
  }
}
