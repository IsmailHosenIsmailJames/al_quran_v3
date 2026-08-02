enum DownloadStepStatus {
  initial,
  inProgress,
  completed,
  failed,
}

class DownloadProgress {
  final String stepName;
  final double? percentage; // 0.0 to 1.0 overall progress
  final int currentStepIndex; // 0 to 4
  final int totalSteps;
  final DownloadStepStatus status;
  final String? errorMessage;

  const DownloadProgress({
    required this.stepName,
    this.percentage,
    this.currentStepIndex = 0,
    this.totalSteps = 5,
    required this.status,
    this.errorMessage,
  });

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
