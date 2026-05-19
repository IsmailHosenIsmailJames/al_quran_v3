import 'dart:convert';
import 'dart:developer' as developer;
import 'package:al_quran_v3/src/api/logging_client.dart';
import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart'; // For QuranApiException

class QuranSearchApi {
  // Using the base URL consistent with other pre-live APIs if applicable,
  // or the standard one if not. The doc mentioned /api/v1/search.
  static const String _baseUrl =
      'https://apis-prelive.quran.foundation/search/api/v1/search';

  static final LoggingClient _client = LoggingClient();

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

  static Future<Map<String, dynamic>> search({
    required String query,
    String mode = 'advanced',
    String? translationIds,
  }) async {
    final headers = await _getHeaders();
    final queryParams = {
      'query': query,
      'mode': mode,
      if (translationIds != null) 'translation_ids': translationIds,
    };

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
    final response = await _client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      developer.log(
        'search failed: ${response.statusCode} ${response.body}',
        name: 'QuranSearchApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }
}
