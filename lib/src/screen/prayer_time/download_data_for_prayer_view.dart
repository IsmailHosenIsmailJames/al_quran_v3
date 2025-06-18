import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../widget/prayers/adress_from_lat_lon.dart";
import "../../widget/prayers/prayer_calculation_method_info_widget.dart";
import "../../widget/prayers/select_calculation_method.dart";
import "../location_handler/cubit/location_data_qibla_data_cubit.dart";

class DownloadDataForPrayerView extends StatefulWidget {
  final double lat;
  final double long;

  const DownloadDataForPrayerView({
    super.key,
    required this.lat,
    required this.long,
  });

  @override
  State<DownloadDataForPrayerView> createState() =>
      _DownloadDataForPrayerViewState();
}

class _DownloadDataForPrayerViewState extends State<DownloadDataForPrayerView> {
  bool isPrayerTimeDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                getAddressView(lat: widget.lat, long: widget.long),
              ],
            ),
            const Gap(15),
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
                      await showCalculationMethodPopup(context, (
                        calculationMethod,
                      ) {
                        context
                            .read<LocationQiblaPrayerDataCubit>()
                            .saveCalculationMethod(calculationMethod);

                        Navigator.pop(context);
                      });
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
            const Gap(30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () async {
                  setState(() {
                    isPrayerTimeDownloading = true;
                  });
                  await PrayersTimeFunction.downloadPrayerDataFromAPI(
                    lat: widget.lat,
                    lon: widget.long,
                    calculationMethod:
                        context
                            .read<LocationQiblaPrayerDataCubit>()
                            .state
                            .calculationMethod!,
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
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                        : const Icon(FluentIcons.arrow_download_24_filled),
                label: const Text("Download Prayer Time"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
