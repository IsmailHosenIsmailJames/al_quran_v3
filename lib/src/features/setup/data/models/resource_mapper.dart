import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/models/resources_model.dart";

class ResourceMapper {
  static ResourceEntity toEntity(ResourcesModel model, {bool isDownloaded = false}) {
    return ResourceEntity(
      id: "${model.languageCode}_${model.fileName}",
      name: model.name,
      englishName: model.englishName,
      languageCode: model.languageCode,
      language: model.language,
      languageNative: model.languageNative,
      type: model.type,
      fullPath: model.fullPath,
      fileName: model.fileName,
      isDownloaded: isDownloaded,
    );
  }

  static ResourcesModel toModel(ResourceEntity entity) {
    return ResourcesModel(
      name: entity.name,
      englishName: entity.englishName,
      languageCode: entity.languageCode,
      language: entity.language,
      languageNative: entity.languageNative,
      type: entity.type,
      fullPath: entity.fullPath,
      fileName: entity.fileName,
    );
  }
}
