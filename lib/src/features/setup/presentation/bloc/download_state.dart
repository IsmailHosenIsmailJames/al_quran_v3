import "package:al_quran_v3/src/features/setup/domain/entities/download_progress.dart";

enum DownloadStatus { initial, downloading, success, failure }

class DownloadState {
  final DownloadStatus status;
  final DownloadProgress progress;
  final String? errorMessage;

  const DownloadState({
    required this.status,
    required this.progress,
    this.errorMessage,
  });

  factory DownloadState.initial() {
    return DownloadState(
      status: DownloadStatus.initial,
      progress: DownloadProgress.initial(),
    );
  }

  DownloadState copyWith({
    DownloadStatus? status,
    DownloadProgress? progress,
    String? errorMessage,
  }) {
    return DownloadState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
