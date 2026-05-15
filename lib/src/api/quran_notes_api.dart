import 'dart:convert';
import 'dart:developer' as developer;

import 'package:al_quran_v3/src/api/logging_client.dart';
import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/screen/collections/models/api_note_model.dart';
import 'package:http/http.dart' as http show Response;

/// Exception thrown when the Quran Foundation API returns an error response.
///
/// The error shape is: `{"message": "...", "type": "...", "success": false}`
class QuranApiException implements Exception {
  final String message;
  final String type;
  final int statusCode;

  QuranApiException({
    required this.message,
    required this.type,
    required this.statusCode,
  });

  factory QuranApiException.fromResponse(http.Response response) {
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return QuranApiException(
        message: body['message'] as String? ?? 'Unknown error',
        type: body['type'] as String? ?? 'unknown',
        statusCode: response.statusCode,
      );
    } catch (_) {
      return QuranApiException(
        message: 'HTTP ${response.statusCode}: ${response.body}',
        type: 'unknown',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  String toString() => message;
}

/// API client for the Quran Foundation Notes endpoints.
///
/// All methods require the user to be authenticated via [QuranAuthSession].
/// Uses the pre-live API server: https://apis-prelive.quran.foundation/auth
///
/// Methods throw [QuranApiException] on API errors so callers can display
/// the server's error message to the user.
class QuranNotesApi {
  static const String _baseUrl =
      'https://apis-prelive.quran.foundation/auth/v1/notes';

  static final LoggingClient _client = LoggingClient();

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

  /// Fetches all notes for the authenticated user.
  static Future<List<ApiNoteModel>> getAllNotes({
    String? cursor,
    int? limit,
    String? sortBy,
  }) async {
    final headers = await _getHeaders();

    final queryParams = <String, String>{};
    if (cursor != null) queryParams['cursor'] = cursor;
    if (limit != null) queryParams['limit'] = limit.toString();
    if (sortBy != null) queryParams['sortBy'] = sortBy;

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
    final response = await _client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final notesList = data['data'] as List<dynamic>?;
      if (notesList == null) return [];
      return notesList
          .map((e) => ApiNoteModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      developer.log(
        'getAllNotes failed: ${response.statusCode} ${response.body}',
        name: 'QuranNotesApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Creates a new note on the server.
  static Future<ApiNoteModel> addNote({
    required String body,
    List<String>? ranges,
    bool saveToQR = false,
  }) async {
    final headers = await _getHeaders();

    final requestBody = <String, dynamic>{'body': body, 'saveToQR': saveToQR};
    if (ranges != null && ranges.isNotEmpty) {
      requestBody['ranges'] = ranges;
    }

    final response = await _client.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final noteData = data['data'] as Map<String, dynamic>?;
      if (noteData == null) {
        throw QuranApiException(
          message: 'Server returned empty note data',
          type: 'empty_response',
          statusCode: response.statusCode,
        );
      }
      return ApiNoteModel.fromJson(noteData);
    } else {
      developer.log(
        'addNote failed: ${response.statusCode} ${response.body}',
        name: 'QuranNotesApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Updates an existing note by its server ID.
  static Future<ApiNoteModel> updateNote({
    required String noteId,
    required String body,
    bool? saveToQR,
  }) async {
    final headers = await _getHeaders();

    final requestBody = <String, dynamic>{'body': body};
    if (saveToQR != null) {
      requestBody['saveToQR'] = saveToQR;
    }

    final response = await _client.patch(
      Uri.parse('$_baseUrl/$noteId'),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final noteData = data['data'] as Map<String, dynamic>?;
      if (noteData == null) {
        throw QuranApiException(
          message: 'Server returned empty note data',
          type: 'empty_response',
          statusCode: response.statusCode,
        );
      }
      return ApiNoteModel.fromJson(noteData);
    } else {
      developer.log(
        'updateNote failed: ${response.statusCode} ${response.body}',
        name: 'QuranNotesApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Deletes a note by its server ID.
  static Future<void> deleteNote(String noteId) async {
    final headers = await _getHeaders();

    final response = await _client.delete(
      Uri.parse('$_baseUrl/$noteId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      developer.log('Note $noteId deleted', name: 'QuranNotesApi');
    } else {
      developer.log(
        'deleteNote failed: ${response.statusCode} ${response.body}',
        name: 'QuranNotesApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Gets a single note by its server ID.
  static Future<ApiNoteModel> getNoteById(String noteId) async {
    final headers = await _getHeaders();

    final response = await _client.get(
      Uri.parse('$_baseUrl/$noteId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final noteData = data['data'] as Map<String, dynamic>?;
      if (noteData == null) {
        throw QuranApiException(
          message: 'Note not found',
          type: 'empty_response',
          statusCode: response.statusCode,
        );
      }
      return ApiNoteModel.fromJson(noteData);
    } else {
      developer.log(
        'getNoteById failed: ${response.statusCode} ${response.body}',
        name: 'QuranNotesApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Gets notes associated with a specific verse key (e.g. "2:255").
  static Future<List<ApiNoteModel>> getNotesByVerse(String verseKey) async {
    final headers = await _getHeaders();

    final response = await _client.get(
      Uri.parse('$_baseUrl/by-verse/$verseKey'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final notesList = data['data'] as List<dynamic>?;
      if (notesList == null) return [];
      return notesList
          .map((e) => ApiNoteModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      developer.log(
        'getNotesByVerse failed: ${response.statusCode} ${response.body}',
        name: 'QuranNotesApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }
}
