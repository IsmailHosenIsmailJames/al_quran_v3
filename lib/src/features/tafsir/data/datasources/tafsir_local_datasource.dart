import 'package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart';
import 'package:al_quran_v3/src/features/quran_resources/data/utils/quran_tafsir_function.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TafsirLocalDataSource {
  List<ResourcesModel> getDownloadedTafsirBooks() {
    return QuranTafsirFunction.getDownloadedTafsirBooks();
  }

  Future<Map<String, dynamic>?> getRawTafsirForBook(
    ResourcesModel book,
    String ayahKey,
  ) async {
    final tafsirData = await QuranTafsirFunction.getTafsirForBook(book, ayahKey);
    if (tafsirData == null) return null;
    final text = (tafsirData.tafsir['text'] as String?) ?? '';
    return {
      'bookName': book.name,
      'ayahKey': ayahKey,
      'text': text,
    };
  }
}
