import "package:adhan/adhan.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/location_handler/model/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_calculation_method_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_time_canvas.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";

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
          return BlocBuilder<
            PrayerTimeCalculationMethodCubit,
            CalculationParameters
          >(
            builder: (context, parameters) {
              return Container(
                color: AppColors.primaryColor.withValues(alpha: 0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(10),
                    PrayerTimeCanvas(
                      coordinates: Coordinates(
                        state.latLon!.latitude,
                        state.latLon!.longitude,
                        validate: true,
                      ),
                      parameters: parameters,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey.shade100
                                  : Colors.grey.shade900,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Calculation Method"),
                                      const Gap(8),
                                      Row(
                                        children: [
                                          Text(
                                            parameters.method.name.capitalize(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Gap(20),
                                          SizedBox(
                                            height: 25,
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text("Change"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),

                                  IconButton(
                                    onPressed: () {},
                                    icon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        FluentIcons.calendar_24_regular,
                                      ),
                                    ),
                                  ),

                                  PopupMenuButton(
                                    itemBuilder: (context) {
                                      return [
                                        const PopupMenuItem(
                                          child: Text("Countdown"),
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Show"),
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Calculation Settings"),
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Mute"),
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Share"),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20,
                                  bottom: 60,
                                ),
                                itemCount: 30,
                                itemBuilder: (context, index) {
                                  DateTime currentDatetime = DateTime.now().add(
                                    Duration(days: index),
                                  );
                                  bool isToday = currentDatetime.isToday;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Gap(10),
                                      Text(
                                        isToday
                                            ? "Today"
                                            : DateFormat(
                                              DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                                            ).format(currentDatetime),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).brightness ==
                                                      Brightness.light
                                                  ? Colors.grey.shade600
                                                  : Colors.grey.shade400,
                                        ),
                                      ),
                                      const Divider(),
                                      getPrayersTimesCard(
                                        dateTime: currentDatetime,
                                        coordinates: Coordinates(
                                          state.latLon!.latitude,
                                          state.latLon!.longitude,
                                          validate: true,
                                        ),
                                        params: parameters,
                                        context: context,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Column getPrayersTimesCard({
    required Coordinates coordinates,
    required DateTime dateTime,
    required BuildContext context,
    required CalculationParameters params,
  }) {
    TextStyle textStyeOfTimes = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    final prayerTimes = PrayerTimes(
      coordinates,
      DateComponents(dateTime.year, dateTime.month, dateTime.day),
      params,
    );

    return Column(
      children: [
        Row(
          children: [
            Text("Fajr", style: textStyeOfTimes),
            const Spacer(),
            Text(
              TimeOfDay.fromDateTime(prayerTimes.fajr).format(context),
              style: textStyeOfTimes,
            ),
            const Gap(20),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.volume_up_rounded),
            ),
          ],
        ),
        Row(
          children: [
            Text("Sunrise", style: textStyeOfTimes),
            const Spacer(),
            Text(
              TimeOfDay.fromDateTime(prayerTimes.sunrise).format(context),
              style: textStyeOfTimes,
            ),
            const Gap(20),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.volume_up_rounded),
            ),
          ],
        ),
        Row(
          children: [
            Text("Dhuhr", style: textStyeOfTimes),
            const Spacer(),
            Text(
              TimeOfDay.fromDateTime(prayerTimes.dhuhr).format(context),
              style: textStyeOfTimes,
            ),
            const Gap(20),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.volume_up_rounded),
            ),
          ],
        ),
        Row(
          children: [
            Text("Asr", style: textStyeOfTimes),
            const Spacer(),
            Text(
              TimeOfDay.fromDateTime(prayerTimes.asr).format(context),
              style: textStyeOfTimes,
            ),
            const Gap(20),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.volume_up_rounded),
            ),
          ],
        ),
        Row(
          children: [
            Text("Maghrib", style: textStyeOfTimes),
            const Spacer(),
            Text(
              TimeOfDay.fromDateTime(prayerTimes.maghrib).format(context),
              style: textStyeOfTimes,
            ),
            const Gap(20),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.volume_up_rounded),
            ),
          ],
        ),
        Row(
          children: [
            Text("Isha", style: textStyeOfTimes),
            const Spacer(),
            Text(
              TimeOfDay.fromDateTime(prayerTimes.isha).format(context),
              style: textStyeOfTimes,
            ),
            const Gap(20),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.volume_up_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
