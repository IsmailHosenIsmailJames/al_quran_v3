import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class PlayerStateCubit extends Cubit<PlayerState> {
  PlayerStateCubit(super.initialState);
  void changeState({ProcessingState? processingState, bool? isPlaying}) {
    emit(state.copyWith(state: processingState, isPlaying: isPlaying));
  }
}

class PlayerState {
  ProcessingState? state;
  bool isPlaying;

  PlayerState({this.state, this.isPlaying = false});

  PlayerState copyWith({ProcessingState? state, bool? isPlaying}) =>
      PlayerState(
        state: state ?? this.state,
        isPlaying: isPlaying ?? this.isPlaying,
      );
}
