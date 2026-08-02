import 'package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_entity.freezed.dart';
part 'resource_entity.g.dart';

@freezed
abstract class ResourceEntity with _$ResourceEntity {
  const factory ResourceEntity({
    required String id,
    required String name,
    @JsonKey(name: 'english_name') required String englishName,
    @JsonKey(name: 'language_code') required String languageCode,
    required String language,
    @JsonKey(name: 'language_native') required String languageNative,
    required ResourceType type,
    @JsonKey(name: 'full_path') required String fullPath,
    @JsonKey(name: 'file_name') required String fileName,
    @Default(false) bool isDownloaded,
  }) = _ResourceEntity;

  factory ResourceEntity.fromJson(Map<String, dynamic> json) =>
      _$ResourceEntityFromJson(json);

  const ResourceEntity._();

  bool get isTafsir => type == ResourceType.tafsir;
  bool get isTranslation =>
      type == ResourceType.simple || type == ResourceType.with_footnote;
  bool get isWordByWord => type == ResourceType.word_by_word;
  bool get hasFootnote => type == ResourceType.with_footnote;
}
