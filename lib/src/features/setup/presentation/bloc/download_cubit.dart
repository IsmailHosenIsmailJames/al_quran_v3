import "dart:async";

import "package:al_quran_v3/src/features/setup/domain/entities/download_progress.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart";
import "package:al_quran_v3/src/features/setup/domain/usecases/download_setup_resources_usecase.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/download_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class DownloadCubit extends Cubit<DownloadState> {
  final DownloadSetupResourcesUseCase downloadSetupResourcesUseCase;
  StreamSubscription<DownloadProgress>? _subscription;

  DownloadCubit({required this.downloadSetupResourcesUseCase})
      : super(DownloadState.initial());

  void startDownload({
    required SetupConfig config,
    required String segmentsUrl,
  }) {
    emit(DownloadState(
      status: DownloadStatus.downloading,
      progress: DownloadProgress.inProgress(stepName: "Starting setup downloads..."),
    ));

    _subscription?.cancel();
    _subscription = downloadSetupResourcesUseCase
        .execute(config: config, segmentsUrl: segmentsUrl)
        .listen(
      (progress) {
        if (progress.status == DownloadStepStatus.completed) {
          emit(state.copyWith(
            status: DownloadStatus.success,
            progress: progress,
          ));
        } else if (progress.status == DownloadStepStatus.failed) {
          emit(state.copyWith(
            status: DownloadStatus.failure,
            progress: progress,
            errorMessage: progress.errorMessage ?? "An error occurred during download.",
          ));
        } else {
          emit(state.copyWith(
            status: DownloadStatus.downloading,
            progress: progress,
          ));
        }
      },
      onError: (error) {
        emit(state.copyWith(
          status: DownloadStatus.failure,
          errorMessage: error.toString(),
        ));
      },
    );
  }

  void reset() {
    _subscription?.cancel();
    emit(DownloadState.initial());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
