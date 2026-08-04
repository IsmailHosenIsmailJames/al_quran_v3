import 'package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_config.freezed.dart';
part 'setup_config.g.dart';

@freezed
abstract class SetupConfig with _$SetupConfig {
  @JsonSerializable(explicitToJson: true)
  const factory SetupConfig({
    required String appLanguageCode,
    ResourceEntity? selectedTranslation,
    ResourceEntity? selectedTafsir,
    @Default(false) bool isSetupComplete,
  }) = _SetupConfig;

  factory SetupConfig.fromJson(Map<String, dynamic> json) =>
      _$SetupConfigFromJson(json);

  const SetupConfig._();

  bool get isReadyForDownload =>
      selectedTranslation != null && selectedTafsir != null;
}
