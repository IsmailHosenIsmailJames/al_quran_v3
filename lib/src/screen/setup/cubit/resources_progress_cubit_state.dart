import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";

class ResourcesProcceessCubitState {
  String? appLanguageCode;
  double? percentage;
  String? processName;
  bool? onProcess;
  bool? isSuccess;
  String? errorMessage;
  // Map of language code and resources list
  final Map<String, List<ResourcesModel>> allResources;
  List<ResourcesModel>? selectableTranslationResources;
  List<ResourcesModel>? selectableTafsirResources;
  ResourcesModel? selectedTafsirResources;
  ResourcesModel? selectedTranslationResources;

  ResourcesProcceessCubitState({
    this.appLanguageCode,
    this.percentage,
    this.processName,
    this.onProcess,
    this.isSuccess,
    this.errorMessage,
    required this.allResources,
    this.selectableTranslationResources,
    this.selectableTafsirResources,
    this.selectedTafsirResources,
    this.selectedTranslationResources,
  });

  ResourcesProcceessCubitState copyWith({
    String? appLanguageCode,
    double? percentage,
    String? processName,
    bool? onProcess,
    bool? isSuccess,
    String? errorMessage,
    Map<String, List<ResourcesModel>>? allResources,
    List<ResourcesModel>? selectableTranslationResources,
    List<ResourcesModel>? selectableTafsirResources,
    ResourcesModel? selectedTafsirResources,
    ResourcesModel? selectedTranslationResources,
  }) {
    return ResourcesProcceessCubitState(
      appLanguageCode: appLanguageCode ?? this.appLanguageCode,
      percentage: percentage ?? this.percentage,
      processName: processName ?? this.processName,
      onProcess: onProcess ?? this.onProcess,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      allResources: allResources ?? this.allResources,
      selectedTafsirResources:
          selectedTafsirResources ?? this.selectedTafsirResources,
      selectedTranslationResources:
          selectedTranslationResources ?? this.selectedTranslationResources,
      selectableTranslationResources:
          selectableTranslationResources ?? this.selectableTranslationResources,
      selectableTafsirResources:
          selectableTafsirResources ?? this.selectableTafsirResources,
    );
  }
}
