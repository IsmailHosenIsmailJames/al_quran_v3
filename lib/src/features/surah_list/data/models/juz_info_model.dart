import 'package:freezed_annotation/freezed_annotation.dart';

part 'juz_info_model.freezed.dart';
part 'juz_info_model.g.dart';

@freezed
abstract class JuzInfoModel with _$JuzInfoModel {
  @JsonSerializable(explicitToJson: true)
  const factory JuzInfoModel({
    @JsonKey(name: 'jn') required int juzNumber,
    @JsonKey(name: 'vc') required int versesCount,
    @JsonKey(name: 'fvk') required String firstVerseKey,
    @JsonKey(name: 'lvk') required String lastVerseKey,
    @JsonKey(name: 'vm') required Map<String, String> verseMapping,
  }) = _JuzInfoModel;

  factory JuzInfoModel.fromJson(Map<String, dynamic> json) =>
      _$JuzInfoModelFromJson(json);

  factory JuzInfoModel.fromMap(Map<String, dynamic> json) =>
      JuzInfoModel.fromJson(json);

  const JuzInfoModel._();

  Map<String, dynamic> toMap() => toJson();
}
