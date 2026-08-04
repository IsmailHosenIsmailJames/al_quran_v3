import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";

class SurahHeaderInfoModel {
  final SurahInfoModel surahInfoModel;
  final String startAyahKey;
  final String endAyahKey;

  SurahHeaderInfoModel(this.surahInfoModel, this.startAyahKey, this.endAyahKey);
}
