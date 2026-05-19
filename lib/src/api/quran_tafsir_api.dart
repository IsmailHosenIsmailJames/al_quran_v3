import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

import 'package:al_quran_v3/src/api/logging_client.dart';
import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart'; // For QuranApiException
import 'package:al_quran_v3/src/api/models/tafsir_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// API client for the Quran Foundation Tafsir endpoints.
///
/// Handles available tafsir resources and fetching tafsir for a specific ayah.
/// Implements automatic token refresh for 401, error reporting for 403, and
/// exponential backoff for 429 rate limiting.
class QuranTafsirApi {
  static const String liveBaseUrl = 'https://apis.quran.foundation/content/api/v4';
  static const String preliveBaseUrl = 'https://apis-prelive.quran.foundation/content/api/v4';

  /// Toggle whether the API client should use pre-live or live base URL.
  /// Defaults to true to align with other pre-live APIs in the workspace.
  static bool usePrelive = true;

  static String get _baseUrl => usePrelive ? preliveBaseUrl : liveBaseUrl;

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

  /// Sends an HTTP request with built headers and handles:
  /// - 401: Token expired → re-request token and retry once
  /// - 403: Access denied → check client credentials
  /// - 429: Rate limited → implement exponential backoff
  static Future<http.Response> _sendRequest(
    String method,
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    int attempt = 0;
    const int maxRetries = 3; // total 4 attempts
    const double baseDelaySeconds = 1.0;

    while (true) {
      try {
        final requestHeaders = await _getHeaders();
        if (headers != null) {
          requestHeaders.addAll(headers);
        }

        final http.Response response;
        if (method == 'GET') {
          response = await _client.get(url, headers: requestHeaders);
        } else if (method == 'POST') {
          response = await _client.post(url, headers: requestHeaders, body: body);
        } else if (method == 'PUT') {
          response = await _client.put(url, headers: requestHeaders, body: body);
        } else if (method == 'PATCH') {
          response = await _client.patch(url, headers: requestHeaders, body: body);
        } else if (method == 'DELETE') {
          response = await _client.delete(url, headers: requestHeaders);
        } else {
          throw UnsupportedError('Unsupported HTTP method: $method');
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          return response;
        }

        // 401: Token expired -> refresh token and retry once
        if (response.statusCode == 401) {
          developer.log(
            'Received 401 Unauthorized. Attempting to refresh token...',
            name: 'QuranTafsirApi',
          );
          final refreshSuccess = await QuranAuthSession.refreshSession();
          if (refreshSuccess) {
            developer.log(
              'Token refresh successful. Retrying request once...',
              name: 'QuranTafsirApi',
            );
            // Re-fetch headers (will contain the new valid access token) and retry
            final retriedHeaders = await _getHeaders();
            if (headers != null) {
              retriedHeaders.addAll(headers);
            }
            final retryResponse = await _client.get(url, headers: retriedHeaders);
            if (retryResponse.statusCode == 200 || retryResponse.statusCode == 201) {
              return retryResponse;
            }
            // If retry still fails, throw the new response error
            throw QuranApiException.fromResponse(retryResponse);
          } else {
            developer.log(
              'Token refresh failed. Cannot retry request.',
              name: 'QuranTafsirApi',
            );
            throw QuranApiException.fromResponse(response);
          }
        }

        // 403: Access denied -> check client credentials
        if (response.statusCode == 403) {
          developer.log(
            'Received 403 Forbidden. Access denied. Please check client credentials.',
            name: 'QuranTafsirApi',
            level: 1000,
          );
          throw QuranApiException(
            message: 'Access denied. Please check your client credentials and permissions.',
            type: 'forbidden',
            statusCode: 403,
          );
        }

        // 429: Rate limited -> implement exponential backoff
        if (response.statusCode == 429) {
          if (attempt >= maxRetries) {
            developer.log(
              'Rate limited (429) and exhausted all $maxRetries retries.',
              name: 'QuranTafsirApi',
              level: 1000,
            );
            throw QuranApiException.fromResponse(response);
          }
          final delayDuration = Duration(
            milliseconds: (baseDelaySeconds * math.pow(2, attempt) * 1000).toInt(),
          );
          developer.log(
            'Received 429 Too Many Requests. Retrying in ${delayDuration.inSeconds}s (attempt ${attempt + 1}/$maxRetries)...',
            name: 'QuranTafsirApi',
          );
          await Future.delayed(delayDuration);
          attempt++;
          continue;
        }

        // For other status codes, throw the error
        throw QuranApiException.fromResponse(response);
      } catch (e) {
        if (e is QuranApiException) {
          rethrow;
        }
        developer.log(
          'Error sending request to $url: $e',
          name: 'QuranTafsirApi',
          error: e,
        );
        rethrow;
      }
    }
  }

