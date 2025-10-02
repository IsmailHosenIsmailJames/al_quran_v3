import "dart:developer";

import "package:awesome_notifications/awesome_notifications.dart";
import "package:permission_handler/permission_handler.dart";

import "../../../../main.dart";
import "../../../platform_services_stub.dart";

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
  if (platformOwn == PlatformOwn.isAndroid) {
    statusAlarm = await Permission.scheduleExactAlarm.request();
  }

  if (isAllowed && statusAlarm.isGranted) {
    log("All Permission is Granted", name: "Permission");
    isPermissionGranted = true;
    return true;
  }
  return false;
}
