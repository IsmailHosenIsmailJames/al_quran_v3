import "dart:io";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";

class RingtoneResult {
  final String uri;
  final String title;

  const RingtoneResult({required this.uri, required this.title});

  factory RingtoneResult.fromMap(Map<dynamic, dynamic> map) {
    return RingtoneResult(
      uri: map["uri"] as String? ?? "",
      title: map["title"] as String? ?? "Default",
    );
  }
}

class RingtoneService {
  static const MethodChannel _channel =
      MethodChannel("com.ismail_hosen_james.al_quran_v3/ringtone");

  static bool get isSupported => !kIsWeb && Platform.isAndroid;

  /// Opens native Android Ringtone Picker dialog.
  /// Returns [RingtoneResult] or `null` if cancelled.
  static Future<RingtoneResult?> openRingtonePicker({
    String? currentUri,
    String? title,
  }) async {
    if (!isSupported) return null;
    try {
      final res = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        "openRingtonePicker",
        {
          "currentUri": currentUri,
          "title": title ?? "Select Prayer Reminder Sound",
        },
      );
      if (res != null) {
        return RingtoneResult.fromMap(res);
      }
    } catch (e) {
      debugPrint("Error opening ringtone picker: $e");
    }
    return null;
  }

  /// Plays preview of sound.
  static Future<bool> playRingtone(String? uri) async {
    if (!isSupported) return false;
    try {
      final res = await _channel.invokeMethod<bool>("playRingtone", {
        "uri": uri,
      });
      return res ?? false;
    } catch (e) {
      debugPrint("Error playing ringtone preview: $e");
      return false;
    }
  }

  /// Stops preview.
  static Future<bool> stopRingtone() async {
    if (!isSupported) return false;
    try {
      final res = await _channel.invokeMethod<bool>("stopRingtone");
      return res ?? false;
    } catch (e) {
      debugPrint("Error stopping ringtone preview: $e");
      return false;
    }
  }

  /// Retrieves list of system ringtones.
  static Future<List<RingtoneResult>> getRingtones() async {
    if (!isSupported) return [];
    try {
      final res = await _channel.invokeListMethod<Map<dynamic, dynamic>>("getRingtones");
      if (res != null) {
        return res.map((e) => RingtoneResult.fromMap(e)).toList();
      }
    } catch (e) {
      debugPrint("Error fetching ringtones: $e");
    }
    return [];
  }

  /// Creates or updates native Android Notification Channel with sound.
  static Future<bool> createOrUpdateNotificationChannel({
    required String channelKey,
    required String channelName,
    String? soundUri,
    bool isAlarm = false,
  }) async {
    if (!isSupported) return true;
    try {
      final res = await _channel.invokeMethod<bool>(
        "createOrUpdateNotificationChannel",
        {
          "channelKey": channelKey,
          "channelName": channelName,
          "soundUri": soundUri,
          "isAlarm": isAlarm,
        },
      );
      return res ?? false;
    } catch (e) {
      debugPrint("Error creating native notification channel: $e");
      return false;
    }
  }
}
