import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:injectable/injectable.dart";
import "package:just_audio/just_audio.dart";

part 'player_state_cubit.freezed.dart';

@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({
    ProcessingState? state,
    @Default(false) bool isPlaying,
  }) = _PlayerState;
}

@lazySingleton
class PlayerStateCubit extends Cubit<PlayerState> {
  PlayerStateCubit() : super(const PlayerState());

  void changeState({ProcessingState? processingState, bool? isPlaying}) {
    emit(state.copyWith(state: processingState, isPlaying: isPlaying ?? state.isPlaying));
  }
}
