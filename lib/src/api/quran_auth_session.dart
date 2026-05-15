import 'dart:convert';
import 'dart:developer' as developer;

import 'package:al_quran_v3/src/api/logging_client.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

/// Manages persisted OAuth session state using Hive.
///
/// Stores access_token, refresh_token, and expiry info in the 'user' Hive box
/// so that any part of the app can make authenticated API calls.
class QuranAuthSession {
  static const String _keyAccessToken = 'auth_access_token';
  static const String _keyRefreshToken = 'auth_refresh_token';
  static const String _keyExpiresAt = 'auth_expires_at';
  static const String _keyIdToken = 'auth_id_token';

  // OAuth config (mirrors QuranAuthService)
  static const String _clientId = '1537c362-884a-4376-b064-9b071c638c61';
  static const String _tokenEndpoint =
      'https://prelive-oauth2.quran.foundation/oauth2/token';
  static const String _backendRefreshUrl =
      'https://quran-backend-delta.vercel.app/api/auth/refresh';

  static final LoggingClient _client = LoggingClient();

  static Box get _box => Hive.box('user');

  /// Saves the full token response from a successful login.
  static Future<void> saveSession(Map<String, dynamic> tokenData) async {
    final accessToken = tokenData['access_token'] as String?;
    final refreshToken = tokenData['refresh_token'] as String?;
    final expiresIn = tokenData['expires_in'];
    final idToken = tokenData['id_token'] as String?;

    if (accessToken == null) {
      developer.log(
        'Cannot save session: no access_token in response',
        name: 'QuranAuthSession',
      );
      return;
    }

    // Calculate absolute expiry time
    final expiresAt = DateTime.now().add(
      Duration(seconds: (expiresIn as int?) ?? 3600),
    );

    await _box.put(_keyAccessToken, accessToken);
    if (refreshToken != null) {
      await _box.put(_keyRefreshToken, refreshToken);
    }
    await _box.put(_keyExpiresAt, expiresAt.toIso8601String());
    if (idToken != null) {
      await _box.put(_keyIdToken, idToken);
    }

    developer.log(
      'Session saved. Expires at: $expiresAt',
      name: 'QuranAuthSession',
    );
  }

  /// Returns the current access token, or null if not logged in.
  static String? getAccessToken() {
    return _box.get(_keyAccessToken) as String?;
  }

  /// Returns the current refresh token, or null if unavailable.
  static String? getRefreshToken() {
    return _box.get(_keyRefreshToken) as String?;
  }

  /// Whether the user has a stored session (may be expired).
  static bool get isLoggedIn {
    return getAccessToken() != null;
  }

  /// Whether the access token has expired.
  static bool get isTokenExpired {
    final expiresAtStr = _box.get(_keyExpiresAt) as String?;
    if (expiresAtStr == null) return true;

    try {
      final expiresAt = DateTime.parse(expiresAtStr);
      // Consider expired 60 seconds early to avoid edge-case failures
      return DateTime.now().isAfter(
        expiresAt.subtract(const Duration(seconds: 60)),
      );
    } catch (e) {
      return true;
    }
  }

  /// Returns a valid access token, refreshing if needed.
  /// Returns null if refresh fails or no session exists.
  static Future<String?> getValidAccessToken() async {
    if (!isLoggedIn) return null;

    if (!isTokenExpired) {
      return getAccessToken();
    }

    // Try to refresh
    developer.log(
      'Access token expired, attempting refresh...',
      name: 'QuranAuthSession',
    );

    final refreshed = await refreshSession();
    if (refreshed) {
      return getAccessToken();
    }

    developer.log(
      'Token refresh failed. User needs to re-login.',
      name: 'QuranAuthSession',
    );
    return null;
  }

  /// Attempts to refresh the access token using the refresh token.
  /// Tries the backend endpoint first, then falls back to direct OAuth2.
  /// Returns true on success, false on failure.
  static Future<bool> refreshSession() async {
    final refreshToken = getRefreshToken();
    if (refreshToken == null) {
      developer.log('No refresh token available', name: 'QuranAuthSession');
      return false;
    }

    // Try 1: Backend refresh endpoint
    try {
      final response = await _client.post(
        Uri.parse(_backendRefreshUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final tokenData = jsonDecode(response.body) as Map<String, dynamic>;
        await saveSession(tokenData);
        developer.log(
          'Token refresh via backend successful!',
          name: 'QuranAuthSession',
        );
        return true;
      } else {
        developer.log(
          'Backend refresh failed (${response.statusCode}), trying direct OAuth2...',
          name: 'QuranAuthSession',
        );
      }
    } catch (e) {
      developer.log(
        'Backend refresh error: $e. Trying direct OAuth2...',
        name: 'QuranAuthSession',
      );
    }

    // Try 2: Direct OAuth2 token endpoint with grant_type=refresh_token
    try {
      final response = await _client.post(
        Uri.parse(_tokenEndpoint),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': _clientId,
        },
      );

      if (response.statusCode == 200) {
        final tokenData = jsonDecode(response.body) as Map<String, dynamic>;
        await saveSession(tokenData);
        developer.log(
          'Token refresh via direct OAuth2 successful!',
          name: 'QuranAuthSession',
        );
        return true;
      } else {
        developer.log(
          'Direct OAuth2 refresh failed: ${response.statusCode} ${response.body}',
          name: 'QuranAuthSession',
        );
        return false;
      }
    } catch (e) {
      developer.log(
        'Direct OAuth2 refresh error: $e',
        name: 'QuranAuthSession',
        error: e,
      );
      return false;
    }
  }

  /// Clears all stored auth data (logout).
  static Future<void> clearSession() async {
    await _box.delete(_keyAccessToken);
    await _box.delete(_keyRefreshToken);
    await _box.delete(_keyExpiresAt);
    await _box.delete(_keyIdToken);
    developer.log('Session cleared', name: 'QuranAuthSession');
  }

  /// The client ID used for API requests.
  static String get clientId => _clientId;
}
