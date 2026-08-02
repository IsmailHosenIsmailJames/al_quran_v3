import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";

class SetupConfig {
  final String appLanguageCode;
  final ResourceEntity? selectedTranslation;
  final ResourceEntity? selectedTafsir;
  final bool isSetupComplete;

  const SetupConfig({
    required this.appLanguageCode,
    this.selectedTranslation,
    this.selectedTafsir,
    this.isSetupComplete = false,
  });

  bool get isReadyForDownload =>
      selectedTranslation != null && selectedTafsir != null;

  SetupConfig copyWith({
    String? appLanguageCode,
    ResourceEntity? selectedTranslation,
    ResourceEntity? selectedTafsir,
    bool? isSetupComplete,
  }) {
    return SetupConfig(
      appLanguageCode: appLanguageCode ?? this.appLanguageCode,
      selectedTranslation: selectedTranslation ?? this.selectedTranslation,
      selectedTafsir: selectedTafsir ?? this.selectedTafsir,
      isSetupComplete: isSetupComplete ?? this.isSetupComplete,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetupConfig &&
          runtimeType == other.runtimeType &&
          appLanguageCode == other.appLanguageCode &&
          selectedTranslation == other.selectedTranslation &&
          selectedTafsir == other.selectedTafsir &&
          isSetupComplete == other.isSetupComplete;

  @override
  int get hashCode =>
      appLanguageCode.hashCode ^
      selectedTranslation.hashCode ^
      selectedTafsir.hashCode ^
      isSetupComplete.hashCode;
}
