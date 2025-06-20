import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:bloc/bloc.dart";

class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit()
    : super(
        PrayerReminderState(
          prayerToRemember: PrayersTimeFunction.getListOfPrayerToRemember(),
          previousReminderModes: PrayersTimeFunction.getPreviousReminderModes(),
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
}
