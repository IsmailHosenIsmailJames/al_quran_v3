import "package:al_quran_v3/src/features/mushaf/domain/usecases/mushaf_usecases.dart";
import "package:al_quran_v3/src/features/mushaf/domain/utils/mushaf_page_helper.dart";
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
    emit(state.copyWith(isChecking: true, hasError: false, errorMessage: ""));
    try {
      final isDownloaded = await checkDownloadedUseCase();
      final basePath = await getBasePathUseCase();
      int lastPage = 1;
      if (isDownloaded) {
        lastPage = await getLastPageUseCase();
        if (lastPage < 1 || lastPage > MushafPageHelper.totalPages) {
          lastPage = 1;
        }
      }
      emit(
        state.copyWith(
          isChecking: false,
          dataReady: isDownloaded,
          baseDirPath: basePath,
          currentPage: lastPage,
          hasError: false,
          errorMessage: "",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isChecking: false,
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> downloadMushaf() async {
    emit(
      state.copyWith(
        isDownloading: true,
        isExtracting: false,
        downloadProgress: 0.0,
        downloadStatus: "Downloading Mushaf Data...",
        hasError: false,
        errorMessage: "",
      ),
    );

    try {
      await downloadUseCase(
        onProgress: (progress, status) {
          final isExtracting = progress >= 0.5;
          emit(
            state.copyWith(
              downloadProgress: progress.clamp(0.0, 1.0),
              downloadStatus: status,
              isExtracting: isExtracting,
            ),
          );
        },
      );

      final basePath = await getBasePathUseCase();
      final lastPage = await getLastPageUseCase();
      final safePage = lastPage.clamp(1, MushafPageHelper.totalPages);

      emit(
        state.copyWith(
          isDownloading: false,
          isExtracting: false,
          dataReady: true,
          baseDirPath: basePath,
          currentPage: safePage,
          hasError: false,
          errorMessage: "",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isDownloading: false,
          isExtracting: false,
          hasError: true,
          errorMessage: e.toString(),
          downloadStatus: "Download failed. Please check your connection and try again.",
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
        isExtracting: false,
        downloadProgress: 0.0,
        downloadStatus: "",
        hasError: false,
        errorMessage: "",
      ),
    );
  }

  Future<void> setPage(int page) async {
    final safePage = page.clamp(1, MushafPageHelper.totalPages);
    await saveLastPageUseCase(safePage);
    emit(state.copyWith(currentPage: safePage));
  }

  void toggleUiVisibility() {
    emit(state.copyWith(isUiVisible: !state.isUiVisible));
  }

  void setUiVisibility(bool visible) {
    if (state.isUiVisible != visible) {
      emit(state.copyWith(isUiVisible: visible));
    }
  }
}
