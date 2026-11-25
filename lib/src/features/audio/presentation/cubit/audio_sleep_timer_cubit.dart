import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

enum SleepTimerMode { off, timed, endOfAyah, endOfSurah }

@immutable
class AudioSleepTimerState {
  final SleepTimerMode mode;
  final int totalSeconds;
  final int remainingSeconds;

  const AudioSleepTimerState({
    this.mode = SleepTimerMode.off,
    this.totalSeconds = 0,
    this.remainingSeconds = 0,
  });

  bool get isActive => mode != SleepTimerMode.off;

  Duration get remainingDuration => Duration(seconds: remainingSeconds);

  AudioSleepTimerState copyWith({
    SleepTimerMode? mode,
    int? totalSeconds,
    int? remainingSeconds,
  }) {
    return AudioSleepTimerState(
      mode: mode ?? this.mode,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AudioSleepTimerState &&
            other.mode == mode &&
            other.totalSeconds == totalSeconds &&
            other.remainingSeconds == remainingSeconds);
  }

  @override
  int get hashCode => Object.hash(mode, totalSeconds, remainingSeconds);
}

@lazySingleton
class AudioSleepTimerCubit extends Cubit<AudioSleepTimerState> {
  Timer? _countdownTimer;
  Future<void> Function()? _onExpiredCallback;

  AudioSleepTimerCubit() : super(const AudioSleepTimerState());

  void attachExpirationHandler(Future<void> Function()? handler) {
    _onExpiredCallback = handler;
  }

  void startTimed(Duration duration) {
    _countdownTimer?.cancel();
    final seconds = duration.inSeconds;
    if (seconds <= 0) {
      cancel();
      return;
    }

    emit(
      AudioSleepTimerState(
        mode: SleepTimerMode.timed,
        totalSeconds: seconds,
        remainingSeconds: seconds,
      ),
    );

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) {
        _countdownTimer?.cancel();
        return;
      }
      final next = state.remainingSeconds - 1;
      if (next <= 0) {
        triggerExpiration();
      } else {
        emit(state.copyWith(remainingSeconds: next));
      }
    });
  }

  void setStopAfterCurrentAyah() {
    _countdownTimer?.cancel();
    emit(
      const AudioSleepTimerState(
        mode: SleepTimerMode.endOfAyah,
        totalSeconds: 0,
        remainingSeconds: 0,
      ),
    );
  }

  void setStopAfterCurrentSurah() {
    _countdownTimer?.cancel();
    emit(
      const AudioSleepTimerState(
        mode: SleepTimerMode.endOfSurah,
        totalSeconds: 0,
        remainingSeconds: 0,
      ),
    );
  }

  Future<void> triggerExpiration() async {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    if (!isClosed) {
      emit(const AudioSleepTimerState());
    }
    final handler = _onExpiredCallback;
    if (handler != null) {
      try {
        await handler();
      } catch (_) {}
    }
  }

  void cancel() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    if (!isClosed) {
      emit(const AudioSleepTimerState());
    }
  }

  @override
  @disposeMethod
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
