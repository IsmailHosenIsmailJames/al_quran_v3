import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/features/surah_info/domain/entities/surah_info_detail_entity.dart';

part 'surah_info_detail_model.freezed.dart';
part 'surah_info_detail_model.g.dart';

@freezed
abstract class SurahInfoDetailModel with _$SurahInfoDetailModel {
  const factory SurahInfoDetailModel({
    required int surahId,
    required String title,
    required String htmlContent,
  }) = _SurahInfoDetailModel;

  factory SurahInfoDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SurahInfoDetailModelFromJson(json);

  const SurahInfoDetailModel._();

  SurahInfoDetailEntity toEntity() {
    return SurahInfoDetailEntity(
      surahId: surahId,
      title: title,
      htmlContent: htmlContent,
    );
  }
}
