import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart';

part 'quran_resource_entity.freezed.dart';

@freezed
abstract class QuranResourceEntity with _$QuranResourceEntity {
  const factory QuranResourceEntity({
    required String id,
    required String language,
    required String languageNative,
    required String languageCode,
    required String name,
    required String englishName,
    required String fileName,
    required String fullPath,
    required ResourceType type,
    @Default(false) bool isTajweed,
    @Default(false) bool isDownloaded,
    @Default(false) bool isSelected,
    @Default(false) bool isDownloading,
    @Default(0.0) double downloadProgress,
  }) = _QuranResourceEntity;

  const QuranResourceEntity._();

  bool get isTafsir => type == ResourceType.tafsir;
  bool get isTranslation =>
      type == ResourceType.simple || type == ResourceType.with_footnote;
  bool get isWordByWord => type == ResourceType.word_by_word;
  bool get hasFootnote => type == ResourceType.with_footnote;
}
