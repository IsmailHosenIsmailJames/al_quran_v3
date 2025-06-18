import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:geocoding/geocoding.dart";

import "../../theme/colors/app_colors.dart";
import "../../theme/values/values.dart";

Widget getAddressView({
  required double lat,
  required double long,
  bool keepDecoration = true,
  bool keepPadding = true,
  bool justAddress = false,
}) {
  return FutureBuilder(
    future: placemarkFromCoordinates(lat, long),
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

        return Container(
          decoration:
              keepDecoration
                  ? BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(roundedRadius),
                  )
                  : null,
          padding: keepPadding ? const EdgeInsets.all(5) : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$subAdministrativeArea, $administrativeArea, $country"),
              if (!justAddress) const Gap(5),
              if (!justAddress)
                Row(
                  children: [
                    const Text(
                      "Latitude: ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(lat.toString()),
                  ],
                ),
              if (!justAddress) const Gap(5),
              if (!justAddress)
                Row(
                  children: [
                    const Text(
                      "Longitude: ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(long.toString()),
                  ],
                ),
            ],
          ),
        );
      }
      return justAddress
          ? const SizedBox()
          : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text("Lat: $lat, Lon: $long"),
            ],
          );
    },
  );
}
