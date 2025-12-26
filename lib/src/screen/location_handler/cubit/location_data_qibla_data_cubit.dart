import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:geolocator/geolocator.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../qibla/qibla_direction.dart";

class LocationQiblaPrayerDataCubit extends Cubit<LocationQiblaPrayerDataState> {
  LocationQiblaPrayerDataCubit({
    required LocationQiblaPrayerDataState initState,
  }) : super(initState);

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

  Future<void> alignWithDatabase() async {
    emit(await getSavedState());
  }

  Future<void> saveLocationData(LatLon latLon, {bool save = true}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (save) {
      sharedPreferences.setString("user_location", latLon.toJson());
    }
    LocationQiblaPrayerDataState newState = state.copyWith();
    newState.latLon = latLon;
    newState.kaabaAngle = calculateQiblaAngle(
      latLon.latitude,
      latLon.longitude,
    );

    emit(newState);
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
  }

  Future<void> saveMadhab(Madhab madhab, {bool save = true}) async {
    if (save) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("selected_madhab", madhab.name);
    }
    emit(state.copyWith(madhab: madhab));
  }

  void changePrayerTimeDownloading(bool value) {
    emit(state.copyWith(isPrayerTimeDownloading: value));
  }

  static Future<LocationQiblaPrayerDataState> getSavedState() async {
    LocationQiblaPrayerDataState data = LocationQiblaPrayerDataState();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? jsonLocation = sharedPreferences.getString("user_location");
    if (jsonLocation == null) {
      jsonLocation = Hive.box("user").get("user_location", defaultValue: null);
      if (jsonLocation != null) {
        await sharedPreferences.setString("user_location", jsonLocation);
      }
    }

    if (jsonLocation == null) {
      data.latLon = null;
      data.kaabaAngle = null;
    } else {
      var latLong = LatLon.fromJson(jsonLocation);
      data.latLon = latLong;
      data.kaabaAngle = calculateQiblaAngle(
        data.latLon!.latitude,
        data.latLon!.longitude,
      );
      String? calculationMethodJason = sharedPreferences.getString(
        "selected_calculation_method",
      );
      if (calculationMethodJason != null) {
        data.calculationMethod = CalculationMethodParameters.fromEnum(
          CalculationMethodEnum.values.firstWhere(
            (element) => element.name == calculationMethodJason,
          ),
        );
      } else {
        data.calculationMethod = CalculationMethodParameters.fromEnum(
          CalculationMethodEnum.muslimWorldLeague,
        );
      }
      String? madhab = sharedPreferences.getString("selected_madhab");
      if (madhab != null) {
        data.madhab = Madhab.values.firstWhere(
          (element) => element.name == madhab,
        );
      }
      {
        await sharedPreferences.setString("selected_madhab", Madhab.shafi.name);
        data.madhab ??= Madhab.shafi;
      }
    }
    return data;
  }
}
