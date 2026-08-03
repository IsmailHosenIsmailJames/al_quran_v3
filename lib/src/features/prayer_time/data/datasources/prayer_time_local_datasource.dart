import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/background/background_notification_scheduler.dart";
import "package:injectable/injectable.dart";
import "package:shared_preferences/shared_preferences.dart";

abstract class PrayerTimeLocalDataSource {
  Future<void> saveCalculationMethod(CalculationParameters method);
  Future<void> saveMadhab(Madhab madhab);
  Future<void> scheduleNotifications();
}

@LazySingleton(as: PrayerTimeLocalDataSource)
class PrayerTimeLocalDataSourceImpl implements PrayerTimeLocalDataSource {
  static const String _calculationMethodKey = "selected_calculation_method";
  static const String _madhabKey = "selected_madhab";

  @override
  Future<void> saveCalculationMethod(CalculationParameters method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_calculationMethodKey, method.method.name);
    await scheduleNotifications();
  }

  @override
  Future<void> saveMadhab(Madhab madhab) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_madhabKey, madhab.name);
    await scheduleNotifications();
  }

  @override
  Future<void> scheduleNotifications() async {
    await ReminderScheduler.scheduleNotification();
  }
}
