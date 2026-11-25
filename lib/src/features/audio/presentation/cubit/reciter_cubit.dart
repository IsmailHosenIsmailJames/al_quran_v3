import "dart:developer";

import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/resources/recitations.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/segmented_resources_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

/// Unified cubit managing the single active Quran reciter across both the
/// Audio Tab and the Quran Reader (automatically activating word-by-word
/// segments when the selected reciter provides them).
@lazySingleton
class ReciterCubit extends Cubit<ReciterInfoModel> {
  static const String selectedReciterHiveKey = "last_selected_reciter";
  int _segmentRequestToken = 0;

  ReciterCubit() : super(_loadInitialReciter());

  static ReciterInfoModel _normalize(ReciterInfoModel model) {
    final normalizedLink = model.normalizedLink;
    // Match against bundled recitations metadata if segmentsUrl was added later
    final catalogMatch = availableRecitations
        .cast<ReciterInfoModel?>()
        .firstWhere(
          (r) => r != null && r.normalizedLink == normalizedLink,
          orElse: () => null,
        );
    final merged = catalogMatch != null
        ? model.copyWith(
            link: catalogMatch.link,
            segmentsUrl: model.segmentsUrl ?? catalogMatch.segmentsUrl,
            style: model.style ?? catalogMatch.style,
          )
        : model;
    return merged.copyWith(
      supportWordSegmentation: merged.hasWordSegments,
      isDownloading: false,
    );
  }

  static ReciterInfoModel _loadInitialReciter() {
    if (Hive.isBoxOpen("user")) {
      final raw = Hive.box("user").get(selectedReciterHiveKey);
      if (raw is Map) {
        try {
          return _normalize(
            ReciterInfoModel.fromMap(Map<String, dynamic>.from(raw)),
          );
        } catch (e) {
          log(
            "Invalid saved reciter in Hive, falling back: $e",
            name: "ReciterCubit",
          );
        }
      }
    }
    final openSegmentsReciter =
        SegmentedResourcesManager.getOpenSegmentsReciter();
    if (openSegmentsReciter != null) {
      return _normalize(openSegmentsReciter);
    }
    return _normalize(ReciterInfoModel.fromMap(recitationsInfoList.first));
  }

  void _saveSelection(ReciterInfoModel reciter) {
    if (Hive.isBoxOpen("user")) {
      Hive.box("user").put(selectedReciterHiveKey, reciter.toMap());
    }
  }

  /// Selects [reciter] as the active reciter across the entire app.
  ///
  /// Audio playback is never blocked if segment timings fail to download
  /// offline. Returns `true` if the reciter is ready (and segments are ready
  /// when supported), or `false` if word-by-word segment download failed while
  /// keeping the reciter active for ayah-level playback/highlighting.
  Future<bool> changeReciter(ReciterInfoModel reciter) async {
    final normalized = _normalize(reciter);
    final token = ++_segmentRequestToken;

    _saveSelection(normalized);
    SegmentedResourcesManager.segmentsCache.clear();

    if (!normalized.hasWordSegments) {
      emit(normalized);
      await SegmentedResourcesManager.clearActiveBox();
      return true;
    }

    final url = normalized.segmentsUrl!;
    final boxName = SegmentedResourcesManager.praseStringToBoxName(url);

    if (await SegmentedResourcesManager.isAlreadyDownloaded(url)) {
      await SegmentedResourcesManager.changeSelectedBox(boxName);
      if (!isClosed && token == _segmentRequestToken) {
        emit(normalized.copyWith(isDownloading: false));
      }
      return true;
    }

    emit(normalized.copyWith(isDownloading: true));
    bool downloadSuccess = false;
    try {
      downloadSuccess = await SegmentedResourcesManager.downloadResources(
        null,
        url,
        reciterMeta: normalized,
      );
      if (!downloadSuccess) {
        await SegmentedResourcesManager.clearActiveBox();
      }
    } catch (e) {
      log(
        "Error loading segments for ${normalized.name}: $e",
        name: "ReciterCubit",
      );
      await SegmentedResourcesManager.clearActiveBox();
      downloadSuccess = false;
    } finally {
      if (!isClosed && token == _segmentRequestToken) {
        emit(normalized.copyWith(isDownloading: false));
      }
    }
    return downloadSuccess;
  }

  /// Ensures segment timings are opened or downloaded for the current reciter
  /// if it supports word-by-word segmentation.
  Future<void> ensureActiveSegmentsReady() async {
    final current = state;
    if (!current.hasWordSegments) {
      await SegmentedResourcesManager.clearActiveBox();
      return;
    }
    final url = current.segmentsUrl!;
    if (SegmentedResourcesManager.isBoxLoadedForUrl(url)) return;

    if (await SegmentedResourcesManager.isAlreadyDownloaded(url)) {
      await SegmentedResourcesManager.changeSelectedBox(
        SegmentedResourcesManager.praseStringToBoxName(url),
      );
      if (!isClosed) emit(current.copyWith(isDownloading: false));
      return;
    }
    await changeReciter(current);
  }

  /// Returns word timing tuples for [ayahKey] only when the current reciter
  /// supports word-by-word segmentation and has its matching box loaded.
  List<List>? getAyahSegments(String ayahKey) {
    if (!state.hasWordSegments) return null;
    if (!SegmentedResourcesManager.isBoxLoadedForUrl(state.segmentsUrl)) {
      return null;
    }
    final segments = SegmentedResourcesManager.getAyahSegments(ayahKey);
    return segments == null ? null : List<List>.from(segments);
  }

  /// Reloads persisted selection (e.g., after Cloud Sync completes).
  Future<void> reload() async {
    final loaded = _loadInitialReciter();
    emit(loaded);
    if (loaded.hasWordSegments) {
      await ensureActiveSegmentsReady();
    } else {
      await SegmentedResourcesManager.clearActiveBox();
    }
  }

  /// Resets to the default reciter (e.g., after full app reset).
  Future<void> reset() async {
    _segmentRequestToken++;
    final fallback = _normalize(
      ReciterInfoModel.fromMap(recitationsInfoList.first),
    );
    await SegmentedResourcesManager.clearActiveBox();
    if (!isClosed) {
      emit(fallback);
    }
  }
}
