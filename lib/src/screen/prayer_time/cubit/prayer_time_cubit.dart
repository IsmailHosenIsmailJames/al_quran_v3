import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/background_notification_scheduler.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:bloc/bloc.dart";

class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit()
    : super(
        PrayerReminderState(
          reminderTimeAdjustment: ReminderScheduler.getReminderTimeAdjustment(),
          enforceAlarmSound: ReminderScheduler.getEnforceAlarmSound(),
          soundVolume: ReminderScheduler.getSoundVolume(),
          isPrayerRemindNotificationEnabled:
              ReminderScheduler.isPrayerRemindNotificationEnabled(),
        ),
      );

  Future<void> enablePrayerRemindNotification() async {
    emit(state.copyWith(isPrayerRemindNotificationEnabled: true));
    await ReminderScheduler.enablePrayerRemindNotification();
  }

  Future<void> disablePrayerRemindNotification() async {
    emit(state.copyWith(isPrayerRemindNotificationEnabled: false));
    await ReminderScheduler.disablePrayerRemindNotification();
  }

  void setReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = Map<Prayer, int>.from(
      state.reminderTimeAdjustment ?? {},
    );
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
    await ReminderScheduler.setReminderTimeAdjustment(
      prayerType,
      timeInMinutes,
    );
  }

  /// Called while user is dragging the slider — only update UI + save pref.
  /// No rescheduling happens here to avoid spamming schedule calls.
  void setUIReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = Map<Prayer, int>.from(
      state.reminderTimeAdjustment ?? {},
    );
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
    await ReminderScheduler.setReminderTimeAdjustment(
      prayerType,
      timeInMinutes,
    );
  }

  void setReminderEnforceSound(bool value) async {
    emit(state.copyWith(enforceAlarmSound: value));
    await ReminderScheduler.setEnforceAlarmSound(value);
    // Only alarm-type prayers are affected by sound settings
    await ReminderScheduler.scheduleNotification();
  }

  void setReminderSoundVolume(double value) async {
    emit(state.copyWith(soundVolume: value));
    await ReminderScheduler.setSoundVolume(value);
    // Only alarm-type prayers are affected by volume settings
    await ReminderScheduler.scheduleNotification();
  }
}
