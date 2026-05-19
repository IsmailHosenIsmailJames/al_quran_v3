import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:al_quran_v3/src/api/logging_client.dart';
import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:app_links/app_links.dart';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

class QuranAuthService {
  /// OAuth Configuration
  static const String clientId = '1537c362-884a-4376-b064-9b071c638c61';
  static const String redirectUrl =
      'https://quran-backend-delta.vercel.app/oauth/callback';
  static const String backendExchangeUrl =
      'https://quran-backend-delta.vercel.app/api/auth/exchange';
  static const String authorizationEndpoint =
      'https://prelive-oauth2.quran.foundation/oauth2/auth';

  static final LoggingClient _client = LoggingClient();

  /// Generates a cryptographically secure code verifier for PKCE.
  static String _generateCodeVerifier() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  /// Generates a code challenge from the verifier using SHA-256.
  static String _generateCodeChallenge(String codeVerifier) {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  /// Generates a random state string for CSRF protection.
  static String _generateState() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Url.encode(bytes).replaceAll('=', '');
  }

  /// Initiates the OAuth 2.0 PKCE flow manually.
  ///
  /// 1. Opens browser to Quran Foundation login page.
  /// 2. After login, Quran Foundation redirects to our Vercel callback.
  /// 3. Vercel callback redirects to our app's custom scheme.
  /// 4. We receive the code via deep link and exchange it on the backend.
  static Future<Map<String, dynamic>?> login() async {
    try {
      developer.log(
        'Starting OAuth Authorization Flow...',
        name: 'QuranAuthService',
      );

      // 1. Generate PKCE parameters
      final codeVerifier = _generateCodeVerifier();
      final codeChallenge = _generateCodeChallenge(codeVerifier);
      final state = _generateState();

      // 2. Build the authorization URL
      final authUrl = Uri.https(
        'prelive-oauth2.quran.foundation',
        '/oauth2/auth',
        {
          'response_type': 'code',
          'client_id': clientId,
          'redirect_uri': redirectUrl,
          'scope':
              'openid offline_access user bookmark note collection search content',
          'code_challenge': codeChallenge,
          'code_challenge_method': 'S256',
          'state': state,
        },
      );

      developer.log('Authorization URL: $authUrl', name: 'QuranAuthService');

      // 3. Set up deep link listener BEFORE opening the browser
      final appLinks = AppLinks();
      final completer = Completer<Uri?>();

      // Listen for the redirect back from the Vercel callback page
      final subscription = appLinks.uriLinkStream.listen((uri) {
        developer.log('Received deep link: $uri', name: 'QuranAuthService');
        if (uri.scheme == 'com.ismailhosenjames.albayanquran') {
          if (!completer.isCompleted) {
            completer.complete(uri);
          }
        }
      });

      // 4. Open the browser
      final launched = await launchUrl(
        authUrl,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        developer.log('Failed to open browser', name: 'QuranAuthService');
        subscription.cancel();
        return null;
      }

      // 5. Wait for the deep link (with a timeout)
      final Uri? callbackUri = await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () => null,
      );

      // Clean up the listener
      subscription.cancel();

      if (callbackUri == null) {
        developer.log(
          'Login timed out or was cancelled.',
          name: 'QuranAuthService',
        );
        return null;
      }

      // 6. Extract the authorization code
      final code = callbackUri.queryParameters['code'];
      final returnedState = callbackUri.queryParameters['state'];
      final error = callbackUri.queryParameters['error'];

      if (error != null) {
        developer.log('OAuth error: $error', name: 'QuranAuthService');
        return null;
      }

      if (code == null) {
        developer.log(
          'No authorization code received.',
          name: 'QuranAuthService',
        );
        return null;
      }

      // Verify state matches (CSRF protection)
      if (returnedState != state) {
        developer.log(
          'State mismatch! Possible CSRF attack.',
          name: 'QuranAuthService',
          level: 1000,
        );
        return null;
      }

      developer.log(
        'Authorization code received. Exchanging on backend...',
        name: 'QuranAuthService',
      );

      // 7. Exchange the code on our secure backend
      final exchangeResponse = await _client.post(
        Uri.parse(backendExchangeUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': code,
          'code_verifier': codeVerifier,
          'redirect_uri': redirectUrl,
        }),
      );

      if (exchangeResponse.statusCode == 200) {
        final tokenData =
            jsonDecode(exchangeResponse.body) as Map<String, dynamic>;
        developer.log('Token exchange successful!', name: 'QuranAuthService');
        // Persist the session for app-wide access
        await QuranAuthSession.saveSession(tokenData);
        return tokenData;
      } else {
        developer.log(
          'Backend exchange failed: ${exchangeResponse.body}',
          name: 'QuranAuthService',
          level: 1000,
        );
        return null;
      }
    } catch (e) {
      developer.log(
        'Authentication Error: $e',
        name: 'QuranAuthService',
        error: e,
      );
      return null;
    }
  }

  /// Logs out the user by clearing the persisted session.
  static Future<void> logout() async {
    await QuranAuthSession.clearSession();
    developer.log('User logged out', name: 'QuranAuthService');
  }
}
