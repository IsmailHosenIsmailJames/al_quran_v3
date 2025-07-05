import "dart:async";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/functions/format_time_of_day.dart";
import "package:al_quran_v3/src/functions/localizedPrayerName.dart";
import "package:al_quran_v3/src/functions/number_localization.dart";
import "package:al_quran_v3/src/screen/location_handler/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/screen/location_handler/location_aquire.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/prayers_time_bg_process.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/permissions_for_notifications.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_settings.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_time_canvas.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/prayers/adress_from_lat_lon.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";
import "models/prayer_model_of_day.dart";
import "models/prayer_types.dart";

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
    final l10n = AppLocalizations.of(context);
    TextStyle textStyleOfTimes = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Container(
          color: Color.alphaBlend(themeState.primaryShade300, Colors.black),
          child: Column(
            children: [
              Column(
                children: [
                  const Gap(7),
                  Row(
                    children: [
                      const Gap(10),
                      const Icon(
                        FluentIcons.location_24_regular,
                        color: Colors.white,
                      ),
                      const Gap(5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: getAddressView(
                          context: context,
                          lat: widget.lat,
                          long: widget.lon,
                          keepPadding: false,
                          justAddress: true,
                          keepDecoration: false,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const LocationAcquire(
                                    moveToDownload: true,
                                  ),
                            ),
                          );
                          context
                              .read<LocationQiblaPrayerDataCubit>()
                              .alignWithDatabase();
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
                        getNextPrayerTimeWidget(context, l10n),
                        const Gap(10),
                        const Expanded(flex: 6, child: PrayerTimeCanvas()),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(roundedRadius + 10),
                    topRight: Radius.circular(roundedRadius + 10),
                  ),
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(15),
                      itemBuilder: (context, index) {
                        PrayerModelOfDay? prayerModelOfDay =
                            PrayersTimeFunction.getTodaysPrayerTime(
                              DateTime.now().add(Duration(days: index)),
                            );
                        if (prayerModelOfDay == null) {
                          return Text(
                            l10n.dateFoundEmpty(DateTime.now().toString()),
                          );
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
                            PrayersTimeFunction.getPrayerTimings(
                              prayerModelOfDay,
                            );
                        PrayerModelTimesType nextPrayer =
                            PrayersTimeFunction.nextPrayerName(
                              prayerModelOfDay,
                            );

                        bool isToday = dateOfThis.isAtSameDayAs(DateTime.now());
                        int? indexOfCurrentPrayer;
                        if (isToday) {
                          indexOfCurrentPrayer = PrayerModelTimesType.values
                              .indexOf(nextPrayer);
                        }
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isToday
                                      ? l10n.today
                                      : DateFormat.yMMMEd(
                                        l10n.localeName,
                                      ).format(dateOfThis),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.grey.shade600
                                            : Colors.grey.shade400,
                                  ),
                                ),
                                if (isToday)
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const PrayerSettings(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      FluentIcons.settings_24_filled,
                                      color: themeState.primary,
                                    ),
                                  ),
                              ],
                            ),
                            const Divider(),
                            ...List.generate(mapOfTimes.length, (i) {
                              bool isThisIsCurrentPrayer =
                                  i == indexOfCurrentPrayer;
                              PrayerModelTimesType prayerModelType = mapOfTimes
                                  .keys
                                  .elementAt(i);
                              return getRowWidgetForEachPrayer(
                                isThisIsCurrentPrayer,
                                prayerModelType,
                                textStyleOfTimes,
                                mapOfTimes,
                                i,
                                context,
                                isToday,
                                themeState,
                                l10n,
                              );
                            }),
                            const Gap(30),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getRowWidgetForEachPrayer(
    bool isThisIsCurrentPrayer,
    PrayerModelTimesType prayerModelType,
    TextStyle textStyleOfTimes,
    Map<PrayerModelTimesType, TimeOfDay> mapOfTimes,
    int i,
    BuildContext context,
    bool isToday,
    ThemeState themeState,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
      builder: (context, prayerReminderState) {
        List<ReminderTypeWithPrayModel> listOfToRemind =
            prayerReminderState.prayerToRemember;

        ReminderTypeWithPrayModel? currentReminder = listOfToRemind
            .firstOrNullWhere(
              (element) => element.prayerTimesType == prayerModelType,
            );

        bool isCurrentToRemind = currentReminder != null;

        ReminderTypeWithPrayModel defaultWhenEnable = ReminderTypeWithPrayModel(
          reminderType:
              prayerReminderState.previousReminderModes[prayerModelType] ??
              PrayerReminderType.alarm,
          prayerTimesType: prayerModelType,
        );

        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration:
              isThisIsCurrentPrayer
                  ? BoxDecoration(
                    color: themeState.primary.withValues(alpha: 0.1),
                    border: Border.all(color: themeState.primary),
                    borderRadius: BorderRadius.circular(roundedRadius),
                  )
                  : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                localizedPrayerName(context, prayerModelType),
                style: textStyleOfTimes,
              ),
              const Spacer(),
              Text(
                formatTimeOfDay(context, mapOfTimes.values.elementAt(i)),
                style: textStyleOfTimes,
              ),
              const Gap(10),
              SizedBox(
                height: isToday ? 40 : 30,
                width: isToday ? 50 : 0,
                child:
                    !isToday
                        ? null
                        : getPrayerReminderSwitch(
                          defaultWhenEnable,
                          isCurrentToRemind,
                          context,
                          prayerModelType,
                          currentReminder,
                          l10n,
                        ),
              ),
            ],
          ),
        );
      },
    );
  }

  Switch getPrayerReminderSwitch(
    ReminderTypeWithPrayModel defaultWhenEnable,
    bool isCurrentToRemind,
    BuildContext context,
    PrayerModelTimesType prayerModelType,
    ReminderTypeWithPrayModel? currentReminder,
    AppLocalizations l10n,
  ) {
    return Switch.adaptive(
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return Icon(
            defaultWhenEnable.reminderType == PrayerReminderType.notification
                ? FluentIcons.alert_on_24_regular
                : Icons.alarm_on_rounded,
          );
        }
        return Icon(
          defaultWhenEnable.reminderType == PrayerReminderType.notification
              ? FluentIcons.alert_off_24_regular
              : Icons.alarm_off_rounded,
        );
      }),
      value: isCurrentToRemind,
      onChanged: (value) async {
        if (value) {
          if (await requestPermissionForReminder()) {
            context.read<PrayerReminderCubit>().addPrayerToRemember(
              defaultWhenEnable,
            );
            Fluttertoast.showToast(
              msg: l10n.reminderAdded(prayerModelType.name.capitalize()),
            );
          } else {
            Fluttertoast.showToast(msg: l10n.allowNotificationPermission);
          }
        } else {
          context.read<PrayerReminderCubit>().removePrayerToRemember(
            currentReminder!,
          );
          await setReminderForPrayers();
          Fluttertoast.showToast(
            msg: l10n.reminderRemoved(prayerModelType.name.capitalize()),
          );
        }
      },
    );
  }

  Expanded getNextPrayerTimeWidget(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Expanded(
      flex: 4,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizedPrayerName(
                context,
                PrayersTimeFunction.nextPrayerName(
                  PrayersTimeFunction.getTodaysPrayerTime(DateTime.now())!,
                ),
              ).toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formatTimeOfDay(
                context,
                PrayersTimeFunction.nextPrayerTime(
                  PrayersTimeFunction.getTodaysPrayerTime(DateTime.now())!,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  l10n.left,
                  style: const TextStyle(
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
                    TextStyle textStyle = const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    );
                    if (!snapshot.hasData) {
                      return Text("00:00:00", style: textStyle);
                    }
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
                    String pad = localizedNumber(context, 0);
                    return Text(
                      "${localizedNumber(context, timeUntilNextPrayer.inHours).padLeft(2, pad)}:${localizedNumber(context, timeUntilNextPrayer.inMinutes % 60).padLeft(2, pad)}:${localizedNumber(context, timeUntilNextPrayer.inSeconds % 60).padLeft(2, pad)}",
                      style: textStyle,
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
