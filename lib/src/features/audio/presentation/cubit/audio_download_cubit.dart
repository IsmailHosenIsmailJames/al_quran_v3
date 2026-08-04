import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_download_cubit.freezed.dart';
part 'audio_download_cubit.g.dart';

@freezed
abstract class AudioDownloadState with _$AudioDownloadState {
  @JsonSerializable(explicitToJson: true)
  const factory AudioDownloadState({
    @Default(0) int surahNumber,
    @Default(0.0) double progress,
    @Default(false) bool isDownloading,
  }) = _AudioDownloadState;

  factory AudioDownloadState.fromJson(Map<String, dynamic> json) =>
      _$AudioDownloadStateFromJson(json);
}

class AudioDownloadCubit extends Cubit<AudioDownloadState> {
  AudioDownloadCubit() : super(const AudioDownloadState());

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
