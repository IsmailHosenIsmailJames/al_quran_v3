import "package:al_quran_v3/src/audio/model/audio_player_position_model.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class PlayerPositionCubit extends Cubit<AudioPlayerPositionModel> {
  PlayerPositionCubit() : super(AudioPlayerPositionModel());
  void changeCurrentPosition(Duration? position) {
    emit(state.copyWith(currentDuration: position));
  }

  void changeBufferPosition(Duration? position) {
    emit(state.copyWith(bufferDuration: position));
  }

  void changeTotalDuration(Duration? duration) {
    emit(state.copyWith(totalDuration: duration));
  }

  void changeData(AudioPlayerPositionModel audioPositionData) {
    emit(audioPositionData);
  }
}
