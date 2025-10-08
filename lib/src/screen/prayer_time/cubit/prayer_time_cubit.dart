import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_types.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:bloc/bloc.dart";

class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit({required PrayerReminderState initState})
    : super(initState);

  void addPrayerToRemember(
    ReminderTypeWithPrayModel prayerModelTimesType,
  ) async {
    List<ReminderTypeWithPrayModel> list = state.prayerToRemember;
    list.add(prayerModelTimesType);
    emit(state.copyWith(prayerToRemember: list));
    await PrayersTimeFunction.addPrayerToReminder(prayerModelTimesType);
    emit(
      state.copyWith(
        previousReminderModes:
            PrayersTimeFunction.getPreviousReminderModes(),
      ),
    );
  }

  void removePrayerToRemember(
    ReminderTypeWithPrayModel prayerModelTimesType,
  ) async {
    List<ReminderTypeWithPrayModel> list = state.prayerToRemember;
    list.remove(prayerModelTimesType);
    emit(state.copyWith(prayerToRemember: list));
    await PrayersTimeFunction.removePrayerToReminder(prayerModelTimesType);
    emit(
      state.copyWith(
        previousReminderModes:
            PrayersTimeFunction.getPreviousReminderModes(),
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

  void setUIReminderTimeAdjustment(
    PrayerModelTimesType prayerType,
    int timeInMinutes,
  ) async {
    Map<PrayerModelTimesType, int> adjustment = state.reminderTimeAdjustment;
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
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
