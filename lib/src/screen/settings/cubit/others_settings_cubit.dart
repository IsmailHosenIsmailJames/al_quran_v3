import "dart:developer";

import "package:al_quran_v3/src/screen/settings/cubit/others_settings_state.dart";
import "package:bloc/bloc.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:wakelock_plus/wakelock_plus.dart";

class OthersSettingsCubit extends Cubit<OthersSettingsState> {
  OthersSettingsCubit()
    : super(
        OthersSettingsState(
          rememberLastTab: Hive.box(
            "user",
          ).get("remember_last_tab", defaultValue: true),
          tabIndex:
              kIsWeb
                  ? 0
                  : Hive.box("user").get("last_tab_index", defaultValue: 0),
          wakeLock: Hive.box("user").get("keep_wake_lock", defaultValue: false),
        ),
      ) {
    _init();
  }

  void _init() {
    bool wakeLock = Hive.box("user").get("keep_wake_lock", defaultValue: false);
    log("Wake Lock: $wakeLock", name: "wake lock");
    if (wakeLock) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }
  }

  void setWakeLock(bool value) async {
    await Hive.box("user").put("keep_wake_lock", value);
    if (value) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }

    emit(state.copyWith(wakeLock: value));
  }

  void setRememberLastTab(bool value) {
    Hive.box("user").put("remember_last_tab", value);
    emit(state.copyWith(rememberLastTab: value));
  }

  void setTabIndex(int value) {
    if (value != state.tabIndex) {
      if (state.rememberLastTab) Hive.box("user").put("last_tab_index", value);
      emit(state.copyWith(tabIndex: value));
    }
  }
}
