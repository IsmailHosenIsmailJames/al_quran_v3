import 'package:al_quran_v3/src/features/surah_list/data/models/hizb_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/juz_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/page_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/ruku_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/domain/repositories/i_surah_navigation_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSurahNavigationUseCase {
  final ISurahNavigationRepository _repository;

  GetSurahNavigationUseCase(this._repository);

  List<SurahInfoModel> getSurahs() => _repository.getAllSurahs();
  List<JuzInfoModel> getJuzs() => _repository.getAllJuzs();
  List<PageInfoModel> getPages() => _repository.getAllPages();
  List<HizbModel> getHizbs() => _repository.getAllHizbs();
  List<RukuInfoModel> getRukus() => _repository.getAllRukus();
}
