import "dart:math";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_time_functions/prayer_time_helper.dart";
import "package:al_quran_v3/src/screen/settings/settings_page.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:geocoding/geocoding.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hijri/hijri_calendar.dart";
import "package:shimmer/shimmer.dart";

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
    final themeState = context.read<ThemeCubit>().state;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context);
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 10)),
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
            12,
          ).copyWith(top: mediaQueryData.padding.top + 12, bottom: 100),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(FluentIcons.location_24_regular),
                const Gap(8),
                SizedBox(
                  width: mediaQueryData.size.width * 0.6,
                  child: FutureBuilder(
                    future: placemarkFromCoordinates(widget.lat, widget.lon),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
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
                        final placemark = snapshot.data?.first;
                        final address = [
                              placemark?.name,
                              placemark?.subThoroughfare,
                              placemark?.thoroughfare,
                              placemark?.subLocality,
                              placemark?.locality,
                              placemark?.subAdministrativeArea,
                              placemark?.administrativeArea,
                              placemark?.postalCode,
                              placemark?.country,
                              placemark?.isoCountryCode,
                            ]
                            .where((e) => e != null && e.isNotEmpty)
                            .toSet()
                            .join(", ");

                        return Text(
                          address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                const Gap(8),
                SizedBox(
                  width: 60,
                  height: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(Icons.refresh, color: themeState.primary),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: [
                const Icon(FluentIcons.calendar_24_regular),
                const Gap(8),
                Text(HijriCalendar.now().toFormat("dd MMMM yyyy")),
              ],
            ),
            const Gap(16),
            Container(
              height: 150,
              width: mediaQueryData.size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeState.primaryShade100,
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
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
                  const Gap(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prayerTimeHelper.currentPrayerName(
                          context,
                          DateTime.now(),
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                    alignment: Alignment.centerLeft,
                    child: StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Text(
                          prayerTimeHelper.leftTimeString(
                            context,
                            DateTime.now(),
                          ),
                          style: GoogleFonts.dmMono(fontSize: 36),
                        );
                      },
                    ),
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
                      const Text(
                        "Forbidden Salat Times",
                        style: TextStyle(
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
                          onPressed: () {},
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
                    "assets/img/makkah.jpg",
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
                    "assets/img/makkah.jpg",
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
                    "assets/img/makkah.jpg",
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
                      const Text(
                        "Prayer Times",
                        style: TextStyle(
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          TimeOfDay.fromDateTime(
                            start.toLocal(),
                          ).format(context),
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
                        ),
                        const Gap(8),
                      ],
                    ),
                  ],
                ),
              ),
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
        const Gap(8),
        getPrayerReminderSwitch(
          context,
          Random().nextBool(),
          Random().nextBool(),
        ),
      ],
    );
  }

  Switch getPrayerReminderSwitch(
    BuildContext context,
    bool isAlarm,
    bool isCurrentToRemind,
  ) {
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
