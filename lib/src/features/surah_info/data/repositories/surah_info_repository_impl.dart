import 'package:al_quran_v3/src/features/surah_info/data/datasources/surah_info_local_datasource.dart';
import 'package:al_quran_v3/src/features/surah_info/data/models/surah_info_detail_model.dart';
import 'package:al_quran_v3/src/features/surah_info/domain/entities/surah_info_detail_entity.dart';
import 'package:al_quran_v3/src/features/surah_info/domain/repositories/i_surah_info_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISurahInfoRepository)
class SurahInfoRepositoryImpl implements ISurahInfoRepository {
  final SurahInfoLocalDataSource _localDataSource;

  SurahInfoRepositoryImpl(this._localDataSource);

  @override
  Future<SurahInfoDetailEntity> getSurahInfoDetail({
    required int surahId,
    required String rawHtml,
  }) async {
    final rawData = await _localDataSource.getSurahInfoRawData(
      surahId: surahId,
      rawHtml: rawHtml,
    );
    final model = SurahInfoDetailModel.fromJson(rawData);
    return model.toEntity();
  }
}
