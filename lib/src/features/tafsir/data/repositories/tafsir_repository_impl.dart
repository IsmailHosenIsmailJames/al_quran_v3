import 'package:al_quran_v3/src/features/tafsir/data/datasources/tafsir_local_datasource.dart';
import 'package:al_quran_v3/src/features/tafsir/data/models/tafsir_item_model.dart';
import 'package:al_quran_v3/src/features/tafsir/domain/entities/tafsir_item_entity.dart';
import 'package:al_quran_v3/src/features/tafsir/domain/repositories/i_tafsir_repository.dart';
import 'package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITafsirRepository)
class TafsirRepositoryImpl implements ITafsirRepository {
  final TafsirLocalDataSource _localDataSource;

  TafsirRepositoryImpl(this._localDataSource);

  @override
  List<ResourcesModel> getDownloadedTafsirBooks() {
    return _localDataSource.getDownloadedTafsirBooks();
  }

  @override
  Future<TafsirItemEntity?> getTafsirContent({
    required ResourcesModel book,
    required String ayahKey,
  }) async {
    final rawData = await _localDataSource.getRawTafsirForBook(book, ayahKey);
    if (rawData == null) return null;
    final model = TafsirItemModel.fromJson(rawData);
    return model.toEntity();
  }
}
