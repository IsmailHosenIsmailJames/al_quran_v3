import "package:flutter_bloc/flutter_bloc.dart";

class AudioDownloadCubit extends Cubit<AudioDownloadState> {
  AudioDownloadCubit() : super(AudioDownloadState());
  void updateDownloadingSurahNumber(int index) {
    emit(state.copyWith(surahNumber: index));
  }

  void updateProgress(double progress) {
    emit(state.copyWith(progress: progress));
  }

  void updateIsDownloading(bool isDownloading) {
    emit(state.copyWith(isDownloading: isDownloading));
  }
}

class AudioDownloadState {
  int surahNumber;
  double progress;
  bool isDownloading;
  AudioDownloadState({
    this.surahNumber = 0,
    this.progress = 0.0,
    this.isDownloading = false,
  });

  AudioDownloadState copyWith({
    int? surahNumber,
    double? progress,
    bool? isDownloading,
  }) {
    return AudioDownloadState(
      surahNumber: surahNumber ?? this.surahNumber,
      progress: progress ?? this.progress,
      isDownloading: isDownloading ?? this.isDownloading,
    );
  }
}
