import "dart:io";

import "package:alarm/alarm.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/prayers_time_bg_process.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:window_manager/window_manager.dart";
import "package:workmanager/workmanager.dart";

import "package:awesome_notifications/awesome_notifications.dart";

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
      size: Size(801, 900),
      minimumSize: Size(400, 700),
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

  if (Platform.isIOS || Platform.isAndroid) {
    await Alarm.init();
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      "prayer_time_bg",
      "set_prayer_time_reminder",
      frequency: const Duration(hours: 1),
    );
    await setReminderForPrayers();
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
