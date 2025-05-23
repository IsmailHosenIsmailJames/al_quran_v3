import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_model_of_day.dart";
import "package:al_quran_v3/src/screen/prayer_time/time_list_of_prayers.dart";
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

          return const TimeListOfPrayers();
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
            future: placemarkFromCoordinates(52.2165157, 6.9437819),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                String? name;
                String? street;
                String? isoCountryCode;
                String? country;
                String? postalCode;
                String? administrativeArea;
                String? subAdministrativeArea;
                String? locality;
                String? subLocality;
                String? thoroughfare;
                String? subThoroughfare;
                for (Placemark placemark in snapshot.data ?? []) {
                  name ??= placemark.name;
                  street ??= placemark.street;
                  isoCountryCode ??= placemark.isoCountryCode;
                  country ??= placemark.country;
                  postalCode ??= placemark.postalCode;
                  administrativeArea ??= placemark.administrativeArea;
                  subAdministrativeArea ??= placemark.subAdministrativeArea;
                  locality ??= placemark.locality;
                  subLocality ??= placemark.subLocality;
                  thoroughfare ??= placemark.thoroughfare;
                  subThoroughfare ??= placemark.subThoroughfare;
                }
                return Column(
                  children: [
                    if (name != null)
                      Row(
                        children: [
                          const Text(
                            "Name:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (street != null)
                      Row(
                        children: [
                          const Text(
                            "Street:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            street,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (isoCountryCode != null)
                      Row(
                        children: [
                          const Text(
                            "Iso Country Code:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            isoCountryCode,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (country != null)
                      Row(
                        children: [
                          const Text(
                            "Country:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            country,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (postalCode != null)
                      Row(
                        children: [
                          const Text(
                            "Postal Code:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            postalCode,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (administrativeArea != null)
                      Row(
                        children: [
                          const Text(
                            "Administrative Area:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            administrativeArea,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (subAdministrativeArea != null)
                      Row(
                        children: [
                          const Text(
                            "SubAdministrative Area:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            subAdministrativeArea,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (locality != null)
                      Row(
                        children: [
                          const Text(
                            "Locality:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            locality,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (subLocality != null)
                      Row(
                        children: [
                          const Text(
                            "Sub Locality:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            subLocality,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (thoroughfare != null)
                      Row(
                        children: [
                          const Text(
                            "Thoroughfare:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            thoroughfare,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    if (subThoroughfare != null)
                      Row(
                        children: [
                          const Text(
                            "Sub Thoroughfare:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            subThoroughfare,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              }
              return Text("Lat: $lat, Lon: $lon");
            },
          ),
          const Gap(10),
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