  static const String _cacheBoxName = 'quran_tafsir_cloud_cache';
  static const int _cacheExpiryMillis = 30 * 24 * 60 * 60 * 1000; // 30 days

  /// Fetches available tafsirs from the Quran Foundation API (with a 30-day cache).
  static Future<List<TafsirInfo>> getTafsirs({String? language}) async {
    final cacheKey = 'resources_${language ?? 'en'}';
    try {
      final cacheBox = await Hive.openBox(_cacheBoxName);
      final cached = cacheBox.get(cacheKey);
      if (cached is Map) {
        final cachedAt = cached['cachedAt'] as int?;
        final dataList = cached['data'] as List<dynamic>?;
        if (cachedAt != null && dataList != null) {
          final age = DateTime.now().millisecondsSinceEpoch - cachedAt;
          if (age < _cacheExpiryMillis) {
            developer.log('Returning cached Tafsir list for $language (age: ${age ~/ 1000}s)', name: 'QuranTafsirApi');
            return dataList
                .map((e) => TafsirInfo.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList();
          }
        }
      }
    } catch (e) {
      developer.log('Cache read error in getTafsirs: $e', name: 'QuranTafsirApi');
    }

    final queryParams = <String, String>{};
    if (language != null && language.isNotEmpty) {
      queryParams['language'] = language;
    }

    final uri = Uri.parse('$_baseUrl/resources/tafsirs').replace(queryParameters: queryParams);
    
    final response = await _sendRequest('GET', uri);
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final tafsirsList = data['tafsirs'] as List<dynamic>?;
    if (tafsirsList == null) return [];

    try {
      final cacheBox = await Hive.openBox(_cacheBoxName);
      await cacheBox.put(cacheKey, {
        'cachedAt': DateTime.now().millisecondsSinceEpoch,
        'data': tafsirsList,
      });
    } catch (e) {
      developer.log('Cache write error in getTafsirs: $e', name: 'QuranTafsirApi');
    }
    
    return tafsirsList
        .map((e) => TafsirInfo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Fetches tafsir for a specific ayah using the Quran Foundation API (with a 30-day cache).
  static Future<AyahTafsir> getTafsirForAyah({
    required String resourceId,
    required String ayahKey,
    Map<String, String>? optionalParams,
  }) async {
    final cacheKey = 'tafsir_${resourceId}_${ayahKey}_${optionalParams?.toString() ?? ''}';
    try {
      final cacheBox = await Hive.openBox(_cacheBoxName);
      final cached = cacheBox.get(cacheKey);
      if (cached is Map) {
        final cachedAt = cached['cachedAt'] as int?;
        final tafsirMap = cached['data'] as Map<dynamic, dynamic>?;
        if (cachedAt != null && tafsirMap != null) {
          final age = DateTime.now().millisecondsSinceEpoch - cachedAt;
          if (age < _cacheExpiryMillis) {
            developer.log('Returning cached Tafsir for $resourceId:$ayahKey (age: ${age ~/ 1000}s)', name: 'QuranTafsirApi');
            return AyahTafsir.fromJson(Map<String, dynamic>.from(tafsirMap));
          }
        }
      }
    } catch (e) {
      developer.log('Cache read error in getTafsirForAyah: $e', name: 'QuranTafsirApi');
    }

    var uri = Uri.parse('$_baseUrl/tafsirs/$resourceId/by_ayah/$ayahKey');
    if (optionalParams != null && optionalParams.isNotEmpty) {
      uri = uri.replace(queryParameters: optionalParams);
    }

    final response = await _sendRequest('GET', uri);
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final tafsirData = data['tafsir'] as Map<String, dynamic>?;
    if (tafsirData == null) {
      throw QuranApiException(
        message: 'Server returned empty tafsir data',
        type: 'empty_response',
        statusCode: response.statusCode,
      );
    }

    try {
      final cacheBox = await Hive.openBox(_cacheBoxName);
      await cacheBox.put(cacheKey, {
        'cachedAt': DateTime.now().millisecondsSinceEpoch,
        'data': tafsirData,
      });
    } catch (e) {
      developer.log('Cache write error in getTafsirForAyah: $e', name: 'QuranTafsirApi');
    }

    return AyahTafsir.fromJson(tafsirData);
  }
}
