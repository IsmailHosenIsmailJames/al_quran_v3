import "package:injectable/injectable.dart";
import "package:vibration/vibration.dart";

abstract class VibrationDatasource {
  Future<bool> hasVibrator();
  Future<bool> hasCustomVibrationsSupport();
  Future<void> vibrate({int duration = 100, int amplitude = -1});
}

@LazySingleton(as: VibrationDatasource)
class VibrationDatasourceImpl implements VibrationDatasource {
  @override
  Future<bool> hasVibrator() async {
    return (await Vibration.hasVibrator());
  }

  @override
  Future<bool> hasCustomVibrationsSupport() async {
    return (await Vibration.hasCustomVibrationsSupport());
  }

  @override
  Future<void> vibrate({int duration = 100, int amplitude = -1}) async {
    await Vibration.vibrate(duration: duration, amplitude: amplitude);
  }
}
