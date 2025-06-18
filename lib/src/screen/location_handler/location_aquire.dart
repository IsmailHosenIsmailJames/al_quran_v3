import "dart:developer";

import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/address_selection.dart";
import "package:al_quran_v3/src/screen/location_handler/manual_selection/cubit/manual_location_selection_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:geolocator/geolocator.dart";

class LocationAcquire extends StatefulWidget {
  const LocationAcquire({super.key});

  @override
  State<LocationAcquire> createState() => _LocationAcquireState();
}

class _LocationAcquireState extends State<LocationAcquire> {
  bool isGPSLocationLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Get Prayer Times and Qibla",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            Text(
              "Calculate Prayer Times and Qibla for Any Given Location.",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Gap(30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  setState(() {
                    isGPSLocationLoading = true;
                  });
                  try {
                    bool isServiceAvailable =
                        await Geolocator.isLocationServiceEnabled();
                    if (!isServiceAvailable) {
                      Fluttertoast.showToast(
                        msg: "Please enable location service",
                      );
                      await Geolocator.openLocationSettings();
                    }
                    LocationPermission permission =
                        await Geolocator.checkPermission();
                    if (!(permission == LocationPermission.whileInUse ||
                        permission == LocationPermission.always)) {
                      permission = await Geolocator.requestPermission();
                    }
                    permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.whileInUse ||
                        permission == LocationPermission.always) {
                      Position position = await Geolocator.getCurrentPosition();
                      context
                          .read<LocationQiblaPrayerDataCubit>()
                          .saveLocationData(
                            LatLon(
                              latitude: position.latitude,
                              longitude: position.longitude,
                            ),
                          );
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                  setState(() {
                    isGPSLocationLoading = false;
                  });
                },
                label: const Text("Get form GPS"),
                icon:
                    isGPSLocationLoading
                        ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                        : const Icon(Icons.gps_fixed_rounded),
              ),
            ),
            const Gap(5),
            const Align(alignment: Alignment.center, child: Text("Or")),
            const Gap(5),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (context) => ManualLocationSelectionCubit(),
                            child: const AddressSelection(),
                          ),
                    ),
                  );
                },
                label: const Text("Select you City"),
                icon: const Icon(Icons.location_city_rounded),
              ),
            ),
            const Gap(20),
            Text(
              "Note: If you don't want to use GPS or not feel secure, you can select your city.",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
