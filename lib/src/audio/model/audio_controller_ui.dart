class AudioControllerUiState {
  bool isExpanded;
  bool showUi;
  bool isPlayList;
  AudioControllerUiState({
    required this.isExpanded,
    required this.showUi,
    required this.isPlayList,
  });

  AudioControllerUiState copyWith({
    bool? isExpanded,
    bool? showUi,
    bool? isPlayList,
  }) {
    return AudioControllerUiState(
      isExpanded: isExpanded ?? this.isExpanded,
      showUi: showUi ?? this.showUi,
      isPlayList: isPlayList ?? this.isPlayList,
    );
  }
}
