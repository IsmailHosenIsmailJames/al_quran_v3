class OthersSettingsState {
  final bool rememberLastTab;
  final int tabIndex;
  final bool wakeLock;

  OthersSettingsState({
    this.rememberLastTab = true,
    this.tabIndex = 0,
    this.wakeLock = false,
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
