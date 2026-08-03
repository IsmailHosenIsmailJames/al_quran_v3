import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/background/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

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
    await ReminderScheduler.cancelAllNotifications();
    await ReminderScheduler.scheduleNotification();
  }

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
    await ReminderScheduler.scheduleNotification();
  }

  void setReminderSoundVolume(double value) async {
    emit(state.copyWith(soundVolume: value));
    await ReminderScheduler.setSoundVolume(value);
    await ReminderScheduler.scheduleNotification();
  }
}
