import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:al_quran_v3/src/widget/prayers/adress_from_lat_lon.dart";
import "package:flex_color_picker/flex_color_picker.dart";
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Name: ", style: TextStyle(color: Colors.grey)),
            Expanded(child: Text(calculationMethod.name.toString())),
          ],
        ),
        if (calculationMethod.location != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Location: ", style: TextStyle(color: Colors.grey)),
              Expanded(
                child: getAddressView(
                  lat: calculationMethod.location!.latitude,
                  long: calculationMethod.location!.longitude,
                  keepDecoration: false,
                  justAddress: true,
                  keepPadding: false,
                ),
              ),
            ],
          ),
        const Gap(5),
        if (calculationMethod.params != null)
          const Text("Parameters: ", style: TextStyle(color: Colors.grey)),
        const Gap(5),
        if (calculationMethod.params != null)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(calculationMethod.params!.toMap().length, (
              index,
            ) {
              String? currentValue = calculationMethod.params!
                  .toMap()
                  .values
                  .elementAt(index);
              String currentKey = calculationMethod.params!
                  .toMap()
                  .keys
                  .elementAt(index);
              if (currentValue == null) return const SizedBox();
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryShade100,
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${currentKey.capitalize}: ",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(currentValue),
                  ],
                ),
              );
            }),
          ),
      ],
    ),
  );
}
