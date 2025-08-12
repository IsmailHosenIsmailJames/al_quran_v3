class AudioControllerUiState {
  bool isExpanded;
  bool showUi;
  bool isPlayList;
  bool isInsideQuranPlayer;
  AudioControllerUiState({
    required this.isExpanded,
    required this.showUi,
    required this.isPlayList,
    required this.isInsideQuranPlayer,
  });

  AudioControllerUiState copyWith({
    bool? isExpanded,
    bool? showUi,
    bool? isPlayList,
    bool? isInsideQuranPlayer,
  }) {
    return AudioControllerUiState(
      isExpanded: isExpanded ?? this.isExpanded,
      showUi: showUi ?? this.showUi,
      isPlayList: isPlayList ?? this.isPlayList,
      isInsideQuranPlayer: isInsideQuranPlayer ?? this.isInsideQuranPlayer,
    );
  }
}
