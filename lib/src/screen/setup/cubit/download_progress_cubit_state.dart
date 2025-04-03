part of 'download_progress_cubit_cubit.dart';

@immutable
sealed class DownloadProgressCubitState {}

final class DownloadProgressCubitInitial extends DownloadProgressCubitState {}

final class DownloadProgressCubitLoading extends DownloadProgressCubitState {
  final double percentage;
  final String processName;

  DownloadProgressCubitLoading({
    required this.percentage,
    required this.processName,
  });
}

final class DownloadProgressCubitSuccess extends DownloadProgressCubitState {}

final class DownloadProgressCubitFailure extends DownloadProgressCubitState {
  final String errorMessage;

  DownloadProgressCubitFailure({required this.errorMessage});
}
