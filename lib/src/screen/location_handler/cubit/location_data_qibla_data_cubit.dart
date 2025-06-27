import "package:al_quran_v3/src/screen/location_handler/cubit/get_location_data.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

import "../../prayer_time/functions/prayers_time_function.dart";
import "../../qibla/qibla_direction.dart";

class LocationQiblaPrayerDataCubit extends Cubit<LocationQiblaPrayerDataState> {
  LocationQiblaPrayerDataCubit() : super(getSavedLocation());

  void alignWithDatabase() {
    emit(getSavedLocation());
  }

  void saveLocationData(LatLon? latLon, {bool save = true}) {
    if (save) {
      Hive.box("user").put("user_location", latLon?.toJson());
    }
    emit(
      state.copyWith(
        latLon: latLon,
        kaabaAngle:
            latLon == null
                ? null
                : calculateQiblaAngle(latLon.latitude, latLon.longitude),
      ),
    );
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

  void checkPrayerDataExits() {
    emit(state.copyWith(isDataExits: PrayersTimeFunction.checkIsDataExits()));
  }
}
