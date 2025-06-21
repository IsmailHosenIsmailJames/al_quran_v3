import "dart:developer";

import "package:awesome_notifications/awesome_notifications.dart";
import "package:permission_handler/permission_handler.dart";

bool isPermissionGranted = false;

Future<bool> requestPermissionForReminder() async {
  if (isPermissionGranted) {
    return true;
  }
  PermissionStatus statusNotification = await Permission.notification.request();
  PermissionStatus statusAlarm = await Permission.scheduleExactAlarm.request();
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    isAllowed =
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  if (statusNotification.isGranted && statusAlarm.isGranted && isAllowed) {
    log("All Permission is Granted", name: "Permission");
    isPermissionGranted = true;
    return true;
  }
  return false;
}
