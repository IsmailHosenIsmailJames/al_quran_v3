import "dart:developer";
import "dart:io";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/l10n/app_localizations_ar.dart";
import "package:al_quran_v3/l10n/app_localizations_az.dart";
import "package:al_quran_v3/l10n/app_localizations_bn.dart";
import "package:al_quran_v3/l10n/app_localizations_de.dart";
import "package:al_quran_v3/l10n/app_localizations_en.dart";
import "package:al_quran_v3/l10n/app_localizations_es.dart";
import "package:al_quran_v3/l10n/app_localizations_fa.dart";
import "package:al_quran_v3/l10n/app_localizations_fr.dart";
import "package:al_quran_v3/l10n/app_localizations_hi.dart";
import "package:al_quran_v3/l10n/app_localizations_id.dart";
import "package:al_quran_v3/l10n/app_localizations_it.dart";
import "package:al_quran_v3/l10n/app_localizations_ja.dart";
import "package:al_quran_v3/l10n/app_localizations_kk.dart";
import "package:al_quran_v3/l10n/app_localizations_ko.dart";
import "package:al_quran_v3/l10n/app_localizations_ms.dart";
import "package:al_quran_v3/l10n/app_localizations_pa.dart";
import "package:al_quran_v3/l10n/app_localizations_ps.dart";
import "package:al_quran_v3/l10n/app_localizations_pt.dart";
import "package:al_quran_v3/l10n/app_localizations_ru.dart";
import "package:al_quran_v3/l10n/app_localizations_sw.dart";
import "package:al_quran_v3/l10n/app_localizations_ta.dart";
import "package:al_quran_v3/l10n/app_localizations_tr.dart";
import "package:al_quran_v3/l10n/app_localizations_ur.dart";
import "package:al_quran_v3/l10n/app_localizations_vi.dart";
import "package:al_quran_v3/l10n/app_localizations_zh.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/ringtone_service.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:awesome_notifications/awesome_notifications.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:permission_handler/permission_handler.dart";
import "package:shared_preferences/shared_preferences.dart";

class ReminderScheduler {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // ─── Permission Check ──────────────────────────────────────────────────

