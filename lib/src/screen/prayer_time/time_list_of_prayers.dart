import "dart:developer";

import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:hive/hive.dart";
import "package:intl/intl.dart";

import "models/prayer_model_of_day.dart";

class TimeListOfPrayers extends StatefulWidget {
  const TimeListOfPrayers({super.key});

  @override
  State<TimeListOfPrayers> createState() => _TimeListOfPrayersState();
}

class _TimeListOfPrayersState extends State<TimeListOfPrayers> {
  int monthNumber = DateTime.now().month;
  List prayerTimeMapData = [];

  @override
  void initState() {
    prayerTimeMapData = Hive.box(
      "prayer_time_data",
    ).get("$monthNumber", defaultValue: []);
    if (monthNumber < 12) {
      prayerTimeMapData.addAll(
        Hive.box(
          "prayer_time_data",
        ).get("${monthNumber + 1}", defaultValue: []),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleOfTimes = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: prayerTimeMapData.length,
      itemBuilder: (context, index) {
        PrayerModelOfDay prayerModelOfDay = PrayerModelOfDay.fromMap(
          Map<String, dynamic>.from(prayerTimeMapData[index]),
        );
        DateTime? dateOfThis;
        if (prayerModelOfDay.date?.gregorian?.date != null) {
          dateOfThis = DateFormat(
            "dd-MM-yyyy",
          ).tryParse(prayerModelOfDay.date!.gregorian!.date!);
        }
        if (dateOfThis == null ||
            dateOfThis.isBefore(
              DateTime.now().subtract(const Duration(days: 1)),
            )) {
          print(dateOfThis);
          return const SizedBox();
        }
        String? date = prayerModelOfDay.date?.readable;
        String? fajr = prayerModelOfDay.timings?.fajr;
        String? dhuhr = prayerModelOfDay.timings?.dhuhr;
        String? asr = prayerModelOfDay.timings?.asr;
        String? maghrib = prayerModelOfDay.timings?.maghrib;
        String? isha = prayerModelOfDay.timings?.isha;
        String? midnight = prayerModelOfDay.timings?.midnight;
        String? sunrise = prayerModelOfDay.timings?.sunrise;
        String? sunset = prayerModelOfDay.timings?.sunset;
        String? imsak = prayerModelOfDay.timings?.imsak;

        return Column(
          children: [
            const Gap(30),
            Text(
              dateOfThis.isAtSameDayAs(DateTime.now()) ? "Today" : DateFormat.yMMMEd().format(dateOfThis) ?? "",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade600
                        : Colors.grey.shade400,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Fajr", style: textStyleOfTimes),
                Text(fajr ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Sunrise", style: textStyleOfTimes),
                Text(sunrise ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Dhuhr", style: textStyleOfTimes),
                Text(dhuhr ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Asr", style: textStyleOfTimes),
                Text(asr ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Maghrib", style: textStyleOfTimes),
                Text(maghrib ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Isha", style: textStyleOfTimes),
                Text(isha ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Midnight", style: textStyleOfTimes),
                Text(midnight ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Imsak", style: textStyleOfTimes),
                Text(imsak ?? "N/A", style: textStyleOfTimes),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Fajr", style: textStyleOfTimes),
                Text(fajr ?? "N/A", style: textStyleOfTimes),
              ],
            ),
          ],
        );
      },
    );
  }
}
