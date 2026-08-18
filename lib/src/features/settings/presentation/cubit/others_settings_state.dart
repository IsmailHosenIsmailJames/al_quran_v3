import "package:freezed_annotation/freezed_annotation.dart";

part 'others_settings_state.freezed.dart';

@freezed
abstract class OthersSettingsState with _$OthersSettingsState {
  const factory OthersSettingsState({
    @Default(true) bool rememberLastTab,
    @Default(0) int tabIndex,
    @Default(false) bool wakeLock,
  }) = _OthersSettingsState;
}
