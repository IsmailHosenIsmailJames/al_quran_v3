import "dart:developer";

import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/find_cloest_calculation_method.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:al_quran_v3/src/screen/prayer_time/time_list_of_prayers.dart";
import "package:al_quran_v3/src/widget/prayers/adress_from_lat_lon.dart";
import "package:al_quran_v3/src/widget/prayers/prayer_calculation_method_info_widget.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({super.key});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  bool isPrayerTimeDownloading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationDataQiblaDataCubit, LocationDataQiblaDataState>(
      builder: (context, state) {
        if (state.latLon == null) {
          return const LocationAcquire();
        } else {
          if (PrayersTimeFunction.checkIsDataExits() == false) {
            return downloadPrayerTimeWidget(
              state.latLon!.latitude,
              state.latLon!.longitude,
            );
          }

          return TimeListOfPrayers(
            lat: state.latLon!.latitude,
            lon: state.latLon!.longitude,
          );
        }
      },
    );
  }

  Widget downloadPrayerTimeWidget(double lat, double lon) {
    CalculationMethod selectedCalculationMethod = findClosestCalculationMethod(
      lat,
      lon,
    );
    log(selectedCalculationMethod.id.toString(), name: "Calculation Method");
    log(selectedCalculationMethod.name.toString(), name: "Calculation Method");

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Address: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const Gap(5),
              getAddressView(lat: lat, long: lon),
            ],
          ),
          const Gap(15),
          const Text(
            "Calculation Method: ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const Gap(5),
          getPrayerCalculationMethodInfoWidget(selectedCalculationMethod),
          const Gap(30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: () async {
                setState(() {
                  isPrayerTimeDownloading = true;
                });
                await PrayersTimeFunction.downloadPrayerDataFromAPI(
                  lat,
                  lon,
                  selectedCalculationMethod,
                );
                setState(() {
                  isPrayerTimeDownloading = false;
                });
              },
              icon:
                  isPrayerTimeDownloading == true
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                      : const Icon(FluentIcons.arrow_download_16_filled),
              label: const Text("Download Data for Prayer Time"),
            ),
          ),
        ],
      ),
    );
  }
}
