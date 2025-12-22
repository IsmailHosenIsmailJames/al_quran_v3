import "dart:math";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_time_canvas.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_time_functions/prayer_time_helper.dart";
import "package:al_quran_v3/src/screen/settings/settings_page.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/hijri_date.dart";
import "package:al_quran_v3/src/utils/location_geocoding.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:shimmer/shimmer.dart";
import "package:al_quran_v3/src/screen/location_handler/model/lat_lon.dart";
import "package:url_launcher/url_launcher.dart";

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeState = context.read<ThemeCubit>().state;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context);
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 30)),
      builder: (context, snapshot) {
        final DateTime now = DateTime.now();
        final PrayerTimeHelper prayerTimeHelper = PrayerTimeHelper(
          prayerTimes: PrayerTimes(
            date: DateTime(now.year, now.month, now.day),
            coordinates: Coordinates(widget.lat, widget.lon),
            calculationParameters:
                CalculationMethodParameters.muslimWorldLeague(),
          ),
        );
        return ListView(
          padding: const EdgeInsets.all(
            8,
          ).copyWith(top: mediaQueryData.padding.top + 8, bottom: 100),
          children: [
            Container(
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 70,
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(FluentIcons.location_24_regular),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.location.replaceAll(":", ""),
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade800,
                          ),
                        ),
                        FutureBuilder(
                          future: locationName(
                            context,
                            LatLon(latitude: widget.lat, longitude: widget.lon),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.grey.shade900,
                                child: Container(
                                  height: 30,
                                  width: mediaQueryData.size.width * 0.6,
                                  decoration: BoxDecoration(
                                    color: themeState.primaryShade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              return Text(snapshot.data ?? "");
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(Icons.refresh, color: themeState.primary),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    8,
                  ).copyWith(left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: themeState.primaryShade100,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(FluentIcons.calendar_24_regular),
                      const Gap(4),
                      Text(hijriDate(context)),
                    ],
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      padding: EdgeInsets.zero,
                      initialValue: "hanafi",
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      isDense: true,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: "hanafi",
                          child: Text(l10n.hanafi),
                        ),
                        DropdownMenuItem(
                          value: "shafie",
                          child: Text(l10n.shafieMalikiHanbali),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),

            const Gap(8),
            Container(
              height: 150,
              width: mediaQueryData.size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeState.primaryShade100,
              ),
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: PrayerTimeCanvas(
                            prayerTimes: [
                              TimeOfDay.fromDateTime(
                                prayerTimeHelper.prayerTimes.fajr.toLocal(),
                              ),
                              TimeOfDay.fromDateTime(
                                prayerTimeHelper.prayerTimes.dhuhr.toLocal(),
                              ),
                              TimeOfDay.fromDateTime(
                                prayerTimeHelper.prayerTimes.asr.toLocal(),
                              ),
                              TimeOfDay.fromDateTime(
                                prayerTimeHelper.prayerTimes.maghrib.toLocal(),
                              ),
                              TimeOfDay.fromDateTime(
                                prayerTimeHelper.prayerTimes.isha.toLocal(),
                              ),
                            ],
                            sunriseTime: TimeOfDay.fromDateTime(
                              prayerTimeHelper.prayerTimes.sunrise.toLocal(),
                            ),
                            sunsetTime: TimeOfDay.fromDateTime(
                              prayerTimeHelper.prayerTimes.maghrib.toLocal(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            prayerTimeHelper.currentPrayerTimeString(
                              context,
                              DateTime.now(),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value:
                                  (100 -
                                      prayerTimeHelper.timeLeftInPercentage(
                                        DateTime.now(),
                                      )) /
                                  100,

                              color: themeState.primary,
                              backgroundColor: themeState.primaryShade300,
                              borderRadius: BorderRadius.circular(8),
                              minHeight: 8,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            prayerTimeHelper.nextPrayerTimeString(
                              context,
                              DateTime.now(),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              prayerTimeHelper.currentPrayerName(
                                context,
                                DateTime.now(),
                              ),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            prayerTimeHelper.nextPrayerName(
                              context,
                              DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      Align(
                        alignment: Alignment.bottomLeft,
                        child: StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  prayerTimeHelper.leftTimeString(
                                    context,
                                    DateTime.now(),
                                  ),
                                  style: GoogleFonts.dmMono(fontSize: 36),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.forbiddenSalatTimes,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),

                      SizedBox(
                        height: 35,
                        width: 60,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            launchUrl(
                              Uri.parse(
                                "https://islamqa.info/en/answers/48998/forbidden-prayer-times",
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          icon: Icon(
                            FluentIcons.info_24_regular,
                            color: themeState.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  forbiddenWidget(
                    themeState,
                    prayerTimeHelper,
                    context,
                    "assets/img/sunrise_forbidden_time.png",
                    prayerTimeHelper.prayerTimes.sunrise,
                    prayerTimeHelper.prayerTimes.sunrise.add(
                      const Duration(minutes: 15),
                    ),
                    l10n.sunrise,
                  ),
                  const Gap(8),
                  forbiddenWidget(
                    themeState,
                    prayerTimeHelper,
                    context,
                    "assets/img/noon_forbidden_time.png",
                    prayerTimeHelper.prayerTimes.dhuhr.subtract(
                      const Duration(minutes: 8),
                    ),
                    prayerTimeHelper.prayerTimes.dhuhr,

                    l10n.noon,
                  ),
                  const Gap(8),
                  forbiddenWidget(
                    themeState,
                    prayerTimeHelper,
                    context,
                    "assets/img/sunset_forbidden_time.png",
                    prayerTimeHelper.prayerTimes.maghrib.subtract(
                      const Duration(minutes: 15),
                    ),
                    prayerTimeHelper.prayerTimes.maghrib,

                    l10n.sunset,
                  ),
                ],
              ),
            ),
            const Gap(8),

            Container(
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.prayerTimes,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 35,
                        width: 60,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            FluentIcons.settings_24_filled,
                            color: themeState.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        width: 60,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward,
                            color: themeState.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  getPrayerRow(
                    context,
                    Prayer.fajr,
                    prayerTimeHelper.prayerTimes.fajr,
                    prayerTimeHelper,
                  ),
                  getPrayerRow(
                    context,
                    Prayer.sunrise,
                    prayerTimeHelper.prayerTimes.sunrise,
                    prayerTimeHelper,
                  ),
                  getPrayerRow(
                    context,
                    Prayer.dhuhr,
                    prayerTimeHelper.prayerTimes.dhuhr,
                    prayerTimeHelper,
                  ),
                  getPrayerRow(
                    context,
                    Prayer.asr,
                    prayerTimeHelper.prayerTimes.asr,
                    prayerTimeHelper,
                  ),
                  getPrayerRow(
                    context,
                    Prayer.maghrib,
                    prayerTimeHelper.prayerTimes.maghrib,
                    prayerTimeHelper,
                  ),
                  getPrayerRow(
                    context,
                    Prayer.isha,
                    prayerTimeHelper.prayerTimes.isha,
                    prayerTimeHelper,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  ClipRRect forbiddenWidget(
    ThemeState themeState,
    PrayerTimeHelper prayerTimeHelper,
    BuildContext context,
    String img,
    DateTime start,
    DateTime end,
    String title,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 60,
        decoration: BoxDecoration(color: themeState.primaryShade100),
        child: Row(
          children: [
            Image.asset(img, height: 60, width: 60, fit: BoxFit.cover),
            const Gap(8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14)),
                    Row(
                      children: [
                        Text(
                          TimeOfDay.fromDateTime(
                            start.toLocal(),
                          ).format(context),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: themeState.primaryShade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const Gap(8),
                        Text(
                          TimeOfDay.fromDateTime(end.toLocal()).format(context),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(width: 16),
            getReminderSwitch(
              context,
              isAlarm: false,
              isCurrentToRemind: Random().nextBool(),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget getPrayerRow(
    BuildContext context,
    Prayer prayer,
    DateTime time,
    PrayerTimeHelper prayerTimeHelper,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(8),
        CircleAvatar(
          radius: 6,
          backgroundColor:
              prayerTimeHelper.currentPrayer(DateTime.now()) == prayer
                  ? context.read<ThemeCubit>().state.primary
                  : Colors.grey.withValues(alpha: 0.2),
        ),
        const Gap(8),
        Text(
          prayerTimeHelper.localizedPrayerName(context, prayer).capitalize(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          TimeOfDay.fromDateTime(time.toLocal()).format(context),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Gap(12),
        getReminderSwitch(
          context,
          isAlarm: Random().nextBool(),
          isCurrentToRemind: Random().nextBool(),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Switch getReminderSwitch(
    BuildContext context, {
    required bool isAlarm,
    required bool isCurrentToRemind,
    required Function(bool) onChanged,
  }) {
    return Switch(
      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return Icon(
            isAlarm ? Icons.alarm_on_rounded : FluentIcons.alert_on_24_regular,
          );
        }
        return Icon(
          isAlarm ? Icons.alarm_off_rounded : FluentIcons.alert_off_24_regular,
        );
      }),
      value: isCurrentToRemind,
      onChanged: (value) async {},
    );
  }
}
