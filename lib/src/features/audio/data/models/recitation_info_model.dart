import 'package:freezed_annotation/freezed_annotation.dart';

part 'recitation_info_model.freezed.dart';
part 'recitation_info_model.g.dart';

@freezed
abstract class ReciterInfoModel with _$ReciterInfoModel {
  @JsonSerializable(explicitToJson: true)
  const factory ReciterInfoModel({
    required String link,
    required String name,
    bool? supportWordSegmentation,
    String? source,
    String? style,
    String? img,
    String? bio,
    @JsonKey(name: 'segments_url') String? segmentsUrl,
    @Default(false) bool isDownloading,
    String? showAyahHighlight,
  }) = _ReciterInfoModel;

  factory ReciterInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ReciterInfoModelFromJson(json);

  factory ReciterInfoModel.fromMap(Map<String, dynamic> json) =>
      ReciterInfoModel.fromJson(json);

  const ReciterInfoModel._();

  Map<String, dynamic> toMap() => toJson();
}
