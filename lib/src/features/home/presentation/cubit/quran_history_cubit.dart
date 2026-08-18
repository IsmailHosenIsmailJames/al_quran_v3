import "package:al_quran_v3/src/features/home/domain/usecases/add_history_usecase.dart";
import "package:al_quran_v3/src/features/home/domain/usecases/get_history_usecase.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class QuranHistoryCubit extends Cubit<QuranHistoryState> {
  final GetHistoryUseCase getHistoryUseCase;
  final AddHistoryUseCase addHistoryUseCase;

  QuranHistoryCubit({
    required this.getHistoryUseCase,
    required this.addHistoryUseCase,
  }) : super(QuranHistoryState(history: getHistoryUseCase()));

  Future<void> addHistory({required String ayahKey, int? pageNumber}) async {
    int surahNumber = int.parse(ayahKey.split(":")[0]);
    int ayahNumber = int.parse(ayahKey.split(":")[1]);

    await addHistoryUseCase(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      pageNumber: pageNumber,
    );

    emit(QuranHistoryState(history: getHistoryUseCase()));
  }
}
