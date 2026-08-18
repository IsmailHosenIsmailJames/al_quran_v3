import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/location/presentation/models/lat_lon.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/qibla/data/repositories/qibla_repository_impl.dart";
import "package:al_quran_v3/src/features/qibla/data/datasources/compass_datasource.dart";
import "package:al_quran_v3/src/features/qibla/data/datasources/vibration_datasource.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:geolocator/geolocator.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";
import "package:shared_preferences/shared_preferences.dart";

double _calcQibla(double lat, double lon) {
  final repo = QiblaRepositoryImpl(CompassDatasourceImpl(), VibrationDatasourceImpl());
  return repo.calculateQiblaAngle(lat, lon);
}

@injectable
class LocationQiblaPrayerDataCubit extends Cubit<LocationQiblaPrayerDataState> {
  LocationQiblaPrayerDataCubit({
    @factoryParam LocationQiblaPrayerDataState? initState,
  }) : super(initState ?? const LocationQiblaPrayerDataState());

  Future<void> getLocation() async {
    emit(state.copyWith(isGettingLocation: true));
    try {
      Position position = await Geolocator.getCurrentPosition();
      await saveLocationData(
        LatLon(latitude: position.latitude, longitude: position.longitude),
        save: true,
      );
      emit(state.copyWith(isGettingLocation: false));
    } catch (e) {
      emit(state.copyWith(isGettingLocation: false));
    }
  }

  Future<void> updateLocationOnce() async {
    if (!state.hasInitialLocationUpdated) {
      emit(state.copyWith(hasInitialLocationUpdated: true));
      await getLocation();
    }
  }

  Future<void> alignWithDatabase() async {
    emit(await getSavedState());
  }

  Future<void> saveLocationData(LatLon latLon, {bool save = true}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (save) {
      sharedPreferences.setString("user_location", latLon.toJsonString());
    }
    final double kaabaAngle = _calcQibla(
      latLon.latitude,
      latLon.longitude,
    );

    emit(state.copyWith(latLon: latLon, kaabaAngle: kaabaAngle));
    await ReminderScheduler.scheduleNotification();
  }

  Future<void> saveCalculationMethod(
    CalculationParameters calculationMethod, {
    bool save = true,
  }) async {
    if (save) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        "selected_calculation_method",
        calculationMethod.method.name,
      );
    }
    emit(state.copyWith(calculationMethod: calculationMethod));
    await ReminderScheduler.scheduleNotification();
  }

  Future<void> saveMadhab(Madhab madhab, {bool save = true}) async {
    if (save) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("selected_madhab", madhab.name);
    }
    emit(state.copyWith(madhab: madhab));
    await ReminderScheduler.scheduleNotification();
  }

  void changePrayerTimeDownloading(bool value) {
    emit(state.copyWith(isPrayerTimeDownloading: value));
  }

  static Future<LocationQiblaPrayerDataState> getSavedState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? jsonLocation = sharedPreferences.getString("user_location");
    if (jsonLocation == null) {
      jsonLocation = Hive.box("user").get("user_location", defaultValue: null);
      if (jsonLocation != null) {
        await sharedPreferences.setString("user_location", jsonLocation);
      }
    }

    if (jsonLocation == null) {
      return const LocationQiblaPrayerDataState();
    } else {
      var latLong = LatLon.fromJsonString(jsonLocation);
      double kaabaAngle = _calcQibla(
        latLong.latitude,
        latLong.longitude,
      );
      String? calculationMethodJason = sharedPreferences.getString(
        "selected_calculation_method",
      );
      CalculationParameters calculationMethod;
      if (calculationMethodJason != null) {
        calculationMethod = CalculationMethodParameters.fromEnum(
          CalculationMethodEnum.values.firstWhere(
            (element) => element.name == calculationMethodJason,
          ),
        );
      } else {
        calculationMethod = CalculationMethodParameters.fromEnum(
          CalculationMethodEnum.muslimWorldLeague,
        );
      }
      String? madhab = sharedPreferences.getString("selected_madhab");
      Madhab? madhabEnum;
      if (madhab != null) {
        madhabEnum = Madhab.values.firstWhere(
          (element) => element.name == madhab,
        );
      } else {
        await sharedPreferences.setString("selected_madhab", Madhab.shafi.name);
        madhabEnum = Madhab.shafi;
      }

      return LocationQiblaPrayerDataState(
        latLon: latLong,
        kaabaAngle: kaabaAngle,
        calculationMethod: calculationMethod,
        madhab: madhabEnum,
      );
    }
  }
}
