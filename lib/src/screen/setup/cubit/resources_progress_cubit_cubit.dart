import "package:al_quran_v3/src/resources/quran_resources/models/tafsir_book_model.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/translation_book_model.dart";
import "package:al_quran_v3/src/screen/setup/cubit/resources_progress_cubit_state.dart";
import "package:bloc/bloc.dart";

class ResourcesProgressCubitCubit extends Cubit<ResourcesProgressCubitState> {
  ResourcesProgressCubitCubit() : super(ResourcesProgressCubitState());

  void updateProgress(double? percentage, String processName) {
    emit(state.copyWith(percentage: percentage, processName: processName));
  }

  void success() {
    emit(state.copyWith(isSuccess: true));
  }

  void failure(String errorMessage) {
    emit(state.copyWith(isSuccess: false, errorMessage: errorMessage));
  }

  void onProcess() {
    emit(state.copyWith(onProcess: true));
  }

  void changeTranslationBook(TranslationBookModel? translationBookModel) {
    emit(state.copyWith(translationBookModel: translationBookModel));
  }

  void changeTafsirBook(TafsirBookModel? tafsirBookModel) {
    emit(state.copyWith(tafsirBookModel: tafsirBookModel));
  }
}
