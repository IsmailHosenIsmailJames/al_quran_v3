import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_progress.freezed.dart';
part 'download_progress.g.dart';

enum DownloadStepStatus { initial, inProgress, completed, failed }

@freezed
abstract class DownloadProgress with _$DownloadProgress {
  @JsonSerializable(explicitToJson: true)
  const factory DownloadProgress({
    required String stepName,
    double? percentage,
    @Default(0) int currentStepIndex,
    @Default(5) int totalSteps,
    required DownloadStepStatus status,
    String? errorMessage,
  }) = _DownloadProgress;

  factory DownloadProgress.fromJson(Map<String, dynamic> json) =>
      _$DownloadProgressFromJson(json);

  factory DownloadProgress.initial() {
    return const DownloadProgress(
      stepName: "",
      percentage: null,
      currentStepIndex: 0,
      totalSteps: 5,
      status: DownloadStepStatus.initial,
    );
  }

  factory DownloadProgress.inProgress({
    required String stepName,
    double? percentage,
    int currentStepIndex = 0,
    int totalSteps = 5,
  }) {
    return DownloadProgress(
      stepName: stepName,
      percentage: percentage,
      currentStepIndex: currentStepIndex,
      totalSteps: totalSteps,
      status: DownloadStepStatus.inProgress,
    );
  }

  factory DownloadProgress.completed({required String stepName}) {
    return DownloadProgress(
      stepName: stepName,
      percentage: 1.0,
      currentStepIndex: 4,
      totalSteps: 5,
      status: DownloadStepStatus.completed,
    );
  }

  factory DownloadProgress.failed({
    required String stepName,
    required String errorMessage,
    int currentStepIndex = 0,
  }) {
    return DownloadProgress(
      stepName: stepName,
      currentStepIndex: currentStepIndex,
      totalSteps: 5,
      status: DownloadStepStatus.failed,
      errorMessage: errorMessage,
    );
  }
}
