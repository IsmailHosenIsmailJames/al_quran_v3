import "package:al_quran_v3/src/features/home/data/datasources/history_local_datasource.dart";
import "package:al_quran_v3/src/features/home/data/models/history_element_model.dart";
import "package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart";
import "package:al_quran_v3/src/features/home/domain/repositories/i_history_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: IHistoryRepository)
class HistoryRepositoryImpl implements IHistoryRepository {
  final HistoryLocalDataSource localDataSource;

  HistoryRepositoryImpl(this.localDataSource);

  @override
  List<HistoryElementEntity> getHistory() {
    return localDataSource.getHistory();
  }

  @override
  Future<void> addHistory({
    required int surahNumber,
    int? ayahNumber,
    int? pageNumber,
  }) async {
    List<HistoryElementModel> history = localDataSource.getHistory();
    HistoryElementModel? lastHistory =
        history.isEmpty ? null : history.last;

    if (lastHistory != null &&
        surahNumber == lastHistory.surahNumber &&
        DateTime.fromMillisecondsSinceEpoch(
              lastHistory.timestamp,
            ).difference(DateTime.now()).inMinutes.abs() <
            5) {
      if (history.isNotEmpty) history.removeLast();
    }

    history.add(
      HistoryElementModel(
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
        pageNumber: pageNumber,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    await localDataSource.saveHistory(history);
  }

  @override
  Future<void> clearHistory() => localDataSource.clearHistory();
}
