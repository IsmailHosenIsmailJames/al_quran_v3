import "package:al_quran_v3/src/screen/prayer_time/download_data_for_prayer_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../widget/prayers/prayer_calculation_method_info_widget.dart";
import "../location_handler/cubit/location_data_qibla_data_cubit.dart";

class PrayerSettings extends StatefulWidget {
  const PrayerSettings({super.key});

  @override
  State<PrayerSettings> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prayer Settings")),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
          bottom: 80,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Calculation Method: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 30,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                  ),
                  onPressed: () async {
                    var state =
                        context.read<LocationQiblaPrayerDataCubit>().state;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DownloadDataForPrayerView(
                              lat: state.latLon!.latitude,
                              long: state.latLon!.latitude,
                              showCalculationMethodPopupAtOnInit: true,
                              moveToDownload: true,
                            ),
                      ),
                    );
                  },
                  child: const Text("Change"),
                ),
              ),
            ],
          ),
          const Gap(5),
          getPrayerCalculationMethodInfoWidget(
            context
                .read<LocationQiblaPrayerDataCubit>()
                .state
                .calculationMethod!,
          ),
        ],
      ),
    );
  }
}
