import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/utils/quran_resources/segmented_resources_manager.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:al_quran_v3/src/utils/get_segments_supported_reciters.dart";

class SegmentedQuranReciterCubit extends Cubit<ReciterInfoModel> {
  SegmentedQuranReciterCubit()
    : super(
        SegmentedResourcesManager.getOpenSegmentsReciter() ??
            getSegmentsSupportedReciters().first,
      );

  Future<bool> changeReciter(
    BuildContext context,
    ReciterInfoModel reciter,
  ) async {
    if (reciter.segmentsUrl == null) {
      assert(true, "Segments is not supported");
    }
    ReciterInfoModel previousReciter = state.copyWith(isDownloading: false);
    emit(reciter.copyWith(isDownloading: true));
    bool isSuccess = await SegmentedResourcesManager.downloadResources(
      context,
      reciter.segmentsUrl!,
    );
    emit(state.copyWith(isDownloading: false));
    if (isSuccess) {
      emit(reciter);
      return true;
    }
    emit(previousReciter);
    return false;
  }

  List<List>? getAyahSegments(String ayahKey) {
    List? segments = SegmentedResourcesManager.getAyahSegments(ayahKey);
    return segments == null ? null : List<List>.from(segments);
  }

  void temporaryHilightAyah(String ayah) async {
    emit(state.copyWith(showAyahHighlight: ayah));
  }

  void refresh() {
    emit(state.copyWith());
  }
}
