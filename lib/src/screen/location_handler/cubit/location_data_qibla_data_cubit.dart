import "package:al_quran_v3/src/screen/location_handler/cubit/get_location_data.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:geolocator/geolocator.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

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
    emit(await getSavedLocation());
  }

  Future<void> saveLocationData(LatLon? latLon, {bool save = true}) async {
    if (save) {
      await Hive.box("user").put("user_location", latLon?.toJson());
    }
    LocationQiblaPrayerDataState newState = state.copyWith();
    newState.latLon = latLon;
    newState.kaabaAngle = latLon == null
        ? null
        : calculateQiblaAngle(latLon.latitude, latLon.longitude);

    emit(newState);
  }

  void saveCalculationMethod(
    CalculationMethod? calculationMethod, {
    bool save = true,
  }) {
    if (save) {
      Hive.box(
        "user",
      ).put("selected_prayer_calculation_method", calculationMethod?.toMap());
    }
    emit(state.copyWith(calculationMethod: calculationMethod));
  }

  void changePrayerTimeDownloading(bool value) {
    emit(state.copyWith(isPrayerTimeDownloading: value));
  }
}
