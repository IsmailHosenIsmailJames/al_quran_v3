import "dart:async";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:injectable/injectable.dart";

part "sleep_timer_cubit.freezed.dart";

@freezed
abstract class SleepTimerState with _$SleepTimerState {
  const factory SleepTimerState({
    @Default(false) bool isActive,
    @Default(false) bool isEndOfSurah,
    Duration? remainingDuration,
    int? selectedMinutes,
  }) = _SleepTimerState;
}

@lazySingleton
class SleepTimerCubit extends Cubit<SleepTimerState> {
  Timer? _countdownTimer;

  SleepTimerCubit() : super(const SleepTimerState());

  void setTimerMinutes(int minutes) {
    _countdownTimer?.cancel();
    final duration = Duration(minutes: minutes);
    emit(
      SleepTimerState(
        isActive: true,
        isEndOfSurah: false,
        remainingDuration: duration,
        selectedMinutes: minutes,
      ),
    );

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingDuration == null ||
          state.remainingDuration!.inSeconds <= 1) {
        timer.cancel();
        AudioPlayerManager.audioPlayer.pause();
        emit(const SleepTimerState(isActive: false));
      } else {
        emit(
          state.copyWith(
            remainingDuration:
                state.remainingDuration! - const Duration(seconds: 1),
          ),
        );
      }
    });
  }

  void setEndOfSurah() {
    _countdownTimer?.cancel();
    emit(
      const SleepTimerState(
        isActive: true,
        isEndOfSurah: true,
        remainingDuration: null,
        selectedMinutes: null,
      ),
    );
  }

  void cancelTimer() {
    _countdownTimer?.cancel();
    emit(const SleepTimerState(isActive: false));
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
