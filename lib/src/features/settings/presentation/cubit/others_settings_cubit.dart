import "dart:developer";

import "package:al_quran_v3/src/features/settings/domain/usecases/get_settings_usecase.dart";
import "package:al_quran_v3/src/features/settings/domain/usecases/save_settings_usecase.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_state.dart";
import "package:bloc/bloc.dart";
import "package:injectable/injectable.dart";
import "package:wakelock_plus/wakelock_plus.dart";

@injectable
class OthersSettingsCubit extends Cubit<OthersSettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final SaveSettingsUseCase saveSettingsUseCase;

  OthersSettingsCubit({
    required this.getSettingsUseCase,
    required this.saveSettingsUseCase,
  }) : super(
         OthersSettingsState(
           rememberLastTab: getSettingsUseCase.getRememberLastTab(),
           tabIndex: getSettingsUseCase.getLastTabIndex(),
           wakeLock: getSettingsUseCase.getWakeLock(),
         ),
       ) {
    _init();
  }

  void _init() {
    bool wakeLock = state.wakeLock;
    log("Wake Lock: $wakeLock", name: "wake lock");
    if (wakeLock) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }
  }

  void setWakeLock(bool value) async {
    await saveSettingsUseCase.setWakeLock(value);
    if (value) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }

    emit(state.copyWith(wakeLock: value));
  }

  void setRememberLastTab(bool value) async {
    await saveSettingsUseCase.setRememberLastTab(value);
    emit(state.copyWith(rememberLastTab: value));
  }

  void setTabIndex(int value) async {
    if (value != state.tabIndex) {
      if (state.rememberLastTab) {
        await saveSettingsUseCase.setLastTabIndex(value);
      }
      emit(state.copyWith(tabIndex: value));
    }
  }
}
