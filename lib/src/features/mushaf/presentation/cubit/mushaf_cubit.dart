import "package:al_quran_v3/src/features/mushaf/domain/usecases/mushaf_usecases.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class MushafCubit extends Cubit<MushafState> {
  final CheckMushafDownloadedUseCase checkDownloadedUseCase;
  final DownloadMushafUseCase downloadUseCase;
  final DeleteMushafUseCase deleteUseCase;
  final GetMushafLastPageUseCase getLastPageUseCase;
  final SaveMushafLastPageUseCase saveLastPageUseCase;
  final GetMushafBasePathUseCase getBasePathUseCase;

  MushafCubit({
    required this.checkDownloadedUseCase,
    required this.downloadUseCase,
    required this.deleteUseCase,
    required this.getLastPageUseCase,
    required this.saveLastPageUseCase,
    required this.getBasePathUseCase,
  }) : super(const MushafState()) {
    checkStatus();
  }

  Future<void> checkStatus() async {
    emit(state.copyWith(isChecking: true));
    final isDownloaded = await checkDownloadedUseCase();
    final basePath = await getBasePathUseCase();
    int lastPage = 1;
    if (isDownloaded) {
      lastPage = await getLastPageUseCase();
    }
    emit(
      state.copyWith(
        isChecking: false,
        dataReady: isDownloaded,
        baseDirPath: basePath,
        currentPage: lastPage,
      ),
    );
  }

  Future<void> downloadMushaf() async {
    emit(
      state.copyWith(
        isDownloading: true,
        downloadProgress: 0.0,
        downloadStatus: "Starting download...",
      ),
    );

    try {
      await downloadUseCase(
        onProgress: (progress, status) {
          emit(
            state.copyWith(downloadProgress: progress, downloadStatus: status),
          );
        },
      );
      final basePath = await getBasePathUseCase();
      final lastPage = await getLastPageUseCase();
      emit(
        state.copyWith(
          isDownloading: false,
          dataReady: true,
          baseDirPath: basePath,
          currentPage: lastPage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isDownloading: false,
          downloadStatus: "Failed to download: $e",
        ),
      );
    }
  }

  Future<void> deleteMushaf() async {
    await deleteUseCase();
    emit(
      state.copyWith(
        dataReady: false,
        isDownloading: false,
        downloadProgress: 0.0,
        downloadStatus: "",
      ),
    );
  }

  Future<void> setPage(int page) async {
    await saveLastPageUseCase(page);
    emit(state.copyWith(currentPage: page));
  }
}
