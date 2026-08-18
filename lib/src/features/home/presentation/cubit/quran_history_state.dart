import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart';

part 'quran_history_state.freezed.dart';

@freezed
abstract class QuranHistoryState with _$QuranHistoryState {
  const factory QuranHistoryState({
    @Default([]) List<HistoryElementEntity> history,
  }) = _QuranHistoryState;
}

typedef HistoryElement = HistoryElementEntity;
