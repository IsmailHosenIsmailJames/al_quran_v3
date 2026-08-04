import 'package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart';
import 'package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_state.freezed.dart';

enum SetupStatus { initial, loading, loaded, error }

@freezed
abstract class SetupState with _$SetupState {
  @JsonSerializable(explicitToJson: true)
  const factory SetupState({
    @Default(SetupStatus.initial) SetupStatus status,
    required SetupConfig config,
    @Default({}) Map<String, List<ResourceEntity>> allResources,
    @Default([]) List<ResourceEntity> selectableTranslations,
    @Default([]) List<ResourceEntity> selectableTafsirs,
    String? errorMessage,
  }) = _SetupState;

  factory SetupState.initial() {
    return const SetupState(
      status: SetupStatus.initial,
      config: SetupConfig(appLanguageCode: "en"),
    );
  }

  const SetupState._();

  bool doesHaveFootNote(String langCode) {
    return allResources[langCode]?.any((e) => e.hasFootnote) ?? false;
  }

  bool doesHaveTafsirSupport(String langCode) {
    return allResources[langCode]?.any((e) => e.isTafsir) ?? false;
  }

  bool doesHaveWordByWord(String langCode) {
    return allResources[langCode]?.any((e) => e.isWordByWord) ?? false;
  }
}
