import "dart:convert";

import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/time_list_of_prayers.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:geocoding/geocoding.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:http/http.dart";

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
          if (Hive.box("prayer_time_data").keys.isEmpty) {
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: placemarkFromCoordinates(lat, lon),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                String? country;

                String? administrativeArea;
                String? subAdministrativeArea;

                for (Placemark placemark in snapshot.data ?? []) {
                  country ??= placemark.country;
                  administrativeArea ??= placemark.administrativeArea;
                  subAdministrativeArea ??= placemark.subAdministrativeArea;
                }
                return Column(
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(roundedRadius),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$subAdministrativeArea, $administrativeArea, $country",
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Text(
                                "Latitude: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(lat.toString()),
                            ],
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Text(
                                "Longitude: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(lon.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Text("Lat: $lat, Lon: $lon");
            },
          ),
          const Gap(30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: () async {
                downloadPrayerDataFromAPI(lat, lon);
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

  bool isPrayerTimeDownloading = false;

  Future<void> downloadPrayerDataFromAPI(double lat, double lon) async {
    setState(() {
      isPrayerTimeDownloading = true;
    });
    final response = await get(
      Uri.parse(
        "${ApisUrls.basePrayerTime}calendar/${DateTime.now().year}?latitude=$lat&longitude=$lon",
      ),
    );

    if (response.statusCode == 200) {
      Map infoList = jsonDecode(response.body)["data"];
      for (var key in infoList.keys) {
        await Hive.box("prayer_time_data").put(key, infoList[key]);
      }
    }

    setState(() {
      isPrayerTimeDownloading = false;
    });
  }
}
