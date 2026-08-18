import 'package:al_quran_v3/src/features/surah_list/data/models/hizb_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/juz_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/page_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/ruku_info_model.dart';
import 'package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SurahNavigationLocalDataSource {
  List<SurahInfoModel> getAllSurahs() => [];
  List<JuzInfoModel> getAllJuzs() => [];
  List<PageInfoModel> getAllPages() => [];
  List<HizbModel> getAllHizbs() => [];
  List<RukuInfoModel> getAllRukus() => [];
}
