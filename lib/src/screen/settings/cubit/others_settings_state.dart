class OthersSettingsState {
  bool rememberLastTab;
  int tabIndex;
  bool wakeLock;

  OthersSettingsState({
    required this.rememberLastTab,
    required this.tabIndex,
    required this.wakeLock,
  });
  OthersSettingsState copyWith({
    bool? rememberLastTab,
    int? tabIndex,
    bool? wakeLock,
  }) {
    return OthersSettingsState(
      rememberLastTab: rememberLastTab ?? this.rememberLastTab,
      tabIndex: tabIndex ?? this.tabIndex,
      wakeLock: wakeLock ?? this.wakeLock,
    );
  }
}
