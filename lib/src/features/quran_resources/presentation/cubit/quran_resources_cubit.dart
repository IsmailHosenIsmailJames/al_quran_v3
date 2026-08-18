import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/delete_quran_resource_usecase.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/download_quran_resource_usecase.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/get_quran_resources_usecase.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/usecases/toggle_quran_resource_selection_usecase.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class QuranResourcesCubit extends Cubit<QuranResourcesState> {
  final GetQuranResourcesUseCase _getQuranResourcesUseCase;
  final DownloadQuranResourceUseCase _downloadQuranResourceUseCase;
  final ToggleQuranResourceSelectionUseCase
      _toggleQuranResourceSelectionUseCase;
  final DeleteQuranResourceUseCase _deleteQuranResourceUseCase;

  QuranResourcesCubit(
    this._getQuranResourcesUseCase,
    this._downloadQuranResourceUseCase,
    this._toggleQuranResourceSelectionUseCase,
    this._deleteQuranResourceUseCase,
  ) : super(const QuranResourcesState());

  Future<void> loadResources({int? initTab}) async {
    final currentTab = initTab ?? state.activeTabIndex;
    emit(
      state.copyWith(
        status: QuranResourcesStatus.loading,
        activeTabIndex: currentTab,
      ),
    );
    try {
      final translations = await _getQuranResourcesUseCase.getTranslations(
        query: state.searchQuery,
      );
      final tafsirs = await _getQuranResourcesUseCase.getTafsirs(
        query: state.searchQuery,
      );
      final wbw = await _getQuranResourcesUseCase.getWordByWord(
        query: state.searchQuery,
      );

      emit(
        state.copyWith(
          status: QuranResourcesStatus.success,
          translationGroups: translations,
          tafsirGroups: tafsirs,
          wordByWordResources: wbw,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: QuranResourcesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void changeTab(int index) {
    emit(state.copyWith(activeTabIndex: index));
  }

  void toggleSearching() {
    if (state.isSearching) {
      emit(state.copyWith(isSearching: false, searchQuery: ''));
      loadResources();
    } else {
      emit(state.copyWith(isSearching: true));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    loadResources();
  }

  Future<void> downloadResource(QuranResourceEntity resource) async {
    emit(
      state.copyWith(
        downloadingResourcePath: resource.fullPath,
        downloadProgress: 0.0,
      ),
    );

    final success = await _downloadQuranResourceUseCase(
      resource,
      onProgress: (progress, name) {
        emit(state.copyWith(downloadProgress: progress));
      },
    );

    emit(
      state.copyWith(
        downloadingResourcePath: null,
        downloadProgress: 0.0,
      ),
    );

    if (success) {
      await loadResources();
    }
  }

  Future<void> toggleSelection(QuranResourceEntity resource) async {
    await _toggleQuranResourceSelectionUseCase(resource);
    await loadResources();
  }

  Future<void> deleteResource(QuranResourceEntity resource) async {
    await _deleteQuranResourceUseCase(resource);
    await loadResources();
  }

  Future<void> redownloadResource(QuranResourceEntity resource) async {
    await _deleteQuranResourceUseCase(resource);
    await downloadResource(resource);
  }
}
