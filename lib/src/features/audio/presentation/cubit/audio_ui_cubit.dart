import "package:al_quran_v3/src/features/audio/data/models/audio_controller_ui_model.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AudioUiCubit extends Cubit<AudioControllerUiState> {
  AudioUiCubit()
    : super(
        const AudioControllerUiState(
          isExpanded: false,
          showUi: false,
          isPlayList: false,
          isInsideQuranPlayer: false,
        ),
      );

  void expand(bool toChange) {
    emit(state.copyWith(isExpanded: toChange));
  }

  void showUI(bool toChange) {
    emit(state.copyWith(showUi: toChange));
  }

  void isPlayList(bool toChange) {
    emit(state.copyWith(isPlayList: toChange));
  }

  void changeIsInsideQuran(bool toChange) {
    emit(state.copyWith(isInsideQuranPlayer: toChange));
  }
}
