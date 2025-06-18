import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:al_quran_v3/src/widget/prayers/adress_from_lat_lon.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

import "../../theme/colors/app_colors.dart";
import "../../theme/values/values.dart";

Widget getPrayerCalculationMethodInfoWidget(
  CalculationMethod calculationMethod,
) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primary),
      borderRadius: BorderRadius.circular(roundedRadius),
    ),
    padding: const EdgeInsets.all(5),
    child: Column(
      children: [
        Row(
          children: <Widget>[
            const Text("Name: ", style: TextStyle(color: Colors.grey)),
            Text(calculationMethod.name.toString()),
          ],
        ),
        if (calculationMethod.location != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Location: ", style: TextStyle(color: Colors.grey)),
              getAddressView(
                lat: calculationMethod.location!.latitude,
                long: calculationMethod.location!.longitude,
                keepDecoration: false,
                justAddress: true,
                keepPadding: false,
              ),
            ],
          ),
        const Gap(5),
        if (calculationMethod.params != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Parameters: ", style: TextStyle(color: Colors.grey)),
              const Gap(5),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryShade100,
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (calculationMethod.params!.fajr != null)
                      Row(
                        children: <Widget>[
                          const Text(
                            "Fajr: ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(calculationMethod.params!.fajr!),
                        ],
                      ),
                    if (calculationMethod.params!.isha != null)
                      Row(
                        children: <Widget>[
                          const Text(
                            "Isha: ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(calculationMethod.params!.isha!),
                        ],
                      ),
                    if (calculationMethod.params?.maghrib != null)
                      Row(
                        children: <Widget>[
                          const Text(
                            "Maghrib: ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(calculationMethod.params!.maghrib!),
                        ],
                      ),
                    if (calculationMethod.params!.midnight != null)
                      Row(
                        children: <Widget>[
                          const Text(
                            "Midnight: ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(calculationMethod.params!.midnight!),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
      ],
    ),
  );
}
