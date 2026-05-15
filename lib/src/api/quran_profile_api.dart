import 'dart:convert';
import 'dart:developer' as developer;
import 'package:al_quran_v3/src/api/logging_client.dart';
import 'package:al_quran_v3/src/api/models/user_profile_model.dart';
import 'package:al_quran_v3/src/api/quran_auth_session.dart';
import 'package:al_quran_v3/src/api/quran_notes_api.dart'; // For QuranApiException

/// API client for the Quran Foundation User Profile endpoints.
///
/// All methods require the user to be authenticated via [QuranAuthSession].
/// Uses the pre-live API server: https://apis-prelive.quran.foundation/auth
class QuranProfileApi {
  static const String _baseUrl =
      'https://apis-prelive.quran.foundation/auth/v1/users';

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

  /// Retrieves the authenticated user's profile.
  static Future<UserProfile> getProfile() async {
    final headers = await _getHeaders();
    final response = await _client.get(
      Uri.parse('$_baseUrl/profile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final profileData = data['data'] as Map<String, dynamic>?;
      if (profileData == null) {
        throw QuranApiException(
          message: 'Server returned empty profile data',
          type: 'empty_response',
          statusCode: response.statusCode,
        );
      }
      return UserProfile.fromJson(profileData);
    } else {
      developer.log(
        'getProfile failed: ${response.statusCode} ${response.body}',
        name: 'QuranProfileApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Updates the user's personal information and avatar.
  ///
  /// [avatar] should be a Base64 encoded string with the prefix:
  /// `data:image/[a-z]+;base64,`
  static Future<UserProfile> updateProfile({
    String? firstName,
    String? lastName,
    String? bio,
    String? country,
    String? avatar,
    String? username,
  }) async {
    final headers = await _getHeaders();
    final requestBody = <String, dynamic>{};
    if (firstName != null) requestBody['firstName'] = firstName;
    if (lastName != null) requestBody['lastName'] = lastName;
    if (bio != null) requestBody['bio'] = bio;
    if (country != null) requestBody['country'] = country;
    if (avatar != null) requestBody['avatar'] = avatar;
    if (username != null) requestBody['username'] = username;

    final response = await _client.patch(
      Uri.parse('$_baseUrl/update-profile'),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final profileData = data['data'] as Map<String, dynamic>?;
      if (profileData == null) {
        throw QuranApiException(
          message: 'Server returned empty profile data',
          type: 'empty_response',
          statusCode: response.statusCode,
        );
      }
      return UserProfile.fromJson(profileData);
    } else {
      developer.log(
        'updateProfile failed: ${response.statusCode} ${response.body}',
        name: 'QuranProfileApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }

  /// Updates the user's preferences and settings.
  static Future<UserProfile> editProfile({
    int? languageId,
    bool? notifications,
    String? theme,
  }) async {
    final headers = await _getHeaders();
    final requestBody = <String, dynamic>{};
    if (languageId != null) requestBody['languageId'] = languageId;
    if (notifications != null) requestBody['notifications'] = notifications;
    if (theme != null) requestBody['theme'] = theme;

    final response = await _client.patch(
      Uri.parse('$_baseUrl/edit-profile'),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final profileData = data['data'] as Map<String, dynamic>?;
      if (profileData == null) {
        throw QuranApiException(
          message: 'Server returned empty profile data',
          type: 'empty_response',
          statusCode: response.statusCode,
        );
      }
      return UserProfile.fromJson(profileData);
    } else {
      developer.log(
        'editProfile failed: ${response.statusCode} ${response.body}',
        name: 'QuranProfileApi',
      );
      throw QuranApiException.fromResponse(response);
    }
  }
}
