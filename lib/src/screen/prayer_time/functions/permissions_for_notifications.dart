// import "package:awesome_notifications/awesome_notifications.dart";
// import "package:permission_handler/permission_handler.dart";

bool isPermissionGranted = false;

// Future<bool> requestPermissionForReminder(bool isAlarm) async {
//   if (isPermissionGranted) {
//     return true;
//   }

//   bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//   if (!isAllowed) {
//     isAllowed =
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//   }

//   bool isAlarmPermitted = await Permission.scheduleExactAlarm.isGranted;

//   if (!isAlarmPermitted) {
//     isAlarmPermitted = await Permission.scheduleExactAlarm.request().isGranted;
//   }

//   PermissionStatus statusAlarm = PermissionStatus.granted;
//   if (platformOwn == platform_services.PlatformOwn.isAndroid) {
//     statusAlarm = await Permission.scheduleExactAlarm.request();
//   }

//   if (isAllowed && statusAlarm.isGranted) {
//     log("All Permission is Granted", name: "Permission");
//     isPermissionGranted = true;
//     return true;
//   }
//   return false;
// }
