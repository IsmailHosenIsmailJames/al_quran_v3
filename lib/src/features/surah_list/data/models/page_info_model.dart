import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_info_model.freezed.dart';
part 'page_info_model.g.dart';

@freezed
abstract class PageInfoModel with _$PageInfoModel {
  @JsonSerializable(explicitToJson: true)
  const factory PageInfoModel({
    @JsonKey(name: 's') required int start,
    @JsonKey(name: 'e') required int end,
    @JsonKey(name: 'sn') required int surahNumber,
    @JsonKey(name: 'i') required int pageNumber,
  }) = _PageInfoModel;

  factory PageInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PageInfoModelFromJson(json);

  factory PageInfoModel.fromMap(Map<String, dynamic> json) =>
      PageInfoModel.fromJson(json);

  const PageInfoModel._();

  Map<String, dynamic> toMap() => toJson();
}
