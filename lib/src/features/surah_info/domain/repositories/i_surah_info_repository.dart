import 'package:al_quran_v3/src/features/surah_info/domain/entities/surah_info_detail_entity.dart';

abstract class ISurahInfoRepository {
  Future<SurahInfoDetailEntity> getSurahInfoDetail({
    required int surahId,
    required String rawHtml,
  });
}
