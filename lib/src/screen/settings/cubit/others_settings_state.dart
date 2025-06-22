class OthersSettingsState {
  bool rememberLastTab;
  int tabIndex;

  OthersSettingsState({required this.rememberLastTab, required this.tabIndex});
  OthersSettingsState copyWith({bool? rememberLastTab, int? tabIndex}) {
    return OthersSettingsState(
      rememberLastTab: rememberLastTab ?? this.rememberLastTab,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}