  static Future<bool> hasRequiredPermissions() async {
    try {
      final isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) return false;

      if (!kIsWeb && Platform.isAndroid) {
        final status = await Permission.scheduleExactAlarm.status;
        if (status.isDenied ||
            status.isPermanentlyDenied ||
            status.isRestricted) {
          return false;
        }
      }
      return true;
    } catch (_) {
      return true;
    }
  }

  // ─── Channel Sync ──────────────────────────────────────────────────────

  static Future<void> syncNotificationChannel() async {
    final isAlarm = getEnforceAlarmSound();
    final soundUri = getSelectedRingtoneUri();
    final soundType = getSelectedRingtoneType();
    final channelKey = getNotificationChannelKey();

    String? soundSource;
    DefaultRingtoneType defaultRingtoneType = DefaultRingtoneType.Notification;

    if (soundType == "default_sound" || soundType == "notification_sound") {
      soundSource = "resource://raw/notification_sound";
    } else if (soundType == "system_alarm") {
      defaultRingtoneType = DefaultRingtoneType.Alarm;
    } else if (soundType == "system_ringtone") {
      defaultRingtoneType = DefaultRingtoneType.Ringtone;
    } else if (soundType == "system_notification") {
      defaultRingtoneType = DefaultRingtoneType.Notification;
    }

    try {
      await AwesomeNotifications().setChannel(
        NotificationChannel(
          channelKey: channelKey,
          channelName: "Prayer Reminders",
          channelDescription: "Notifications for prayer time reminders",
          playSound: true,
          importance:
              isAlarm ? NotificationImportance.Max : NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Public,
          soundSource: soundSource,
          defaultRingtoneType: defaultRingtoneType,
          criticalAlerts: true,
          enableVibration: true,
          enableLights: true,
        ),
        forceUpdate: true,
      );
    } catch (e) {
      log("Error syncing AwesomeNotifications channel: $e");
    }

    if (!kIsWeb && Platform.isAndroid) {
      await RingtoneService.createOrUpdateNotificationChannel(
        channelKey: channelKey,
        channelName: "Prayer Reminders",
        soundUri: (soundType == "default_sound" || soundType == "notification_sound")
            ? "resource://raw/notification_sound"
            : soundUri ?? soundType,
        isAlarm: isAlarm,
      );
    }
  }

  // ─── Schedule ──────────────────────────────────────────────────────────

  static Future<void> scheduleNotification() async {
    if (!isPrayerRemindNotificationEnabled()) return;

    LocationQiblaPrayerDataState locationState =
        await LocationQiblaPrayerDataCubit.getSavedState();

    if (locationState.latLon == null) return;

    PrayerReminderState reminderState = getState();
    DateTime now = DateTime.now();

    if (!await hasRequiredPermissions()) {
      log("Notification permissions not granted, skipping schedule");
      return;
    }

    await syncNotificationChannel();
    await cancelAllNotifications();
    await _scheduleNotifications(locationState, reminderState, now);
  }

  /// Schedule notification-type reminders using `awesome_notifications`.
  /// Schedules 7 days ahead.
  static Future<void> _scheduleNotifications(
    LocationQiblaPrayerDataState locationState,
    PrayerReminderState reminderState,
    DateTime now,
  ) async {
    Locale locale = (await LanguageCubit.getInitialLocale()).locale;
    AppLocalizations appLocalizations = appLocalizationsFromLocale(locale);
    List<Map<Prayer, DateTime?>> next7DaysPrayerTimes = _getNext7DayPrayerTimes(
      locationState,
      now,
    );

    final enabledMap = reminderState.enabledPrayers ?? getEnabledPrayers();
    final isAlarm = reminderState.enforceAlarmSound ?? getEnforceAlarmSound();
    final channelKey = getNotificationChannelKey();
    final localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    for (int i = 0; i < next7DaysPrayerTimes.length; i++) {
      final prayerTimesToday = next7DaysPrayerTimes[i];
      for (Prayer prayerName in prayerTimesToday.keys) {
        if (!(enabledMap[prayerName] ?? true)) continue;

        DateTime? time = prayerTimesToday[prayerName];
        if (time != null) {
          if (time.isBefore(now)) continue;

          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              channelKey: channelKey,
              id: _notificationId(prayerName, time),
              title:
                  "${getPrayerGroupName(prayerName, appLocalizations)} - ${getPrayerNameWithSomeDetails(prayerName, appLocalizations)}",
              body: DateFormat.jm(
                locale.languageCode,
              ).format(time),
              category:
                  isAlarm ? NotificationCategory.Alarm : NotificationCategory.Reminder,
              notificationLayout: NotificationLayout.Default,
              wakeUpScreen: true,
            ),
            schedule: NotificationCalendar(
              day: time.day,
              month: time.month,
              year: time.year,
              hour: time.hour,
              minute: time.minute,
              second: 0,
              millisecond: 0,
              timeZone: localTimeZone,
              allowWhileIdle: true,
              preciseAlarm: true,
              repeats: false,
            ),
          );
        }
      }
    }
  }

  static Future<void> sendTestNotification() async {
    await syncNotificationChannel();
    final channelKey = getNotificationChannelKey();
    final isAlarm = getEnforceAlarmSound();
    final title = getSelectedRingtoneTitle() ?? "notification_sound.wav";

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 99999,
        channelKey: channelKey,
        title: "🕌 Prayer Reminder Test",
        body: "Testing sound: $title",
        category:
            isAlarm ? NotificationCategory.Alarm : NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
      ),
    );
  }

  static AppLocalizations appLocalizationsFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return AppLocalizationsAr();
      case 'az':
        return AppLocalizationsAz();
      case 'bn':
        return AppLocalizationsBn();
      case 'de':
        return AppLocalizationsDe();
      case 'en':
        return AppLocalizationsEn();
      case 'es':
        return AppLocalizationsEs();
      case 'fa':
        return AppLocalizationsFa();
      case 'fr':
        return AppLocalizationsFr();
      case 'hi':
        return AppLocalizationsHi();
      case 'id':
        return AppLocalizationsId();
      case 'it':
        return AppLocalizationsIt();
      case 'ja':
        return AppLocalizationsJa();
      case 'kk':
        return AppLocalizationsKk();
      case 'ko':
        return AppLocalizationsKo();
      case 'ms':
        return AppLocalizationsMs();
      case 'pa':
        return AppLocalizationsPa();
      case 'ps':
        return AppLocalizationsPs();
      case 'pt':
        return AppLocalizationsPt();
      case 'ru':
        return AppLocalizationsRu();
      case 'sw':
        return AppLocalizationsSw();
      case 'ta':
        return AppLocalizationsTa();
      case 'tr':
        return AppLocalizationsTr();
      case 'ur':
        return AppLocalizationsUr();
      case 'vi':
        return AppLocalizationsVi();
      case 'zh':
        return AppLocalizationsZh();
      default:
        return AppLocalizationsEn();
    }
  }

  static String getPrayerNameWithSomeDetails(
    Prayer prayer,
    AppLocalizations appLocalizations,
  ) {
    switch (prayer) {
      case Prayer.sunrise:
        return appLocalizations.sunRising;
      case Prayer.noon:
        return appLocalizations.sunTopOfTheHead;
      case Prayer.sunset:
        return appLocalizations.sunSetting;
      case Prayer.fajr:
        return appLocalizations.fajr.capitalize();
      case Prayer.dhuha:
        return appLocalizations.dhuha.capitalize();
      case Prayer.dhuhr:
        return appLocalizations.dhuhr.capitalize();
      case Prayer.asr:
        return appLocalizations.asr.capitalize();
      case Prayer.maghrib:
        return appLocalizations.maghrib.capitalize();
      case Prayer.isha:
        return appLocalizations.isha.capitalize();
      case Prayer.tahajjud:
        return appLocalizations.tahajjud.capitalize();
    }
  }

  static String getPrayerGroupName(
    Prayer prayer,
    AppLocalizations appLocalizations,
  ) {
    switch (prayer) {
      case Prayer.fajr:
      case Prayer.dhuhr:
      case Prayer.asr:
      case Prayer.maghrib:
      case Prayer.isha:
      case Prayer.tahajjud:
      case Prayer.dhuha:
        return appLocalizations.salatTime;

      case Prayer.sunrise:
      case Prayer.sunset:
      case Prayer.noon:
        return appLocalizations.forbiddenSalatTime;
    }
  }

  static List<Map<Prayer, DateTime?>> _getNext7DayPrayerTimes(
    LocationQiblaPrayerDataState locationState,
    DateTime now,
  ) {
    List<Map<Prayer, DateTime?>> prayerTimes = [];
    final reminderTimeAdjustment = getReminderTimeAdjustment();
    for (int i = 0; i < 7; i++) {
      final prayer = PrayerTimes(
        date: now.add(Duration(days: i)),
        coordinates: Coordinates(
          locationState.latLon!.latitude,
          locationState.latLon!.longitude,
        ),
        calculationParameters:
            (locationState.calculationMethod ??
                  CalculationMethodParameters.muslimWorldLeague())
              ..madhab = locationState.madhab ?? Madhab.shafi,
      );
      Map<Prayer, DateTime?> prayerTimesToday = {};
      for (Prayer prayerName in Prayer.values) {
        DateTime? time = prayer.timeForPrayer(prayerName);
        if (time != null) {
          time = time.toLocal();
          int adjust = reminderTimeAdjustment[prayerName] ?? 0;
          if (adjust != 0) {
            time = time.add(Duration(minutes: adjust));
          }
        }
        prayerTimesToday[prayerName] = time;
      }
      prayerTimes.add(prayerTimesToday);
    }
    return prayerTimes;
  }

  static Future<void> cancelAllNotifications() async {
    log("Cancelling all notifications");
    await AwesomeNotifications().cancelAll();
  }

  // ─── ID Helpers ────────────────────────────────────────────────────────

  /// Notification IDs: prayerIndex * 10000 + month * 100 + day
  static int _notificationId(Prayer prayer, DateTime time) {
    return prayer.index * 10000 + time.month * 100 + time.day;
  }

  static PrayerReminderState getState() {
    return PrayerReminderState(
      reminderTimeAdjustment: getReminderTimeAdjustment(),
      enabledPrayers: getEnabledPrayers(),
      enforceAlarmSound: getEnforceAlarmSound(),
      soundVolume: getSoundVolume(),
      isPrayerRemindNotificationEnabled: isPrayerRemindNotificationEnabled(),
      selectedRingtoneUri: getSelectedRingtoneUri(),
      selectedRingtoneTitle: getSelectedRingtoneTitle(),
      selectedRingtoneType: getSelectedRingtoneType(),
      isPlayingPreview: false,
    );
  }

  static Future<void> enablePrayerRemindNotification() async {
    await _sharedPreferences.setBool("prayer_remind_notification", true);
    await scheduleNotification();
  }

  static Future<void> disablePrayerRemindNotification() async {
    await _sharedPreferences.setBool("prayer_remind_notification", false);
    await cancelAllNotifications();
  }

  static bool isPrayerRemindNotificationEnabled() {
    return _sharedPreferences.getBool("prayer_remind_notification") ?? false;
  }

  static bool isPrayerEnabled(Prayer prayer) {
    return _sharedPreferences.getBool("prayer_${prayer.name}_enabled") ??
        (prayer == Prayer.fajr ||
            prayer == Prayer.dhuhr ||
            prayer == Prayer.asr ||
            prayer == Prayer.maghrib ||
            prayer == Prayer.isha);
  }

  static Future<void> setPrayerEnabled(Prayer prayer, bool enabled) async {
    await _sharedPreferences.setBool("prayer_${prayer.name}_enabled", enabled);
  }

  static Map<Prayer, bool> getEnabledPrayers() {
    Map<Prayer, bool> map = {};
    for (var prayer in Prayer.values) {
      map[prayer] = isPrayerEnabled(prayer);
    }
    return map;
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
    await _sharedPreferences.setInt("prayer_${prayer.name}_reminder_time", time);
  }

  static bool getEnforceAlarmSound() {
    return _sharedPreferences.getBool("prayer_reminder_enforce_alarm_sound") ??
        false;
  }

  static Future<void> setEnforceAlarmSound(bool value) async {
    await _sharedPreferences.setBool("prayer_reminder_enforce_alarm_sound", value);
  }

  static double getSoundVolume() {
    return _sharedPreferences.getDouble("prayer_reminder_sound_volume") ?? 0.8;
  }

  static Future<void> setSoundVolume(double volume) async {
    await _sharedPreferences.setDouble("prayer_reminder_sound_volume", volume);
  }

  // ─── Ringtone Settings ────────────────────────────────────────────────

  static String getNotificationChannelKey() {
    return _sharedPreferences.getString("prayer_reminder_channel_key") ??
        "prayer_reminder_default";
  }

  static Future<void> setNotificationChannelKey(String key) async {
    await _sharedPreferences.setString("prayer_reminder_channel_key", key);
  }

  static String? getSelectedRingtoneUri() {
    return _sharedPreferences.getString("prayer_reminder_sound_uri");
  }

  static Future<void> setSelectedRingtoneUri(String? uri) async {
    if (uri == null) {
      await _sharedPreferences.remove("prayer_reminder_sound_uri");
    } else {
      await _sharedPreferences.setString("prayer_reminder_sound_uri", uri);
    }
  }

  static String? getSelectedRingtoneTitle() {
    return _sharedPreferences.getString("prayer_reminder_sound_title");
  }

  static Future<void> setSelectedRingtoneTitle(String? title) async {
    if (title == null) {
      await _sharedPreferences.remove("prayer_reminder_sound_title");
    } else {
      await _sharedPreferences.setString("prayer_reminder_sound_title", title);
    }
  }

  static String getSelectedRingtoneType() {
    return _sharedPreferences.getString("prayer_reminder_sound_type") ??
        "default_sound";
  }

  static Future<void> setSelectedRingtoneType(String type) async {
    await _sharedPreferences.setString("prayer_reminder_sound_type", type);
  }
}
