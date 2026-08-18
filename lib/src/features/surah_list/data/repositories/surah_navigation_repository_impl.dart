import 'package:al_quran_v3/src/features/surah_list/data/datasources/surah_navigation_local_datasource.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/hizb_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/juz_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/page_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/ruku_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/domain/repositories/i_surah_navigation_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISurahNavigationRepository)
class SurahNavigationRepositoryImpl implements ISurahNavigationRepository {
  final SurahNavigationLocalDataSource _localDataSource;

  SurahNavigationRepositoryImpl(this._localDataSource);

  @override
  List<SurahInfoModel> getAllSurahs() => _localDataSource.getAllSurahs();

  @override
  List<JuzInfoModel> getAllJuzs() => _localDataSource.getAllJuzs();

  @override
  List<PageInfoModel> getAllPages() => _localDataSource.getAllPages();

  @override
  List<HizbModel> getAllHizbs() => _localDataSource.getAllHizbs();

  @override
  List<RukuInfoModel> getAllRukus() => _localDataSource.getAllRukus();
}
