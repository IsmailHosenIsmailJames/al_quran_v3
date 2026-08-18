import 'package:freezed_annotation/freezed_annotation.dart';

part 'segments_info_model.freezed.dart';
part 'segments_info_model.g.dart';

@freezed
abstract class SegmentsInfoModel with _$SegmentsInfoModel {
  @JsonSerializable(explicitToJson: true)
  const factory SegmentsInfoModel({
    @JsonKey(name: 'surah_number') int? surahNumber,
    @JsonKey(name: 'ayah_number') int? ayahNumber,
    @JsonKey(name: 'audio_url') String? audioUrl,
    int? duration,
    List<List<int>>? segments,
  }) = _SegmentsInfoModel;

  factory SegmentsInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SegmentsInfoModelFromJson(json);

  factory SegmentsInfoModel.fromMap(Map<String, dynamic> json) =>
      SegmentsInfoModel.fromJson(json);

  const SegmentsInfoModel._();

  Map<String, dynamic> toMap() => toJson();
}
