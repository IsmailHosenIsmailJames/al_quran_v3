import "package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart";

abstract class IHistoryRepository {
  List<HistoryElementEntity> getHistory();
  Future<void> addHistory({
    required int surahNumber,
    int? ayahNumber,
    int? pageNumber,
  });
  Future<void> clearHistory();
}
