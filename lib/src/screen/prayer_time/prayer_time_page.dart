import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/download_data_for_prayer_view.dart";
import "package:al_quran_v3/src/screen/prayer_time/time_list_of_prayers.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({super.key});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      LocationQiblaPrayerDataCubit,
      LocationQiblaPrayerDataState
    >(
      builder: (context, state) {
        if (state.latLon == null || state.calculationMethod == null) {
          return const LocationAcquire();
        } else if (state.calculationMethod == null) {
          return CalculationMethodDataForPrayerView(
            lat: state.latLon!.latitude,
            long: state.latLon!.longitude,
          );
        } else {
          return TimeListOfPrayers(
            lat: state.latLon!.latitude,
            lon: state.latLon!.longitude,
          );
        }
      },
    );
  }
}
