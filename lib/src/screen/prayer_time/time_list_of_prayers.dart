import "dart:async";

import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_time_canvas.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:geocoding/geocoding.dart";
import "package:intl/intl.dart";

import "models/prayer_model_of_day.dart";

class TimeListOfPrayers extends StatefulWidget {
  final double lat;
  final double lon;
  const TimeListOfPrayers({super.key, required this.lat, required this.lon});

  @override
  State<TimeListOfPrayers> createState() => _TimeListOfPrayersState();
}

class _TimeListOfPrayersState extends State<TimeListOfPrayers> {
  @override
  void initState() {
    PrayersTimeFunction.loadPrayersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleOfTimes = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    return Container(
      color: AppColors.primaryDark,
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Gap(10),
                  const Icon(
                    FluentIcons.location_24_regular,
                    color: Colors.white,
                  ),
                  const Gap(5),
                  FutureBuilder(
                    future: placemarkFromCoordinates(widget.lat, widget.lon),
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
                          subAdministrativeArea ??=
                              placemark.subAdministrativeArea;
                        }
                        return Text(
                          "$subAdministrativeArea",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        );
                      }
                      return const Text("");
                    },
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () async {
                      PrayersTimeFunction.nextPrayerName(
                        PrayersTimeFunction.getTodaysPrayerTime(
                          DateTime.now(),
                        )!,
                      );
                    },
                    icon: const Icon(
                      Icons.my_location_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                  right: 30,
                  top: 10,
                ),
                child: Row(
                  children: [
                    getNextPrayerTimeWidget(context),
                    Gap(10),
                    const Expanded(flex: 6, child: PrayerTimeCanvas()),
                  ],
                ),
              ),
            ],
          ),
          const Gap(30),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(roundedRadius + 12),
                  topRight: Radius.circular(roundedRadius + 12),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  PrayerModelOfDay? prayerModelOfDay =
                      PrayersTimeFunction.getTodaysPrayerTime(
                        DateTime.now().add(Duration(days: index)),
                      );
                  if (prayerModelOfDay == null) {
                    return Text("${DateTime.now()} Found Empty");
                  }
                  DateTime? dateOfThis;
                  if (prayerModelOfDay.date.gregorian.date != null) {
                    dateOfThis = DateFormat(
                      "dd-MM-yyyy",
                    ).tryParse(prayerModelOfDay.date.gregorian.date!);
                  }
                  if (dateOfThis == null ||
                      dateOfThis.isBefore(
                        DateTime.now().subtract(const Duration(days: 1)),
                      )) {
                    return const SizedBox();
                  }

                  Map<PrayerModelTimesType, TimeOfDay> mapOfTimes =
                      PrayersTimeFunction.getPrayerTimings(prayerModelOfDay);
                  PrayerModelTimesType nextPrayer =
                      PrayersTimeFunction.nextPrayerName(prayerModelOfDay);

                  bool isToday = dateOfThis.isAtSameDayAs(DateTime.now());
                  int? indexOfCurrentPrayer;
                  if (isToday) {
                    indexOfCurrentPrayer = PrayerModelTimesType.values.indexOf(
                      nextPrayer,
                    );
                  }
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          isToday
                              ? "Today"
                              : DateFormat.yMMMEd().format(dateOfThis),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade400,
                          ),
                        ),
                      ),
                      const Divider(),
                      ...List.generate(mapOfTimes.length, (i) {
                        bool isThisIsCurrentPrayer = i == indexOfCurrentPrayer;
                        return Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration:
                              isThisIsCurrentPrayer
                                  ? BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    border: Border.all(
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      roundedRadius,
                                    ),
                                  )
                                  : null,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                mapOfTimes.keys.elementAt(i).name.capitalize(),
                                style: textStyleOfTimes,
                              ),
                              const Spacer(),
                              Text(
                                mapOfTimes.values.elementAt(i).format(context),
                                style: textStyleOfTimes,
                              ),
                              const Gap(10),
                              const SizedBox(
                                height: 30,
                                // width: 36,
                                // child:
                                //     !isToday
                                //         ? null
                                //         : IconButton(
                                //           padding: EdgeInsets.zero,
                                //           style: IconButton.styleFrom(
                                //             padding: EdgeInsets.zero,
                                //           ),
                                //           onPressed: () {},
                                //           icon: const Icon(
                                //             Icons.volume_up_outlined,
                                //           ),
                                //         ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const Gap(30),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded getNextPrayerTimeWidget(BuildContext context) {
    return Expanded(
      flex: 4,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              PrayersTimeFunction.nextPrayerName(
                PrayersTimeFunction.getTodaysPrayerTime(DateTime.now())!,
              ).name.toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              PrayersTimeFunction.nextPrayerTime(
                PrayersTimeFunction.getTodaysPrayerTime(DateTime.now())!,
              ).format(context),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Left",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(5),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 12,
                  color: Colors.white,
                ),
                const Gap(5),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1), (timer) {
                    return DateTime.now();
                  }),
                  builder: (context, snapshot) {
                    DateTime targetTime = snapshot.data as DateTime;
                    TimeOfDay nextPrayerTime =
                        PrayersTimeFunction.nextPrayerTime(
                          PrayersTimeFunction.getTodaysPrayerTime(targetTime)!,
                        );

                    Duration timeUntilNextPrayer = DateTime.now()
                        .copyWith(
                          hour: nextPrayerTime.hour,
                          minute: nextPrayerTime.minute,
                          second: 0,
                        )
                        .difference(targetTime);

                    return Text(
                      "${timeUntilNextPrayer.inHours.toString().padLeft(2, '0')}:${(timeUntilNextPrayer.inMinutes % 60).toString().padLeft(2, '0')}:${(timeUntilNextPrayer.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int? getCurrentPrayerIndex(List<Map<String, dynamic>> listOfTimes) {
    for (int i = 0; i < listOfTimes.length; i++) {
      if (listOfTimes[i]["time"] != null) {
        TimeOfDay timeOfDay = listOfTimes[i]["time"] as TimeOfDay;
        if (timeOfDay.isAfter(TimeOfDay.now())) {
          return i;
        }
      }
    }
    return null;
  }
}
