import 'package:al_quran_v3/src/features/surah_info/domain/entities/surah_info_detail_entity.dart';
import 'package:al_quran_v3/src/features/surah_info/domain/repositories/i_surah_info_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSurahInfoUseCase {
  final ISurahInfoRepository _repository;

  GetSurahInfoUseCase(this._repository);

  Future<SurahInfoDetailEntity> execute({
    required int surahId,
    required String rawHtml,
  }) {
    return _repository.getSurahInfoDetail(
      surahId: surahId,
      rawHtml: rawHtml,
    );
  }
}
