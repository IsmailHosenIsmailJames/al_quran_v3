import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'surah_header_info.freezed.dart';

@freezed
abstract class SurahHeaderInfoModel with _$SurahHeaderInfoModel {
  const factory SurahHeaderInfoModel({
    required SurahInfoModel surahInfoModel,
    required String startAyahKey,
    required String endAyahKey,
  }) = _SurahHeaderInfoModel;
}
