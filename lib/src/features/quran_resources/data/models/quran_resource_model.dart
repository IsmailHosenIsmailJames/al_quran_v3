import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';

part 'quran_resource_model.freezed.dart';
part 'quran_resource_model.g.dart';

@freezed
abstract class QuranResourceModel with _$QuranResourceModel {
  const factory QuranResourceModel({
    required String language,
    @JsonKey(name: 'language_native') required String languageNative,
    @JsonKey(name: 'language_code') required String languageCode,
    required String name,
    @JsonKey(name: 'english_name') required String englishName,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'full_path') required String fullPath,
    required ResourceType type,
    @JsonKey(name: 'is_tajweed') @Default(false) bool isTajweed,
  }) = _QuranResourceModel;

  factory QuranResourceModel.fromJson(Map<String, dynamic> json) =>
      _$QuranResourceModelFromJson(json);

  const QuranResourceModel._();

  QuranResourceEntity toEntity({
    bool isDownloaded = false,
    bool isSelected = false,
    bool isDownloading = false,
    double downloadProgress = 0.0,
  }) {
    return QuranResourceEntity(
      id: fullPath,
      language: language,
      languageNative: languageNative,
      languageCode: languageCode,
      name: name,
      englishName: englishName,
      fileName: fileName,
      fullPath: fullPath,
      type: type,
      isTajweed: isTajweed,
      isDownloaded: isDownloaded,
      isSelected: isSelected,
      isDownloading: isDownloading,
      downloadProgress: downloadProgress,
    );
  }

  factory QuranResourceModel.fromEntity(QuranResourceEntity entity) {
    return QuranResourceModel(
      language: entity.language,
      languageNative: entity.languageNative,
      languageCode: entity.languageCode,
      name: entity.name,
      englishName: entity.englishName,
      fileName: entity.fileName,
      fullPath: entity.fullPath,
      type: entity.type,
      isTajweed: entity.isTajweed,
    );
  }

  ResourcesModel toResourcesModel() {
    return ResourcesModel(
      language: language,
      languageNative: languageNative,
      languageCode: languageCode,
      name: name,
      englishName: englishName,
      fileName: fileName,
      fullPath: fullPath,
      type: type,
      isTajweed: isTajweed,
    );
  }

  factory QuranResourceModel.fromResourcesModel(ResourcesModel model) {
    return QuranResourceModel(
      language: model.language,
      languageNative: model.languageNative,
      languageCode: model.languageCode,
      name: model.name,
      englishName: model.englishName,
      fileName: model.fileName,
      fullPath: model.fullPath,
      type: model.type,
      isTajweed: model.isTajweed,
    );
  }
}
