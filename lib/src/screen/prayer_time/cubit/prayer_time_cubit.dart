import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_types.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:bloc/bloc.dart";

class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit()
    : super(
        PrayerReminderState(
          prayerToRemember: PrayersTimeFunction.getListOfPrayerToRemember(),
          previousReminderModes: PrayersTimeFunction.getPreviousReminderModes(),
          reminderTimeAdjustment: PrayersTimeFunction.getAdjustReminderTime(),
          enforceAlarmSound: PrayersTimeFunction.getEnforceAlarmSound(),
          soundVolume: PrayersTimeFunction.getSoundVolume(),
        ),
      );

  void addPrayerToRemember(
    ReminderTypeWithPrayModel prayerModelTimesType,
  ) async {
    await PrayersTimeFunction.addPrayerToReminder(prayerModelTimesType);
    emit(
      state.copyWith(
        prayerToRemember: PrayersTimeFunction.getListOfPrayerToRemember(),
        previousReminderModes: PrayersTimeFunction.getPreviousReminderModes(),
      ),
    );
  }

  void removePrayerToRemember(
    ReminderTypeWithPrayModel prayerModelTimesType,
  ) async {
    await PrayersTimeFunction.removePrayerToReminder(prayerModelTimesType);
    emit(
      state.copyWith(
        prayerToRemember: PrayersTimeFunction.getListOfPrayerToRemember(),
        previousReminderModes: PrayersTimeFunction.getPreviousReminderModes(),
      ),
    );
  }

  void setReminderMode(ReminderTypeWithPrayModel data) async {
    var reminderModes = await PrayersTimeFunction.setReminderModes(data);
    emit(state.copyWith(previousReminderModes: reminderModes));
  }

  void setReminderTimeAdjustment(
    PrayerModelTimesType prayerType,
    int timeInMinutes,
  ) async {
    final reminderTimeAdjustment =
        await PrayersTimeFunction.setAdjustReminderTime(
          prayerType,
          timeInMinutes,
        );
    emit(state.copyWith(reminderTimeAdjustment: reminderTimeAdjustment));
  }

  void setReminderEnforceSound(bool value) async {
    await PrayersTimeFunction.setEnforceAlarmSound(value);
    emit(state.copyWith(enforceAlarmSound: value));
  }

  void setReminderSoundVolume(double value) async {
    await PrayersTimeFunction.setSoundVolume(value);
    emit(state.copyWith(soundVolume: value));
  }
}
