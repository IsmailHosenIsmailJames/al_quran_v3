import "dart:io";

// import "package:alarm/alarm.dart";
// import "package:background_fetch/background_fetch.dart";
import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_alarm_screen.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:window_manager/window_manager.dart";

import "package:awesome_notifications/awesome_notifications.dart";

void hideLoadingIndicator() {
  // no-op
}

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    final buttonKey = receivedAction.buttonKeyPressed;
    final payload = receivedAction.payload;

    if (buttonKey == "DISMISS") {
      await AwesomeNotifications().cancel(receivedAction.id ?? 0);
      return;
    }

    if (buttonKey == "SNOOZE") {
      await AwesomeNotifications().cancel(receivedAction.id ?? 0);
      final prayerName = payload?["prayer"];
      if (prayerName != null) {
        final prayer = Prayer.values.cast<Prayer?>().firstWhere(
              (p) => p?.name.toLowerCase() == prayerName.toLowerCase(),
              orElse: () => null,
            );
        if (prayer != null) {
          await ReminderScheduler.snoozePrayerAlarm(prayer, minutes: 10);
        }
      }
      return;
    }

    // Full screen alarm intent or user tapped alarm notification
    if (payload?["type"] == "alarm") {
      final prayerName = payload?["prayer"];
      final timeStr = payload?["time"];
      if (prayerName != null) {
        final prayer = Prayer.values.cast<Prayer?>().firstWhere(
              (p) => p?.name.toLowerCase() == prayerName.toLowerCase(),
              orElse: () => null,
            );
        if (prayer != null) {
          final time = timeStr != null ? DateTime.tryParse(timeStr) : null;
          navigateToPrayerAlarmScreen(
            prayer,
            time ?? DateTime.now(),
            receivedAction.id ?? 0,
          );
        }
      }
    }
  }
}

Future<void> initAwesomeNotification() async {
  await AwesomeNotifications().initialize(
    'resource://mipmap/ic_launcher',
    [
      NotificationChannel(
        channelKey: "prayer_alarm_channel_v1",
        channelName: "Prayer Alarms",
        channelDescription: "Full-screen alarms for prayer times",
        playSound: true,
        onlyAlertOnce: false,
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        soundSource: "resource://raw/notification_sound",
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        criticalAlerts: true,
        enableVibration: true,
        enableLights: true,
      ),
      NotificationChannel(
        channelKey: "prayer_reminder_notif_v1",
        channelName: "Prayer Reminders",
        channelDescription: "Notifications for prayer time reminders",
        playSound: true,
        onlyAlertOnce: false,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
        soundSource: "resource://raw/notification_sound",
        criticalAlerts: false,
        enableVibration: true,
        enableLights: true,
      ),
      NotificationChannel(
        channelKey: "prayer_reminder_default",
        channelName: "Prayer Reminders",
        channelDescription: "Notifications for prayer time reminders",
        playSound: true,
        onlyAlertOnce: false,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
        soundSource: "resource://raw/notification_sound",
        criticalAlerts: false,
        enableVibration: true,
        enableLights: true,
      ),
      NotificationChannel(
        channelKey: "prayer_reminder",
        channelName: "Prayer Reminders (Legacy)",
        channelDescription: "Notifications for prayer time reminders",
        playSound: true,
        onlyAlertOnce: false,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
        soundSource: "resource://raw/notification_sound",
        criticalAlerts: false,
        enableVibration: true,
        enableLights: true,
      ),
    ],
    debug: false,
  );

  await AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
  );
}

Future<void> initializePlatform() async {
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: "Al-Quran's Tafsir, Audio, Prayer Time",
      minimumSize: Size(400, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}

Future<String?> getApplicationDataPath() async {
  Directory? dir;
  if (Platform.isAndroid) {
    dir = await getExternalStorageDirectory();
  } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    dir = await getDownloadsDirectory();
  } else {
    // Fallback for other platforms like iOS
    dir = await getApplicationDocumentsDirectory();
  }
  return dir?.path;
}

enum PlatformOwn {
  isIos,
  isAndroid,
  isLinux,
  isMac,
  isWeb,
  isWasm,
  isWindows,
  isFuchsia,
  unknown,
}

PlatformOwn getPlatform() {
  if (Platform.isAndroid) {
    return PlatformOwn.isAndroid;
  } else if (Platform.isIOS) {
    return PlatformOwn.isIos;
  } else if (Platform.isLinux) {
    return PlatformOwn.isLinux;
  } else if (Platform.isMacOS) {
    return PlatformOwn.isMac;
  } else if (Platform.isWindows) {
    return PlatformOwn.isWindows;
  } else if (Platform.isFuchsia) {
    return PlatformOwn.isFuchsia;
  } else if (Platform.isAndroid) {
    return PlatformOwn.isAndroid;
  } else {
    return PlatformOwn.unknown;
  }
}
