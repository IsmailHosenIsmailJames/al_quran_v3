import 'package:al_quran_v3/src/features/setup/domain/entities/download_progress.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_state.freezed.dart';

enum DownloadStatus { initial, downloading, success, failure }

@freezed
abstract class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default(DownloadStatus.initial) DownloadStatus status,
    required DownloadProgress progress,
    String? errorMessage,
  }) = _DownloadState;

  factory DownloadState.initial() {
    return DownloadState(
      status: DownloadStatus.initial,
      progress: DownloadProgress.initial(),
    );
  }
}
