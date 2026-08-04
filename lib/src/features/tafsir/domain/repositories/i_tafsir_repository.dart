import 'package:al_quran_v3/src/features/tafsir/domain/entities/tafsir_item_entity.dart';
import 'package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart';

abstract class ITafsirRepository {
  List<ResourcesModel> getDownloadedTafsirBooks();
  Future<TafsirItemEntity?> getTafsirContent({
    required ResourcesModel book,
    required String ayahKey,
  });
}
