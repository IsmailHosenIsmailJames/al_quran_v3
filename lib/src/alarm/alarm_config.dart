import "dart:io";
import "package:flutter/material.dart";

import "package:alarm/model/alarm_settings.dart";
import "package:alarm/model/notification_settings.dart";
import "package:alarm/model/volume_settings.dart";

final alarmSettings = AlarmSettings(
  id: 42,
  dateTime: DateTime.now().add(const Duration(seconds: 30)),
  assetAudioPath: "assets/alarm.mp3",
  loopAudio: true,
  vibrate: true,
  warningNotificationOnKill: Platform.isIOS,
  androidFullScreenIntent: true,
  volumeSettings: VolumeSettings.fade(
    volume: 0.8,
    fadeDuration: const Duration(seconds: 5),
    volumeEnforced: true,
  ),
  notificationSettings: const NotificationSettings(
    title: "This is the title",
    body: "This is the body",
    stopButton: "Stop the alarm",
    icon: "notification_icon",
    iconColor: Color(0xff862778),
  ),
);
