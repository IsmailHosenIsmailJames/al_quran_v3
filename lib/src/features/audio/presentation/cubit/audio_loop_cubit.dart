import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:just_audio/just_audio.dart";

class AudioLoopState {
  final LoopMode loopMode;
  final bool isRangeActive;
  final int startSurah;
  final int startAyah;
  final int endSurah;
  final int endAyah;
  final int repeatTargetCount; // -1 for infinite (infinity), or 1..N
  final int currentRangeCycle;
  final int repeatEachAyah;
  final int currentAyahRepeat;

  const AudioLoopState({
    this.loopMode = LoopMode.off,
    this.isRangeActive = false,
    this.startSurah = 1,
    this.startAyah = 1,
    this.endSurah = 1,
    this.endAyah = 7,
    this.repeatTargetCount = -1,
    this.currentRangeCycle = 1,
    this.repeatEachAyah = 1,
    this.currentAyahRepeat = 1,
  });

  bool get isInfinite => repeatTargetCount <= 0;

  AudioLoopState copyWith({
    LoopMode? loopMode,
    bool? isRangeActive,
    int? startSurah,
    int? startAyah,
    int? endSurah,
    int? endAyah,
    int? repeatTargetCount,
    int? currentRangeCycle,
    int? repeatEachAyah,
    int? currentAyahRepeat,
  }) {
    return AudioLoopState(
      loopMode: loopMode ?? this.loopMode,
      isRangeActive: isRangeActive ?? this.isRangeActive,
      startSurah: startSurah ?? this.startSurah,
      startAyah: startAyah ?? this.startAyah,
      endSurah: endSurah ?? this.endSurah,
      endAyah: endAyah ?? this.endAyah,
      repeatTargetCount: repeatTargetCount ?? this.repeatTargetCount,
      currentRangeCycle: currentRangeCycle ?? this.currentRangeCycle,
      repeatEachAyah: repeatEachAyah ?? this.repeatEachAyah,
      currentAyahRepeat: currentAyahRepeat ?? this.currentAyahRepeat,
    );
  }
}

class AudioLoopCubit extends Cubit<AudioLoopState> {
  AudioLoopCubit() : super(const AudioLoopState());

  Future<void> setLoopMode(LoopMode mode) async {
    try {
      await AudioPlayerManager.audioPlayer.setLoopMode(mode);
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
  }) async {
    final loopMode = repeatTargetCount == 1 ? LoopMode.off : LoopMode.all;
    try {
      await AudioPlayerManager.audioPlayer.setLoopMode(loopMode);
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
          repeatEachAyah: repeatEachAyah,
          currentRangeCycle: 1,
          currentAyahRepeat: 1,
          loopMode: loopMode,
        ),
      );
    }
  }

  Future<void> clearRange() async {
    try {
      await AudioPlayerManager.audioPlayer.setLoopMode(LoopMode.off);
    } catch (_) {}
    if (!isClosed) {
      emit(
        state.copyWith(
          isRangeActive: false,
          loopMode: LoopMode.off,
          currentRangeCycle: 1,
          currentAyahRepeat: 1,
        ),
      );
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
            ),
          );
        }
        try {
          AudioPlayerManager.audioPlayer.setLoopMode(LoopMode.off);
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
