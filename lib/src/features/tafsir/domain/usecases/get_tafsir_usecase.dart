import 'package:al_quran_v3/src/features/tafsir/domain/entities/tafsir_item_entity.dart';
import 'package:al_quran_v3/src/features/tafsir/domain/repositories/i_tafsir_repository.dart';
import 'package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTafsirUseCase {
  final ITafsirRepository _repository;

  GetTafsirUseCase(this._repository);

  List<ResourcesModel> getDownloadedBooks() {
    return _repository.getDownloadedTafsirBooks();
  }

  Future<TafsirItemEntity?> getContent({
    required ResourcesModel book,
    required String ayahKey,
  }) {
    return _repository.getTafsirContent(book: book, ayahKey: ayahKey);
  }
}
