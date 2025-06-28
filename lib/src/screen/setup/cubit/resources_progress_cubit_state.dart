import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";

class ResourcesProgressCubitState {
  double? percentage;
  String? processName;
  bool? onProcess;
  bool? isSuccess;
  String? errorMessage;
  TranslationBookModel? translationBookModel;
  TafsirBookModel? tafsirBookModel;

  ResourcesProgressCubitState({
    this.percentage,
    this.processName,
    this.onProcess,
    this.isSuccess,
    this.errorMessage,
    this.translationBookModel,
    this.tafsirBookModel,
  });

  ResourcesProgressCubitState copyWith({
    double? percentage,
    String? processName,
    bool? onProcess,
    bool? isSuccess,
    String? errorMessage,
    TranslationBookModel? translationBookModel,
    TafsirBookModel? tafsirBookModel,
  }) {
    return ResourcesProgressCubitState(
      percentage: percentage ?? this.percentage,
      processName: processName ?? this.processName,
      onProcess: onProcess ?? this.onProcess,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      translationBookModel: translationBookModel ?? this.translationBookModel,
      tafsirBookModel: tafsirBookModel ?? this.tafsirBookModel,
    );
  }
}
