import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";
import "package:wakelock_plus/wakelock_plus.dart";
import "auto_scroll_state.dart";

@lazySingleton
class AutoScrollCubit extends Cubit<AutoScrollState> {
  static const String _hiveSpeedKey = "auto_scroll_speed";

  AutoScrollCubit() : super(_buildInitialState());

  static AutoScrollState _buildInitialState() {
    double savedSpeed = 1.0;
    try {
      if (Hive.isBoxOpen("user")) {
        final val = Hive.box("user").get(_hiveSpeedKey, defaultValue: 1.0);
        if (val is num) {
          savedSpeed = val.toDouble();
        }
      }
    } catch (_) {}
    return AutoScrollState(speed: savedSpeed);
  }

  void activate({String? initialAyahKey, int initialIndex = 0}) {
    emit(
      state.copyWith(
        isActive: true,
        isPlaying: true,
        isPausedByTouch: false,
        currentAyahKey: initialAyahKey,
        currentScrollIndex: initialIndex,
      ),
    );
    _enableWakelock();
  }

  void deactivate() {
    emit(
      state.copyWith(isActive: false, isPlaying: false, isPausedByTouch: false),
    );
    _disableWakelock();
  }

  void play() {
    if (!state.isActive) {
      activate(
        initialAyahKey: state.currentAyahKey,
        initialIndex: state.currentScrollIndex,
      );
      return;
    }
    emit(state.copyWith(isPlaying: true, isPausedByTouch: false));
    _enableWakelock();
  }

  void pause() {
    emit(state.copyWith(isPlaying: false));
    _disableWakelock();
  }

  void togglePlayPause() {
    if (state.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  void pauseByTouch() {
    if (state.isPlaying) {
      emit(state.copyWith(isPlaying: false, isPausedByTouch: true));
      _disableWakelock();
    }
  }

  void resumeFromTouch() {
    if (state.isPausedByTouch) {
      emit(state.copyWith(isPlaying: true, isPausedByTouch: false));
      _enableWakelock();
    }
  }

  void setSpeed(double speed) {
    if (AutoScrollState.availableSpeeds.contains(speed)) {
      emit(state.copyWith(speed: speed));
      _persistSpeed(speed);
    }
  }

  void increaseSpeed() {
    final speeds = AutoScrollState.availableSpeeds;
    final currentIndex = speeds.indexOf(state.speed);
    if (currentIndex != -1 && currentIndex < speeds.length - 1) {
      final newSpeed = speeds[currentIndex + 1];
      emit(state.copyWith(speed: newSpeed));
      _persistSpeed(newSpeed);
    }
  }

  void decreaseSpeed() {
    final speeds = AutoScrollState.availableSpeeds;
    final currentIndex = speeds.indexOf(state.speed);
    if (currentIndex > 0) {
      final newSpeed = speeds[currentIndex - 1];
      emit(state.copyWith(speed: newSpeed));
      _persistSpeed(newSpeed);
    }
  }

  void updateCurrentIndex(int index, {String? ayahKey}) {
    emit(
      state.copyWith(
        currentScrollIndex: index,
        currentAyahKey: ayahKey ?? state.currentAyahKey,
      ),
    );
  }

  void _persistSpeed(double speed) {
    try {
      if (Hive.isBoxOpen("user")) {
        Hive.box("user").put(_hiveSpeedKey, speed);
      }
    } catch (_) {}
  }

  void _enableWakelock() {
    try {
      WakelockPlus.enable().catchError((_) {});
    } catch (_) {}
  }

  void _disableWakelock() {
    try {
      WakelockPlus.disable().catchError((_) {});
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _disableWakelock();
    return super.close();
  }
}
