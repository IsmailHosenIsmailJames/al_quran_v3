import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";

class ResourceEntity {
  final String id;
  final String name;
  final String englishName;
  final String languageCode;
  final String language;
  final String languageNative;
  final ResourceType type;
  final String fullPath;
  final String fileName;
  final bool isDownloaded;

  const ResourceEntity({
    required this.id,
    required this.name,
    required this.englishName,
    required this.languageCode,
    required this.language,
    required this.languageNative,
    required this.type,
    required this.fullPath,
    required this.fileName,
    this.isDownloaded = false,
  });

  bool get isTafsir => type == ResourceType.tafsir;
  bool get isTranslation => type == ResourceType.simple || type == ResourceType.with_footnote;
  bool get isWordByWord => type == ResourceType.word_by_word;
  bool get hasFootnote => type == ResourceType.with_footnote;

  ResourceEntity copyWith({
    String? id,
    String? name,
    String? englishName,
    String? languageCode,
    String? language,
    String? languageNative,
    ResourceType? type,
    String? fullPath,
    String? fileName,
    bool? isDownloaded,
  }) {
    return ResourceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      languageCode: languageCode ?? this.languageCode,
      language: language ?? this.language,
      languageNative: languageNative ?? this.languageNative,
      type: type ?? this.type,
      fullPath: fullPath ?? this.fullPath,
      fileName: fileName ?? this.fileName,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fullPath == other.fullPath &&
          fileName == other.fileName;

  @override
  int get hashCode => id.hashCode ^ fullPath.hashCode ^ fileName.hashCode;
}
