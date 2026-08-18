import 'package:freezed_annotation/freezed_annotation.dart';

part 'ruku_info_model.freezed.dart';
part 'ruku_info_model.g.dart';

@freezed
abstract class RukuInfoModel with _$RukuInfoModel {
  @JsonSerializable(explicitToJson: true)
  const factory RukuInfoModel({
    @JsonKey(name: 'rn') required int rukuNumber,
    @JsonKey(name: 'srn') required int surahRukuNumber,
    @JsonKey(name: 'vc') required int versesCount,
    @JsonKey(name: 'fvk') required String firstVerseKey,
    @JsonKey(name: 'lvk') required String lastVerseKey,
    @JsonKey(name: 'vm') required Map<String, String> verseMapping,
  }) = _RukuInfoModel;

  factory RukuInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RukuInfoModelFromJson(json);

  factory RukuInfoModel.fromMap(Map<String, dynamic> json) =>
      RukuInfoModel.fromJson(json);

  const RukuInfoModel._();

  Map<String, dynamic> toMap() => toJson();
}
