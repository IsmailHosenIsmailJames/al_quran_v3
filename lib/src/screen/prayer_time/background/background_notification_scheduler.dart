import "dart:convert";
import "dart:io";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:awesome_notifications/awesome_notifications.dart";
import "package:alarm/alarm.dart";

class ReminderScheduler {
  static late SharedPreferences _sharedPreferences;

  /// Callback invoked when user taps a notification (awesome_notifications).
  static void Function(String?)? _onNotificationClick;

  static Future<PrayerReminderState> init({
    void Function(String?)? onNotificationClick,
  }) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _onNotificationClick = onNotificationClick;

    // Initialize awesome_notifications for notification-type reminders
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: "prayer_reminder",
        channelName: "Prayer Reminders",
        channelDescription: "Notifications for prayer time reminders",
        playSound: true,
        onlyAlertOnce: true,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
      ),
      NotificationChannel(
        channelKey: "prayer_alarm_notification",
        channelName: "Prayer Alarm Notifications",
        channelDescription:
            "High-priority notifications for prayer alarm reminders",
        playSound: true,
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
      ),
    ], debug: false);

    // Listen for notification tap actions
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
    );

    // Initialize alarm package
    await Alarm.init();

    return getState();
  }

  /// Static callback for awesome_notifications action (must be top-level or static).
  @pragma("vm:entry-point")
  static Future<void> _onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    final payload = receivedAction.payload?["prayer"];
    if (_onNotificationClick != null && payload != null) {
      _onNotificationClick!(payload);
    }
  }

  // ─── Schedule ──────────────────────────────────────────────────────────

  static Future<void> scheduleNotification(
    ReminderTypeWithPrayModel model,
  ) async {
    await cancelNotification(model);

    LocationQiblaPrayerDataState locationState =
        await LocationQiblaPrayerDataCubit.getSavedState();

    if (locationState.latLon == null) return;

    PrayerReminderState reminderState = getState();

    DateTime now = DateTime.now();

    if (model.reminderType == PrayerReminderType.alarm) {
      await _scheduleAlarms(model, locationState, reminderState, now);
    } else {
      await _scheduleNotifications(model, locationState, reminderState, now);
    }
  }

  /// Schedule alarm-type reminders using the `alarm` package.
  /// Schedules 7 days ahead (alarm is resource-intensive).
  static Future<void> _scheduleAlarms(
    ReminderTypeWithPrayModel model,
    LocationQiblaPrayerDataState locationState,
    PrayerReminderState reminderState,
    DateTime now,
  ) async {
    for (int i = 0; i < 7; i++) {
      DateTime targetDate = now.add(Duration(days: i));
      PrayerTimes prayerTimes = PrayerTimes(
        date: targetDate,
        coordinates: Coordinates(
          locationState.latLon!.latitude,
          locationState.latLon!.longitude,
        ),
        calculationParameters:
            locationState.calculationMethod ??
                  CalculationMethodParameters.muslimWorldLeague()
              ..madhab = locationState.madhab,
      );

      DateTime? prayerTime = prayerTimes.timeForPrayer(model.prayerType);
      if (prayerTime == null) continue;

      // Apply offset
      int offset = reminderState.reminderTimeAdjustment[model.prayerType] ?? 0;
      prayerTime = prayerTime.add(Duration(minutes: offset));

      if (prayerTime.isBefore(now)) continue;

      int alarmId = _alarmId(model.prayerType, i);

      final alarmSettings = AlarmSettings(
        id: alarmId,
        dateTime: prayerTime,
        assetAudioPath: "assets/adhan/adhan_by_Ahamed_al_Nafees.mp3",
        loopAudio: true,
        vibrate: true,
        warningNotificationOnKill: Platform.isIOS,
        androidFullScreenIntent: true,
        volumeSettings: VolumeSettings.fade(
          volume: reminderState.enforceAlarmSound
              ? reminderState.soundVolume
              : null,
          fadeDuration: const Duration(seconds: 3),
          volumeEnforced: reminderState.enforceAlarmSound,
        ),
        notificationSettings: NotificationSettings(
          title: "Prayer Time",
          body: "It is time for ${model.prayerType.name} prayer.",
          stopButton: "Stop",
          icon: "notification_icon",
        ),
      );

      await Alarm.set(alarmSettings: alarmSettings);
    }
  }

  /// Schedule notification-type reminders using `awesome_notifications`.
  /// Schedules 30 days ahead.
  static Future<void> _scheduleNotifications(
    ReminderTypeWithPrayModel model,
    LocationQiblaPrayerDataState locationState,
    PrayerReminderState reminderState,
    DateTime now,
  ) async {
    for (int i = 0; i < 30; i++) {
      DateTime targetDate = now.add(Duration(days: i));
      PrayerTimes prayerTimes = PrayerTimes(
        date: targetDate,
        coordinates: Coordinates(
          locationState.latLon!.latitude,
          locationState.latLon!.longitude,
        ),
        calculationParameters:
            locationState.calculationMethod ??
                  CalculationMethodParameters.muslimWorldLeague()
              ..madhab = locationState.madhab,
      );

      DateTime? prayerTime = prayerTimes.timeForPrayer(model.prayerType);
      if (prayerTime == null) continue;

      // Apply offset
      int offset = reminderState.reminderTimeAdjustment[model.prayerType] ?? 0;
      prayerTime = prayerTime.add(Duration(minutes: offset));

      if (prayerTime.isBefore(now)) continue;

      int notificationId = _notificationId(model.prayerType, i);

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: "prayer_reminder",
          title: "Prayer Time",
          body: "It is time for ${model.prayerType.name} prayer.",
          notificationLayout: NotificationLayout.Default,
          payload: {"prayer": "${model.prayerType.name}:$notificationId"},
          category: NotificationCategory.Reminder,
          wakeUpScreen: true,
        ),
        schedule: NotificationCalendar(
          year: prayerTime.year,
          month: prayerTime.month,
          day: prayerTime.day,
          hour: prayerTime.hour,
          minute: prayerTime.minute,
          second: 0,
          preciseAlarm: true,
        ),
      );
    }
  }

  // ─── Cancel ────────────────────────────────────────────────────────────

  static Future<void> cancelNotification(
    ReminderTypeWithPrayModel model,
  ) async {
    if (model.reminderType == PrayerReminderType.alarm) {
      for (int i = 0; i < 7; i++) {
        int alarmId = _alarmId(model.prayerType, i);
        await Alarm.stop(alarmId);
      }
    } else {
      for (int i = 0; i < 30; i++) {
        int notificationId = _notificationId(model.prayerType, i);
        await AwesomeNotifications().cancel(notificationId);
      }
    }
  }

  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
    // Stop all currently set alarms
    final alarms = await Alarm.getAlarms();
    for (final alarm in alarms) {
      await Alarm.stop(alarm.id);
    }
  }

  static Future<void> rescheduleAll() async {
    await cancelAllNotifications();
    List<ReminderTypeWithPrayModel> models = getListOfPrayerToRemember();
    for (var model in models) {
      await scheduleNotification(model);
    }
  }

  // ─── ID Helpers ────────────────────────────────────────────────────────

  /// Notification IDs: prayerIndex * 1000 + dayOffset (range: 0-9999)
  static int _notificationId(Prayer prayer, int dayOffset) {
    return prayer.index * 1000 + dayOffset;
  }

  /// Alarm IDs: 10000 + prayerIndex * 100 + dayOffset (separate namespace)
  static int _alarmId(Prayer prayer, int dayOffset) {
    return 10000 + prayer.index * 100 + dayOffset;
  }

  // ─── State Persistence (unchanged) ────────────────────────────────────

  static PrayerReminderState getState() {
    return PrayerReminderState(
      prayerToRemember: getListOfPrayerToRemember(),
      previousReminderModes: getPreviousReminderModes(),
      reminderTimeAdjustment: getReminderTimeAdjustment(),
      enforceAlarmSound: getEnforceAlarmSound(),
      soundVolume: getSoundVolume(),
    );
  }

  static List<ReminderTypeWithPrayModel> getListOfPrayerToRemember() {
    var list =
        _sharedPreferences.getStringList("prayer_list_of_reminder") ?? [];
    return list
        .map(
          (e) => ReminderTypeWithPrayModel.fromJson(
            Map<String, dynamic>.from(jsonDecode(e)),
          ),
        )
        .toList();
  }

  static Future<void> setListOfPrayerToRemember(
    List<ReminderTypeWithPrayModel> list,
  ) async {
    _sharedPreferences.setStringList(
      "prayer_list_of_reminder",
      list.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  static Map<Prayer, PrayerReminderType> getPreviousReminderModes() {
    Map<Prayer, PrayerReminderType> map = {};

    for (var element in Prayer.values) {
      String? mode = _sharedPreferences.getString(
        "prayer_${element.name}_reminder_mode",
      );
      mode ??= preferModeOfReminder(element).name;
      map[element] = PrayerReminderType.values.byName(mode);
    }

    return map;
  }

  static Future<void> setReminderMode(ReminderTypeWithPrayModel modes) async {
    _sharedPreferences.setString(
      "prayer_${modes.prayerType.name}_reminder_mode",
      modes.reminderType.name,
    );
  }

  static Map<Prayer, int> getReminderTimeAdjustment() {
    Map<Prayer, int> map = {};
    for (var element in Prayer.values) {
      int? time = _sharedPreferences.getInt(
        "prayer_${element.name}_reminder_time",
      );
      time ??= 0;
      map[element] = time;
    }
    return map;
  }

  static Future<void> setReminderTimeAdjustment(Prayer prayer, int time) async {
    _sharedPreferences.setInt("prayer_${prayer.name}_reminder_time", time);
  }

  static bool getEnforceAlarmSound() {
    return _sharedPreferences.getBool("prayer_reminder_enforce_alarm_sound") ??
        false;
  }

  static Future<void> setEnforceAlarmSound(bool value) async {
    _sharedPreferences.setBool("prayer_reminder_enforce_alarm_sound", value);
  }

  static double getSoundVolume() {
    return _sharedPreferences.getDouble("prayer_reminder_sound_volume") ?? 0.8;
  }

  static Future<void> setSoundVolume(double volume) async {
    _sharedPreferences.setDouble("prayer_reminder_sound_volume", volume);
  }

  static PrayerReminderType preferModeOfReminder(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return PrayerReminderType.alarm;
      case Prayer.sunrise:
        return PrayerReminderType.notification;
      case Prayer.dhuhr:
        return PrayerReminderType.alarm;
      case Prayer.asr:
        return PrayerReminderType.alarm;
      case Prayer.maghrib:
        return PrayerReminderType.alarm;
      case Prayer.isha:
        return PrayerReminderType.alarm;
      case Prayer.dhuha:
        return PrayerReminderType.notification;
      case Prayer.noon:
        return PrayerReminderType.notification;
      case Prayer.sunset:
        return PrayerReminderType.notification;
      case Prayer.tahajjud:
        return PrayerReminderType.notification;
    }
  }
}
