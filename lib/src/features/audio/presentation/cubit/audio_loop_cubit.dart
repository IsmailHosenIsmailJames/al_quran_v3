import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:injectable/injectable.dart";
import "package:just_audio/just_audio.dart";

part 'audio_loop_cubit.freezed.dart';

@freezed
abstract class AudioLoopState with _$AudioLoopState {
  const AudioLoopState._();

  const factory AudioLoopState({
    @Default(LoopMode.off) LoopMode loopMode,
    @Default(false) bool isRangeActive,
    @Default(1) int startSurah,
    @Default(1) int startAyah,
    @Default(1) int endSurah,
    @Default(7) int endAyah,
    @Default(-1) int repeatTargetCount, // -1 for infinite (infinity), or 1..N
    @Default(1) int currentRangeCycle,
    @Default(1) int repeatEachAyah,
    @Default(1) int currentAyahRepeat,
    @Default(0) int pauseBetweenAyahsSeconds,
  }) = _AudioLoopState;

  bool get isInfinite => repeatTargetCount <= 0;
}

@lazySingleton
class AudioLoopCubit extends Cubit<AudioLoopState> {
  AudioLoopCubit() : super(const AudioLoopState());

  Future<void> setLoopMode(LoopMode mode) async {
    try {
      if (AudioPlayerManager.hasActivePlayer) {
        await AudioPlayerManager.audioPlayer.setLoopMode(mode);
      }
    } catch (_) {}
    if (!isClosed) {
      emit(state.copyWith(loopMode: mode));
    }
  }

  Future<void> toggleQuickLoopMode() async {
    LoopMode nextMode;
    switch (state.loopMode) {
      case LoopMode.off:
        nextMode = LoopMode.all;
        break;
      case LoopMode.all:
        nextMode = LoopMode.one;
        break;
      case LoopMode.one:
        nextMode = LoopMode.off;
        break;
    }
    await setLoopMode(nextMode);
  }

  Future<void> setRange({
    required int startSurah,
    required int startAyah,
    required int endSurah,
    required int endAyah,
    int repeatTargetCount = -1,
    int repeatEachAyah = 1,
    int pauseBetweenAyahsSeconds = 0,
  }) async {
    final bool isSingleItemRange =
        startSurah == endSurah && startAyah == endAyah && repeatEachAyah <= 1;
    // A 1-item playlist with LoopMode.all never emits ProcessingState.completed or
    // index wrap events, so we keep native LoopMode.off for single-ayah repeats
    // and trigger each cycle deterministically on completion.
    final loopMode = (repeatTargetCount == 1 || isSingleItemRange)
        ? LoopMode.off
        : LoopMode.all;
    try {
      if (AudioPlayerManager.hasActivePlayer) {
        await AudioPlayerManager.audioPlayer.setLoopMode(loopMode);
      }
    } catch (_) {}

    if (!isClosed) {
      emit(
        state.copyWith(
          isRangeActive: true,
          startSurah: startSurah,
          startAyah: startAyah,
          endSurah: endSurah,
          endAyah: endAyah,
          repeatTargetCount: repeatTargetCount,
          repeatEachAyah: repeatEachAyah.clamp(1, 20),
          pauseBetweenAyahsSeconds: pauseBetweenAyahsSeconds.clamp(0, 30),
          currentRangeCycle: 1,
          currentAyahRepeat: 1,
          loopMode: loopMode,
        ),
      );
    }
  }

  void updateCurrentAyahRepeat(int repeatNumber) {
    if (!isClosed &&
        state.isRangeActive &&
        state.currentAyahRepeat != repeatNumber) {
      emit(state.copyWith(currentAyahRepeat: repeatNumber));
    }
  }

  Future<void> clearRange() async {
    try {
      if (AudioPlayerManager.hasActivePlayer) {
        await AudioPlayerManager.audioPlayer.setLoopMode(LoopMode.off);
      }
    } catch (_) {}
    if (!isClosed) {
      emit(
        state.copyWith(
          isRangeActive: false,
          loopMode: LoopMode.off,
          currentRangeCycle: 1,
          repeatEachAyah: 1,
          currentAyahRepeat: 1,
          pauseBetweenAyahsSeconds: 0,
        ),
      );
    }
  }

  /// Clears active range state only if one is currently active (e.g., when
  /// the user starts standard non-range playback).
  Future<void> clearRangeIfActive() async {
    if (state.isRangeActive) {
      await clearRange();
    }
  }

  /// Increments range repeat cycle. Returns false if target repetitions completed.
  bool onPlaylistCycleFinished() {
    if (!state.isRangeActive) return true;

    if (state.repeatTargetCount > 0) {
      if (state.currentRangeCycle >= state.repeatTargetCount) {
        // Target reached! Stop repeat.
        if (!isClosed) {
          emit(
            state.copyWith(
              isRangeActive: false,
              loopMode: LoopMode.off,
              currentRangeCycle: 1,
              repeatEachAyah: 1,
              currentAyahRepeat: 1,
              pauseBetweenAyahsSeconds: 0,
            ),
          );
        }
        try {
          if (AudioPlayerManager.hasActivePlayer) {
            AudioPlayerManager.audioPlayer.setLoopMode(LoopMode.off);
          }
        } catch (_) {}
        return false;
      }
    }

    if (!isClosed) {
      emit(state.copyWith(currentRangeCycle: state.currentRangeCycle + 1));
    }
    return true;
  }
}
