import "package:al_quran_v3/src/screen/home/pages/qibla/qibla_direction.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/find_cloest_calculation_method.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:hive/hive.dart";

import "../../prayer_time/functions/prayers_time_function.dart";

LocationQiblaPrayerDataState getSavedLocation() {
  LocationQiblaPrayerDataState data = LocationQiblaPrayerDataState();
  final jsonLocation = Hive.box(
    "user",
  ).get("user_location", defaultValue: null);
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
    Map<String, dynamic>? calculationMethod = Map<String, dynamic>.from(
      Hive.box("user").get(
        "selected_prayer_calculation_method",
        defaultValue:
            findClosestCalculationMethod(
              latLong.latitude,
              latLong.longitude,
            ).toMap(),
      ),
    );

    data.calculationMethod = CalculationMethod.fromMap(calculationMethod);
    data.isDataExits = PrayersTimeFunction.checkIsDataExits();
  }
  return data;
}
