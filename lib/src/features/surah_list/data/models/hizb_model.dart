import 'package:freezed_annotation/freezed_annotation.dart';

part 'hizb_model.freezed.dart';
part 'hizb_model.g.dart';

@freezed
abstract class HizbModel with _$HizbModel {
  @JsonSerializable(explicitToJson: true)
  const factory HizbModel({
    @JsonKey(name: 'hn') required int hizbNumber,
    @JsonKey(name: 'vc') required int versesCount,
    @JsonKey(name: 'fvk') required String firstVerseKey,
    @JsonKey(name: 'lvk') required String lastVerseKey,
    @JsonKey(name: 'vm') required Map<String, String> verseMapping,
  }) = _HizbModel;

  factory HizbModel.fromJson(Map<String, dynamic> json) =>
      _$HizbModelFromJson(json);

  factory HizbModel.fromMap(Map<String, dynamic> json) =>
      HizbModel.fromJson(json);

  const HizbModel._();

  Map<String, dynamic> toMap() => toJson();
}
