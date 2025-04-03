import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'download_progress_cubit_state.dart';

class DownloadProgressCubitCubit extends Cubit<DownloadProgressCubitState> {
  DownloadProgressCubitCubit() : super(DownloadProgressCubitInitial());

  void updateProgress(double? percentage, String processName) {
    emit(
      DownloadProgressCubitLoading(
        percentage: percentage,
        processName: processName,
      ),
    );
  }

  void success() {
    emit(DownloadProgressCubitSuccess());
  }

  void failure(String errorMessage) {
    emit(DownloadProgressCubitFailure(errorMessage: errorMessage));
  }
}
