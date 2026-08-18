import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/features/home/domain/entities/history_element_entity.dart';

part 'history_element_model.freezed.dart';
part 'history_element_model.g.dart';

@freezed
abstract class HistoryElementModel with _$HistoryElementModel {
  const HistoryElementModel._();

  @JsonSerializable(explicitToJson: true)
  const factory HistoryElementModel({
    required int surahNumber,
    int? ayahNumber,
    int? pageNumber,
    required int timestamp,
  }) = _HistoryElementModel;

  factory HistoryElementModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryElementModelFromJson(json);

  factory HistoryElementModel.fromEntity(HistoryElementEntity entity) {
    return HistoryElementModel(
      surahNumber: entity.surahNumber,
      ayahNumber: entity.ayahNumber,
      pageNumber: entity.pageNumber,
      timestamp: entity.timestamp,
    );
  }

  HistoryElementEntity toEntity() {
    return HistoryElementEntity(
      surahNumber: surahNumber,
      ayahNumber: ayahNumber,
      pageNumber: pageNumber,
      timestamp: timestamp,
    );
  }
}
