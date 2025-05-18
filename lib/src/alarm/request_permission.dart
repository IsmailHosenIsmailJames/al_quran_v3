import "dart:developer";

import "package:permission_handler/permission_handler.dart";

Future<void> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  log("Schedule exact alarm permission: $status.");
  if (status.isDenied) {
    log("Requesting schedule exact alarm permission...");
    final res = await Permission.scheduleExactAlarm.request();
    log(
      'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
    );
  }
}
