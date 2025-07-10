import "dart:developer";
import "dart:io";

import "package:awesome_notifications/awesome_notifications.dart";
import "package:permission_handler/permission_handler.dart";

bool isPermissionGranted = false;

Future<bool> requestPermissionForReminder() async {
  if (isPermissionGranted) {
    return true;
  }

  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    isAllowed =
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  PermissionStatus statusAlarm = PermissionStatus.granted;
  if (Platform.isAndroid) {
    statusAlarm = await Permission.scheduleExactAlarm.request();
  }

  if (isAllowed && statusAlarm.isGranted) {
    log("All Permission is Granted", name: "Permission");
    isPermissionGranted = true;
    return true;
  }
  return false;
}
