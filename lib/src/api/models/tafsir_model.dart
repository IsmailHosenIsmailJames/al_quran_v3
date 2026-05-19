class TafsirInfo {
  final int id;
  final String name;
  final String? authorName;
  final String slug;
  final String languageName;
  final TafsirTranslatedName? translatedName;

  TafsirInfo({
    required this.id,
    required this.name,
    this.authorName,
    required this.slug,
    required this.languageName,
    this.translatedName,
  });

  factory TafsirInfo.fromJson(Map<String, dynamic> json) {
    return TafsirInfo(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      authorName: json['author_name'] as String?,
      slug: json['slug'] as String? ?? '',
      languageName: json['language_name'] as String? ?? '',
      translatedName: json['translated_name'] != null
          ? TafsirTranslatedName.fromJson(json['translated_name'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author_name': authorName,
      'slug': slug,
      'language_name': languageName,
      'translated_name': translatedName?.toJson(),
    };
  }
}

class TafsirTranslatedName {
  final String name;
  final String languageName;

  TafsirTranslatedName({
    required this.name,
    required this.languageName,
  });

  factory TafsirTranslatedName.fromJson(Map<String, dynamic> json) {
    return TafsirTranslatedName(
      name: json['name'] as String? ?? '',
      languageName: json['language_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'language_name': languageName,
    };
  }
}

class AyahTafsir {
  final Map<String, Map<String, dynamic>>? verses;
  final int resourceId;
  final String resourceName;
  final int languageId;
  final String slug;
  final TafsirTranslatedName? translatedName;
  final String text;

  AyahTafsir({
    this.verses,
    required this.resourceId,
    required this.resourceName,
    required this.languageId,
    required this.slug,
    this.translatedName,
    required this.text,
  });

  factory AyahTafsir.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, dynamic>>? parsedVerses;
    if (json['verses'] != null && json['verses'] is Map) {
      parsedVerses = {};
      (json['verses'] as Map).forEach((key, value) {
        if (value is Map) {
          parsedVerses![key.toString()] = Map<String, dynamic>.from(value);
        }
      });
    }

    return AyahTafsir(
      verses: parsedVerses,
      resourceId: json['resource_id'] as int? ?? 0,
      resourceName: json['resource_name'] as String? ?? '',
      languageId: json['language_id'] as int? ?? 0,
      slug: json['slug'] as String? ?? '',
      translatedName: json['translated_name'] != null
          ? TafsirTranslatedName.fromJson(json['translated_name'] as Map<String, dynamic>)
          : null,
      text: json['text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verses': verses,
      'resource_id': resourceId,
      'resource_name': resourceName,
      'language_id': languageId,
      'slug': slug,
      'translated_name': translatedName?.toJson(),
      'text': text,
    };
  }
}
