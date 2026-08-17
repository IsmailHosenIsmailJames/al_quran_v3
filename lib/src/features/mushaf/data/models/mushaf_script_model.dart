import "dart:convert";
import "package:freezed_annotation/freezed_annotation.dart";

part 'mushaf_script_model.freezed.dart';
part 'mushaf_script_model.g.dart';

enum LineType {
  @JsonValue("ayah")
  ayah,
  @JsonValue("basmallah")
  basmallah,
  @JsonValue("surah_name")
  surahName,
}

@freezed
abstract class MushafScriptPageModel with _$MushafScriptPageModel {
  const MushafScriptPageModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MushafScriptPageModel({
    @JsonKey(name: "page_number") required int pageNumber,
    required List<MushafLine> lines,
  }) = _MushafScriptPageModel;

  factory MushafScriptPageModel.fromJson(Map<String, dynamic> json) =>
      _$MushafScriptPageModelFromJson(json);

  factory MushafScriptPageModel.fromJsonString(String str) =>
      MushafScriptPageModel.fromJson(json.decode(str) as Map<String, dynamic>);

  factory MushafScriptPageModel.fromMap(Map<String, dynamic> map) =>
      MushafScriptPageModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
  String toJsonString() => json.encode(toJson());
}

@freezed
abstract class MushafLine with _$MushafLine {
  const MushafLine._();

  @JsonSerializable(explicitToJson: true)
  const factory MushafLine({
    @JsonKey(name: "line_number") required int lineNumber,
    @JsonKey(name: "line_type") required LineType lineType,
    @JsonKey(name: "is_centered") required bool isCentered,
    @JsonKey(name: "surah_number") dynamic surahNumber,
    required String content,
    @JsonKey(name: "first_word_id") int? firstWordId,
    @JsonKey(name: "last_word_id") int? lastWordId,
  }) = _MushafLine;

  factory MushafLine.fromJson(Map<String, dynamic> json) =>
      _$MushafLineFromJson(json);

  factory MushafLine.fromMap(Map<String, dynamic> map) =>
      MushafLine.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

final lineTypeValues = EnumValues({
  "ayah": LineType.ayah,
  "basmallah": LineType.basmallah,
  "surah_name": LineType.surahName,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
