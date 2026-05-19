import 'package:flutter_test/flutter_test.dart';
import 'package:al_quran_v3/src/api/models/tafsir_model.dart';

void main() {
  group('TafsirInfo Model Tests', () {
    test('should parse TafsirInfo from JSON successfully', () {
      final json = {
        'id': 169,
        'name': 'Ibn Kathir (Abridged)',
        'author_name': 'Hafiz Ibn Kathir',
        'slug': 'en-tafisr-ibn-kathir',
        'language_name': 'english',
        'translated_name': {
          'name': 'তাফসীর ইবনে কাছীর',
          'language_name': 'bengali',
        }
      };

      final model = TafsirInfo.fromJson(json);

      expect(model.id, 169);
      expect(model.name, 'Ibn Kathir (Abridged)');
      expect(model.authorName, 'Hafiz Ibn Kathir');
      expect(model.slug, 'en-tafisr-ibn-kathir');
      expect(model.languageName, 'english');
      expect(model.translatedName, isNotNull);
      expect(model.translatedName!.name, 'তাফসীর ইবনে কাছীর');
      expect(model.translatedName!.languageName, 'bengali');
    });

    test('should parse TafsirInfo with null optional fields', () {
      final json = {
        'id': 926,
        'name': 'Arabic Jalalayn Tafseer',
        'author_name': null,
        'slug': 'ar-tafsir-jalalayn',
        'language_name': 'arabic',
        'translated_name': null,
      };

      final model = TafsirInfo.fromJson(json);

      expect(model.id, 926);
      expect(model.name, 'Arabic Jalalayn Tafseer');
      expect(model.authorName, isNull);
      expect(model.slug, 'ar-tafsir-jalalayn');
      expect(model.languageName, 'arabic');
      expect(model.translatedName, isNull);
    });

    test('should convert TafsirInfo to JSON successfully', () {
      final model = TafsirInfo(
        id: 169,
        name: 'Ibn Kathir',
        authorName: 'Ibn Kathir',
        slug: 'ibn-kathir',
        languageName: 'english',
        translatedName: TafsirTranslatedName(
          name: 'Tafseer',
          languageName: 'english',
        ),
      );

      final json = model.toJson();

      expect(json['id'], 169);
      expect(json['name'], 'Ibn Kathir');
      expect(json['author_name'], 'Ibn Kathir');
      expect(json['slug'], 'ibn-kathir');
      expect(json['language_name'], 'english');
      expect(json['translated_name'], isNotNull);
      expect(json['translated_name']['name'], 'Tafseer');
      expect(json['translated_name']['language_name'], 'english');
    });
  });

  group('AyahTafsir Model Tests', () {
    test('should parse AyahTafsir from JSON successfully', () {
      final json = {
        'verses': {
          '1:1': {'id': 1}
        },
        'resource_id': 169,
        'resource_name': 'Ibn Kathir (Abridged)',
        'language_id': 38,
        'slug': 'en-tafisr-ibn-kathir',
        'translated_name': {
          'name': 'Ibn Kathir (Abridged)',
          'language_name': 'english',
        },
        'text': '<h1>Introduction to Fatihah...</h1>'
      };

      final model = AyahTafsir.fromJson(json);

      expect(model.resourceId, 169);
      expect(model.resourceName, 'Ibn Kathir (Abridged)');
      expect(model.languageId, 38);
      expect(model.slug, 'en-tafisr-ibn-kathir');
      expect(model.translatedName, isNotNull);
      expect(model.translatedName!.name, 'Ibn Kathir (Abridged)');
      expect(model.translatedName!.languageName, 'english');
      expect(model.text, '<h1>Introduction to Fatihah...</h1>');
      expect(model.verses, isNotNull);
      expect(model.verses!['1:1'], isNotNull);
      expect(model.verses!['1:1']!['id'], 1);
    });

    test('should convert AyahTafsir to JSON successfully', () {
      final model = AyahTafsir(
        verses: {
          '1:1': {'id': 1}
        },
        resourceId: 169,
        resourceName: 'Ibn Kathir',
        languageId: 38,
        slug: 'ibn-kathir',
        translatedName: TafsirTranslatedName(
          name: 'Ibn Kathir',
          languageName: 'english',
        ),
        text: 'Tafsir text here',
      );

      final json = model.toJson();

      expect(json['resource_id'], 169);
      expect(json['resource_name'], 'Ibn Kathir');
      expect(json['language_id'], 38);
      expect(json['slug'], 'ibn-kathir');
      expect(json['translated_name']['name'], 'Ibn Kathir');
      expect(json['text'], 'Tafsir text here');
      expect(json['verses']['1:1']['id'], 1);
    });
  });
}
