import "package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart";

class QuranHistoryState {
  final List<HistoryElementEntity> history;
  const QuranHistoryState({required this.history});
}

typedef HistoryElement = HistoryElementEntity;
