import 'package:freezed_annotation/freezed_annotation.dart';

part 'surah_info_model.freezed.dart';
part 'surah_info_model.g.dart';

@freezed
abstract class SurahInfoModel with _$SurahInfoModel {
  @JsonSerializable(explicitToJson: true)
  const factory SurahInfoModel({
    required int id,
    @JsonKey(name: 'ro') required int revelationOrder,
    @JsonKey(name: 'rp') required String revelationPlace,
    @JsonKey(name: 'vc') required int versesCount,
    @JsonKey(name: 'pr') required String pagesRange,
    @Default(false) bool noBismillah,
  }) = _SurahInfoModel;

  factory SurahInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SurahInfoModelFromJson(json);

  factory SurahInfoModel.fromMap(Map<String, dynamic> json) =>
      SurahInfoModel.fromJson(json);

  const SurahInfoModel._();

  Map<String, dynamic> toMap() => toJson();
}
