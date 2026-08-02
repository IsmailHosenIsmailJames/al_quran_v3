import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart";

enum SetupStatus { initial, loading, loaded, error }

class SetupState {
  final SetupStatus status;
  final SetupConfig config;
  final Map<String, List<ResourceEntity>> allResources;
  final List<ResourceEntity> selectableTranslations;
  final List<ResourceEntity> selectableTafsirs;
  final String? errorMessage;

  const SetupState({
    this.status = SetupStatus.initial,
    required this.config,
    this.allResources = const {},
    this.selectableTranslations = const [],
    this.selectableTafsirs = const [],
    this.errorMessage,
  });

  factory SetupState.initial() {
    return const SetupState(
      status: SetupStatus.initial,
      config: SetupConfig(appLanguageCode: "en"),
    );
  }

  SetupState copyWith({
    SetupStatus? status,
    SetupConfig? config,
    Map<String, List<ResourceEntity>>? allResources,
    List<ResourceEntity>? selectableTranslations,
    List<ResourceEntity>? selectableTafsirs,
    String? errorMessage,
  }) {
    return SetupState(
      status: status ?? this.status,
      config: config ?? this.config,
      allResources: allResources ?? this.allResources,
      selectableTranslations: selectableTranslations ?? this.selectableTranslations,
      selectableTafsirs: selectableTafsirs ?? this.selectableTafsirs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool doesHaveFootNote(String langCode) {
    return allResources[langCode]?.any((e) => e.hasFootnote) ?? false;
  }

  bool doesHaveTafsirSupport(String langCode) {
    return allResources[langCode]?.any((e) => e.isTafsir) ?? false;
  }

  bool doesHaveWordByWord(String langCode) {
    return allResources[langCode]?.any((e) => e.isWordByWord) ?? false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetupState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          config == other.config &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^ config.hashCode ^ errorMessage.hashCode;
}
