import "dart:developer";

import "package:adhan/adhan.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";

class PrayerTimeCanvas extends StatefulWidget {
  final Coordinates coordinates;
  final CalculationParameters parameters;
  const PrayerTimeCanvas({
    super.key,
    required this.coordinates,
    required this.parameters,
  });

  @override
  State<PrayerTimeCanvas> createState() => _PrayerTimeCanvasState();
}

class _PrayerTimeCanvasState extends State<PrayerTimeCanvas> {
  @override
  Widget build(BuildContext context) {
    final prayerTimes = PrayerTimes(
      widget.coordinates,
      DateComponents.from(DateTime.now()),
      widget.parameters,
    );
    Prayer current = prayerTimes.nextPrayer();
    log(current.name);
    return Row(
      children: [
        Column(
          children: [
            Text(
              TimeOfDay.fromDateTime(
                prayerTimes.timeForPrayer(current)!,
              ).format(context),
            ),
            Text(prayerTimes.fajr.timeZoneName),
          ],
        ),
        Container(
          height: 200,
          width: 200,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: AppColors.primaryColor.withValues(alpha: 0.2),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Prayer Time Painter Canvas\nUnder Dev",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
