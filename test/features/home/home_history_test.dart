import "package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart";
import "package:al_quran_v3/src/features/home/domain/repositories/i_history_repository.dart";
import "package:al_quran_v3/src/features/home/domain/usecases/add_history_usecase.dart";
import "package:al_quran_v3/src/features/home/domain/usecases/get_history_usecase.dart";
import "package:flutter_test/flutter_test.dart";

class FakeHistoryRepository implements IHistoryRepository {
  final List<HistoryElementEntity> _storage = [];

  @override
  List<HistoryElementEntity> getHistory() => List.unmodifiable(_storage);

  @override
  Future<void> addHistory({
    required int surahNumber,
    int? ayahNumber,
    int? pageNumber,
  }) async {
    _storage.add(
      HistoryElementEntity(
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
        pageNumber: pageNumber,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  @override
  Future<void> clearHistory() async {
    _storage.clear();
  }
}

void main() {
  group("Home & History Feature Clean Architecture Tests", () {
    late FakeHistoryRepository fakeRepo;
    late GetHistoryUseCase getHistoryUseCase;
    late AddHistoryUseCase addHistoryUseCase;

    setUp(() {
      fakeRepo = FakeHistoryRepository();
      getHistoryUseCase = GetHistoryUseCase(fakeRepo);
      addHistoryUseCase = AddHistoryUseCase(fakeRepo);
    });

    test("GetHistoryUseCase starts empty", () {
      expect(getHistoryUseCase(), isEmpty);
    });

    test("AddHistoryUseCase adds an item and GetHistoryUseCase retrieves it", () async {
      await addHistoryUseCase(surahNumber: 1, ayahNumber: 1, pageNumber: 1);

      final history = getHistoryUseCase();
      expect(history.length, equals(1));
      expect(history.first.surahNumber, equals(1));
      expect(history.first.ayahNumber, equals(1));
      expect(history.first.pageNumber, equals(1));
    });
  });
}
