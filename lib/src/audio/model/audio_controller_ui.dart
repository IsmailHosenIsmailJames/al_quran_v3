class AudioControllerUiState {
  bool isExpanded;
  bool showUi;
  AudioControllerUiState({required this.isExpanded, required this.showUi});

  AudioControllerUiState copyWith({bool? isExpanded, bool? showUi}) {
    return AudioControllerUiState(
      isExpanded: isExpanded ?? this.isExpanded,
      showUi: showUi ?? this.showUi,
    );
  }
}
