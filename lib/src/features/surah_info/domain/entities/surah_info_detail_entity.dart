import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah_info_detail_entity.freezed.dart';
part 'surah_info_detail_entity.g.dart';

@freezed
abstract class SurahInfoDetailEntity with _$SurahInfoDetailEntity {
  const factory SurahInfoDetailEntity({
    required int surahId,
    required String title,
    required String htmlContent,
  }) = _SurahInfoDetailEntity;

  factory SurahInfoDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$SurahInfoDetailEntityFromJson(json);
}
