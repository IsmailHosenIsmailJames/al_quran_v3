class AudioPlayerPositionModel {
  Duration? currentDuration;
  Duration? totalDuration;
  Duration? bufferDuration;
  AudioPlayerPositionModel({
    this.currentDuration,
    this.totalDuration,
    this.bufferDuration,
  });

  AudioPlayerPositionModel copyWith({
    Duration? currentDuration,
    Duration? totalDuration,
    Duration? bufferDuration,
  }) {
    return AudioPlayerPositionModel(
      currentDuration: currentDuration ?? this.currentDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      bufferDuration: bufferDuration ?? this.bufferDuration,
    );
  }
}
