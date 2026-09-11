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

  /// Plays preview or alarm sound.
  static Future<bool> playRingtone(
    String? uri, {
    bool isAlarm = false,
    bool loop = false,
    double? volume,
  }) async {
    if (!isSupported) return false;
    try {
      final res = await _channel.invokeMethod<bool>("playRingtone", {
        "uri": uri,
        "isAlarm": isAlarm,
        "loop": loop,
        "volume": ?volume,
      });
      return res ?? false;
    } catch (e) {
      debugPrint("Error playing ringtone preview: $e");
      return false;
    }
  }

  /// Stops preview or alarm playback.
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

  /// Checks if an incoming or ongoing telephone / VoIP call is active.
  static Future<bool> isInCall() async {
    if (!isSupported) return false;
    try {
      final res = await _channel.invokeMethod<bool>("isInCall");
      return res ?? false;
    } catch (e) {
      debugPrint("Error checking call status: $e");
      return false;
    }
  }

  /// Checks if battery optimization is disabled/ignored for this app.
  static Future<bool> isIgnoringBatteryOptimizations() async {
    if (!isSupported) return true;
    try {
      final res =
          await _channel.invokeMethod<bool>("isIgnoringBatteryOptimizations");
      return res ?? true;
    } catch (e) {
      debugPrint("Error checking battery optimization: $e");
      return true;
    }
  }

  /// Requests the user to disable battery optimizations (essential for Honor, Xiaomi, Huawei).
  static Future<bool> requestIgnoreBatteryOptimizations() async {
    if (!isSupported) return false;
    try {
      final res = await _channel
          .invokeMethod<bool>("requestIgnoreBatteryOptimizations");
      return res ?? false;
    } catch (e) {
      debugPrint("Error requesting battery optimization exemption: $e");
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

  /// Checks if the app is allowed to use full-screen intents (Android 14+).
  static Future<bool> canUseFullScreenIntent() async {
    if (!isSupported) return true;
    try {
      final res = await _channel.invokeMethod<bool>("canUseFullScreenIntent");
      return res ?? true;
    } catch (e) {
      debugPrint("Error checking full-screen intent permission: $e");
      return true;
    }
  }

  /// Opens the system settings screen to grant full-screen intent permission (Android 14+).
  static Future<bool> openFullScreenIntentSettings() async {
    if (!isSupported) return false;
    try {
      final res = await _channel.invokeMethod<bool>("openFullScreenIntentSettings");
      return res ?? false;
    } catch (e) {
      debugPrint("Error opening full-screen intent settings: $e");
      return false;
    }
  }
}
