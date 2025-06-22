import "package:al_quran_v3/src/screen/settings/cubit/others_settings_state.dart";
import "package:bloc/bloc.dart";
import "package:hive_flutter/hive_flutter.dart";

class OthersSettingsCubit extends Cubit<OthersSettingsState> {
  OthersSettingsCubit()
    : super(
        OthersSettingsState(
          rememberLastTab: Hive.box(
            "user",
          ).get("remember_last_tab", defaultValue: true),
          tabIndex: Hive.box("user").get("last_tab_index", defaultValue: 0),
        ),
      );

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
