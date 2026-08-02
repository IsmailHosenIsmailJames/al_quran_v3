import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/resource_group_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_resources_state.freezed.dart';

enum QuranResourcesStatus { initial, loading, success, failure }

@freezed
abstract class QuranResourcesState with _$QuranResourcesState {
  const factory QuranResourcesState({
    @Default(QuranResourcesStatus.initial) QuranResourcesStatus status,
    @Default(0) int activeTabIndex,
    @Default('') String searchQuery,
    @Default(false) bool isSearching,
    @Default([]) List<ResourceGroupEntity> translationGroups,
    @Default([]) List<ResourceGroupEntity> tafsirGroups,
    @Default([]) List<QuranResourceEntity> wordByWordResources,
    String? downloadingResourcePath,
    @Default(0.0) double downloadProgress,
    String? errorMessage,
  }) = _QuranResourcesState;
}
