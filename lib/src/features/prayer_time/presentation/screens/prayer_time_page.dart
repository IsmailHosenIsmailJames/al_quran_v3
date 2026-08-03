import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/location/presentation/screens/location_acquire_screen.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/time_list_of_prayers.dart";
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
        if (state.latLon == null) {
          return const LocationAcquire();
        } else {
          return const TimeListOfPrayers();
        }
      },
    );
  }
}
