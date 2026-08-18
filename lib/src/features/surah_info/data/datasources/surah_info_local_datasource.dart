import 'package:injectable/injectable.dart';

@lazySingleton
class SurahInfoLocalDataSource {
  Future<Map<String, dynamic>> getSurahInfoRawData({
    required int surahId,
    required String rawHtml,
  }) async {
    return {
      'surahId': surahId,
      'title': 'Surah $surahId',
      'htmlContent': rawHtml,
    };
  }
}
