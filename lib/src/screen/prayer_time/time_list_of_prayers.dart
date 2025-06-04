import "dart:async";
import "dart:developer";
import "dart:io";

import "package:al_quran_v3/src/screen/prayer_time/prayer_time_canvas.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:alarm/alarm.dart";
import "package:alarm/model/alarm_settings.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:geocoding/geocoding.dart";
import "package:hive/hive.dart";
import "package:intl/intl.dart";
import "package:permission_handler/permission_handler.dart";

import "models/prayer_model_of_day.dart";

class TimeListOfPrayers extends StatefulWidget {
  final double lat;
  final double lon;
  const TimeListOfPrayers({super.key, required this.lat, required this.lon});

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
                      await Permission.notification.request();
                      await Permission.accessNotificationPolicy.request();
                      await Permission.scheduleExactAlarm.request();

                      final alarmSettings = AlarmSettings(
                        id: 42,
                        dateTime: DateTime.now().add(
                          const Duration(seconds: 30),
                        ),
                        assetAudioPath:
                            "assets/adhan/adhan_by_Ahamed_al_Nafees.mp3",
                        loopAudio: true,
                        vibrate: true,
                        warningNotificationOnKill: Platform.isIOS,
                        androidFullScreenIntent: true,
                        volumeSettings: VolumeSettings.fade(
                          volume: 1,
                          fadeDuration: const Duration(seconds: 5),
                          volumeEnforced: true,
                        ),
                        notificationSettings: const NotificationSettings(
                          title: "This is the title",
                          body: "This is the body",
                          stopButton: "Stop the alarm",
                          icon: "notification_icon",
                          iconColor: Color(0xff862778),
                        ),
                      );

                      await Alarm.set(alarmSettings: alarmSettings);
                      Fluttertoast.showToast(msg: "Alarm Set");
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
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Duhur".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            const TimeOfDay(
                              hour: 11,
                              minute: 59,
                            ).format(context),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Left",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                              const Gap(5),
                              StreamBuilder(
                                stream: Stream.periodic(
                                  const Duration(seconds: 1),
                                  (timer) {
                                    return DateTime.now();
                                  },
                                ),
                                builder: (context, snapshot) {
                                  DateTime targetTime = DateTime.now();
                                  targetTime = targetTime.copyWith(
                                    hour: 11,
                                    minute: 58,
                                    second: 0,
                                  );
                                  if (targetTime.isBefore(DateTime.now())) {
                                    targetTime = targetTime.add(
                                      const Duration(days: 1),
                                    );
                                  }
                                  Duration timeLeft = targetTime.difference(
                                    DateTime.now(),
                                  );
                                  String hours = timeLeft.inHours
                                      .toString()
                                      .padLeft(2, "0");
                                  String minutes = timeLeft.inMinutes
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, "0");
                                  String seconds = timeLeft.inSeconds
                                      .remainder(60)
                                      .toString()
                                      .padLeft(2, "0");
                                  return Text(
                                    "$hours:$minutes:$seconds",
                                    style: const TextStyle(
                                      fontSize: 14,
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
                    const Expanded(flex: 6, child: PrayerTimeCanvas()),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
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
                    return const SizedBox();
                  }

                  String? fajr = prayerModelOfDay.timings?.fajr;
                  String? dhuhr = prayerModelOfDay.timings?.dhuhr;
                  String? asr = prayerModelOfDay.timings?.asr;
                  String? maghrib = prayerModelOfDay.timings?.maghrib;
                  String? isha = prayerModelOfDay.timings?.isha;
                  String? midnight = prayerModelOfDay.timings?.midnight;
                  String? sunrise = prayerModelOfDay.timings?.sunrise;
                  String? sunset = prayerModelOfDay.timings?.sunset;
                  String? imsak = prayerModelOfDay.timings?.imsak;

                  List<Map<String, dynamic>> listOfTimes = [
                    {"name": "Fajr", "time": timeOfDay(fajr)},
                    {"name": "Sunrise", "time": timeOfDay(sunrise)},
                    {"name": "Dhuhr", "time": timeOfDay(dhuhr)},
                    {"name": "Asr", "time": timeOfDay(asr)},
                    {"name": "Sunset", "time": timeOfDay(sunset)},
                    {"name": "Maghrib", "time": timeOfDay(maghrib)},
                    {"name": "Isha", "time": timeOfDay(isha)},
                    {"name": "Midnight", "time": timeOfDay(midnight)},
                    {"name": "Imsak", "time": timeOfDay(imsak)},
                  ];

                  bool isToday = dateOfThis.isAtSameDayAs(DateTime.now());
                  int? indexOfCurrentPrayer;
                  if (isToday) {
                    indexOfCurrentPrayer = getCurrentPrayerIndex(listOfTimes);
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
                      ...List.generate(listOfTimes.length, (i) {
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
                                listOfTimes[i]["name"]!,
                                style: textStyleOfTimes,
                              ),
                              const Spacer(),
                              Text(
                                (listOfTimes[i]["time"] as TimeOfDay?)?.format(
                                      context,
                                    ) ??
                                    "N/A",
                                style: textStyleOfTimes,
                              ),
                              const Gap(10),
                              SizedBox(
                                height: 36,
                                width: 36,
                                child:
                                    !isToday
                                        ? null
                                        : IconButton(
                                          padding: EdgeInsets.zero,
                                          style: IconButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.volume_up_outlined,
                                          ),
                                        ),
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

  TimeOfDay? timeOfDay(String? time) {
    if (time == null) return null;
    TimeOfDay? timeOfDay;
    try {
      final timeString = (time).split(" ")[0];
      final dateTime = DateFormat("HH:mm").parse(timeString);
      timeOfDay = TimeOfDay.fromDateTime(dateTime);
    } catch (e) {
      log("Error parsing time: $time, Error: $e");
    }
    return timeOfDay;
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
