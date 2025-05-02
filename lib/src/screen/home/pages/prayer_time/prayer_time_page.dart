import 'package:al_quran_v3/src/screen/home/pages/location_handler/cubit/location_data_qibla_data_cubit.dart';
import 'package:al_quran_v3/src/screen/home/pages/location_handler/location_aquire.dart';
import 'package:al_quran_v3/src/screen/home/pages/location_handler/model/location_data_qibla_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_times/prayers_times.dart';

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({super.key});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationDataQiblaDataCubit, LocationDataQiblaDataState>(
      builder: (context, state) {
        if (state.latLon == null) {
          return const LocationAcquire();
        } else {
          Coordinates coordinates = Coordinates(21.1959, 72.7933);

          // Specify the calculation parameters for prayer times
          PrayerCalculationParameters params =
              PrayerCalculationMethod.karachi();
          params.madhab = PrayerMadhab.hanafi;

          // Create a PrayerTimes instance for the specified location
          PrayerTimes prayerTimes = PrayerTimes(
            coordinates: coordinates,
            calculationParameters: params,
            precision: true,
            locationName: 'Asia/Kolkata',
          );
          return Center(
            child: Text(
              '${prayerTimes.nextPrayer()} - ${TimeOfDay.fromDateTime(prayerTimes.timeForPrayer(prayerTimes.nextPrayer()) ?? DateTime.now()).format(context)}',
            ),
          );
        }
      },
    );
  }
}
