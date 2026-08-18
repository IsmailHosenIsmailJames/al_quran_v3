import "package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart";
import "package:al_quran_v3/src/features/home/domain/repositories/i_history_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class GetHistoryUseCase {
  final IHistoryRepository repository;

  GetHistoryUseCase(this.repository);

  List<HistoryElementEntity> call() => repository.getHistory();
}
