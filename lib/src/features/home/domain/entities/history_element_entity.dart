import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_element_entity.freezed.dart';
part 'history_element_entity.g.dart';

@freezed
abstract class HistoryElementEntity with _$HistoryElementEntity {
  @JsonSerializable(explicitToJson: true)
  const factory HistoryElementEntity({
    required int surahNumber,
    int? ayahNumber,
    int? pageNumber,
    required int timestamp,
  }) = _HistoryElementEntity;

  factory HistoryElementEntity.fromJson(Map<String, dynamic> json) =>
      _$HistoryElementEntityFromJson(json);
}
