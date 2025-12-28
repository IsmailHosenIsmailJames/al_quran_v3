import "dart:io";

import "package:al_quran_v3/src/screen/prayer_time/background/prayer_time_background.dart"
    show backgroundFetchHeadlessTask;
import "package:alarm/alarm.dart";
import "package:background_fetch/background_fetch.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:window_manager/window_manager.dart";

import "package:awesome_notifications/awesome_notifications.dart";

void hideLoadingIndicator() {
  // no-op
}

Future<void> initAwesomeNotification() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "prayer_reminder",
      channelName: "Prayer Reminder",
      channelDescription: "This channel is for prayer reminder",
      playSound: true,
      onlyAlertOnce: true,
      groupAlertBehavior: GroupAlertBehavior.Children,
      importance: NotificationImportance.High,
      defaultPrivacy: NotificationPrivacy.Public,
    ),
  ], debug: false);
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

  if (Platform.isAndroid) {
    await Alarm.init();
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }

  if (Platform.isAndroid || Platform.isIOS) {
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),
      (String taskId) async {
        print("[BackgroundFetch] Event received $taskId");

        // Schedule a notification for 1 minute later (mirroring headless behavior for demo)
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 11, // Different ID to distinguish if needed, or same to overwrite
            channelKey: "prayer_reminder",
            title: "Background Task Demo (Active)",
            body:
                "This notification was scheduled from background fetch 1 minute ago.",
            notificationLayout: NotificationLayout.Default,
          ),
          schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(const Duration(minutes: 1)),
            allowWhileIdle: true,
            preciseAlarm: true,
          ),
        );

        BackgroundFetch.finish(taskId);
      },
      (String taskId) async {
        print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
        BackgroundFetch.finish(taskId);
      },
    );
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
