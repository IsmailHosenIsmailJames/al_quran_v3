import 'dart:convert';
import 'dart:developer' as developer;

import 'package:al_quran_v3/src/api/models/api_bookmark_model.dart';
import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart'; // For QuranApiException
import 'package:http/http.dart' as http;

/// API client for the Quran Foundation Bookmarks endpoints.
class QuranBookmarkApi {
  static const String _baseUrl =
      'https://apis-prelive.quran.foundation/auth/v1/bookmarks';

  /// Builds the standard auth headers for API requests.
  static Future<Map<String, String>> _getHeaders() async {
    final accessToken = await QuranAuthSession.getValidAccessToken();
    if (accessToken == null) {
      throw QuranApiException(
        message: 'Not authenticated. Please login first.',
        type: 'unauthorized',
        statusCode: 401,
      );
    }

    return {
      'Content-Type': 'application/json',
      'x-auth-token': accessToken,
      'x-client-id': QuranAuthSession.clientId,
    };
  }

  /// Fetches all bookmarks for the authenticated user.
  static Future<List<ApiBookmarkModel>> getBookmarks() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse(_baseUrl), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final bookmarksList = data['data'] as List<dynamic>?;
      if (bookmarksList == null) return [];
      return bookmarksList
          .map((e) => ApiBookmarkModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      developer.log(
        'getBookmarks failed: ${response.statusCode} ${response.body}',
        name: 'QuranBookmarkApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Adds a new bookmark.
  static Future<ApiBookmarkModel> addBookmark({
    required String key, // surah number as string
    required String type, // "ayah"
    int? verseNumber,
  }) async {
    final headers = await _getHeaders();
    final requestBody = {
      'key': key,
      'type': type,
      if (verseNumber != null) 'verseNumber': verseNumber,
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final bookmarkData = data['data'] as Map<String, dynamic>?;
      if (bookmarkData == null) {
        throw QuranApiException(
          message: 'Server returned empty bookmark data',
          type: 'empty_response',
          statusCode: response.statusCode,
        );
      }
      return ApiBookmarkModel.fromJson(bookmarkData);
    } else {
      developer.log(
        'addBookmark failed: ${response.statusCode} ${response.body}',
        name: 'QuranBookmarkApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Deletes a bookmark by its server ID.
  static Future<void> deleteBookmark(String bookmarkId) async {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$bookmarkId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      developer.log('Bookmark $bookmarkId deleted', name: 'QuranBookmarkApi');
    } else {
      developer.log(
        'deleteBookmark failed: ${response.statusCode} ${response.body}',
        name: 'QuranBookmarkApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }
}
