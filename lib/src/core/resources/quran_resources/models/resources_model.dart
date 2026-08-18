import "package:freezed_annotation/freezed_annotation.dart";

part 'resources_model.freezed.dart';
part 'resources_model.g.dart';

enum ResourceType {
  @JsonValue('tafsir')
  tafsir,
  @JsonValue('simple')
  simple,
  @JsonValue('word_by_word')
  word_by_word,
  @JsonValue('with_footnote')
  with_footnote,
}

@freezed
abstract class ResourcesModel with _$ResourcesModel {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ResourcesModel({
    @Default('') String language,
    @Default('') String languageNative,
    @Default('') String languageCode,
    @Default('') String name,
    @Default('') String englishName,
    @Default('') String fileName,
    @Default('') String fullPath,
    @Default(ResourceType.simple) ResourceType type,
    @Default(false) bool isTajweed,
  }) = _ResourcesModel;

  factory ResourcesModel.fromJson(Map<String, dynamic> json) =>
      _$ResourcesModelFromJson(json);

  factory ResourcesModel.fromMap(Map<String, dynamic> map) =>
      ResourcesModel.fromJson(map);
}

extension ResourcesModelExtension on ResourcesModel {
  Map<String, dynamic> toMap() => toJson();
}
