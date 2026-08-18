import "package:al_quran_v3/src/features/home/domain/repositories/i_history_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class AddHistoryUseCase {
  final IHistoryRepository repository;

  AddHistoryUseCase(this.repository);

  Future<void> call({
    required int surahNumber,
    int? ayahNumber,
    int? pageNumber,
  }) => repository.addHistory(
    surahNumber: surahNumber,
    ayahNumber: ayahNumber,
    pageNumber: pageNumber,
  );
}
