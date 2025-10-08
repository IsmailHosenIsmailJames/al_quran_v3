import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/platform_services.dart" as platform_services;
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_model_of_day.dart";
import "package:al_quran_v3/src/utils/format_time_of_day.dart";
import "package:al_quran_v3/src/utils/localizedPrayerName.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/download_data_for_prayer_view.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_types.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../../main.dart";
import "../../theme/controller/theme_cubit.dart";
import "../../theme/values/values.dart";
import "../../widget/prayers/prayer_calculation_method_info_widget.dart";
import "../location_handler/cubit/location_data_qibla_data_cubit.dart";
import "../location_handler/model/location_data_qibla_data_state.dart";
import "functions/prayers_time_function.dart";

class PrayerSettings extends StatefulWidget {
  const PrayerSettings({super.key});

  @override
  State<PrayerSettings> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    TextStyle titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    ThemeState themeState = context.read<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.prayerSettings)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 80,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.calculationMethod, style: titleStyle),
                SizedBox(
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    ),
                    onPressed: () async {
                      var state =
                          context.read<LocationQiblaPrayerDataCubit>().state;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DownloadDataForPrayerView(
                                lat: state.latLon!.latitude,
                                long: state.latLon!.latitude,
                                showCalculationMethodPopupAtOnInit: true,
                                moveToDownload: true,
                              ),
                        ),
                      );
                    },
                    child: Text(l10n.change),
                  ),
                ),
              ],
            ),
            const Gap(5),
            BlocBuilder<
              LocationQiblaPrayerDataCubit,
              LocationQiblaPrayerDataState
            >(
              builder: (context, state) {
                return getPrayerCalculationMethodInfoWidget(
                  context,
                  state.calculationMethod!,
                );
              },
            ),
            const Gap(20),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              Text(l10n.reminderSettings, style: titleStyle),
            const Gap(5),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              getDropPrayerSettings(themeState),
            const Gap(20),
            Text(l10n.adjustReminderTime, style: titleStyle),
            const Gap(5),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              getAdjustReminderWidget(themeState, l10n),
            const Gap(15),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(l10n.enforceAlarmSound, style: titleStyle),
                  ),
                  const Spacer(),
                  BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
                    builder: (context, prayerReminderState) {
                      return Switch.adaptive(
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                          Set<WidgetState> states,
                        ) {
                          return Icon(
                            states.contains(WidgetState.selected)
                                ? Icons.done_rounded
                                : Icons.close_rounded,
                          );
                        }),
                        value: prayerReminderState.enforceAlarmSound,
                        onChanged: (value) {
                          context
                              .read<PrayerReminderCubit>()
                              .setReminderEnforceSound(value);
                        },
                      );
                    },
                  ),
                ],
              ),

            const Gap(5),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              Text(
                l10n.enforceAlarmSoundDescription,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.start,
              ),
            const Gap(10),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
                builder: (context, prayerReminderState) {
                  if (prayerReminderState.enforceAlarmSound) {
                    return Row(
                      children: [
                        Text(l10n.volume, style: titleStyle),
                        const Spacer(),
                        Text(
                          prayerReminderState.soundVolume.toStringAsFixed(2),
                          style: titleStyle,
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            const Gap(5),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
                builder: (context, prayerReminderState) {
                  if (prayerReminderState.enforceAlarmSound) {
                    return SliderTheme(
                      data: const SliderThemeData(padding: EdgeInsets.zero),
                      child: Slider(
                        value: prayerReminderState.soundVolume,
                        min: 0.0,
                        max: 1.0,
                        divisions: 50,
                        onChanged: (value) {
                          context
                              .read<PrayerReminderCubit>()
                              .setReminderSoundVolume(value);
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget getAdjustReminderWidget(ThemeState themeState, AppLocalizations l10n) {
    PrayerModelOfDay? prayerModelOfDay =
        PrayersTimeFunction.getTodaysPrayerTime(DateTime.now());
    Map<PrayerModelTimesType, TimeOfDay>? mapOfTimes =
        prayerModelOfDay == null
            ? null
            : PrayersTimeFunction.getPrayerTimings(prayerModelOfDay);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeState.primaryShade300),
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
        builder: (context, prayerReminderState) {
          return Column(
            children: List.generate(PrayerModelTimesType.values.length, (
              index,
            ) {
              PrayerModelTimesType currentPrayerType =
                  PrayerModelTimesType.values[index];

              int currentTimeInMinutes =
                  prayerReminderState
                      .reminderTimeAdjustment[currentPrayerType] ??
                  0;
              TimeOfDay actualPrayerTime =
                  mapOfTimes?[currentPrayerType] ?? TimeOfDay.now();
              return Container(
                decoration: BoxDecoration(
                  color:
                      index.isEven
                          ? themeState.primaryShade100
                          : themeState.primaryShade200,
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 3,
                ), // Added some vertical margin
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch, // Make slider take full width
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizedPrayerName(context, currentPrayerType),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Text(
                          "${_getAdjustmentText(currentTimeInMinutes, l10n)} - ${_getTimeText(actualPrayerTime, currentTimeInMinutes, l10n)}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Gap(5), // Reduced gap for a tighter look
                    SliderTheme(
                      data: const SliderThemeData(padding: EdgeInsets.zero),
                      child: Slider(
                        value: currentTimeInMinutes.toDouble(),
                        min: -120.0,
                        max: 120.0,
                        divisions: 240,
                        label: _getAdjustmentText(
                          currentTimeInMinutes.round(),
                          l10n,
                        ),
                        activeColor: themeState.primary,
                        inactiveColor: themeState.primaryShade300,
                        onChanged: (double value) {
                          context
                              .read<PrayerReminderCubit>()
                              .setUIReminderTimeAdjustment(
                                currentPrayerType,
                                value.round(),
                              );
                        },
                        onChangeEnd: (value) {
                          context
                              .read<PrayerReminderCubit>()
                              .setReminderTimeAdjustment(
                                currentPrayerType,
                                value.round(),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget getDropPrayerSettings(ThemeState themeState) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeState.primaryShade300),
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
        builder: (context, prayerReminderState) {
          return Column(
            children: List.generate(PrayerModelTimesType.values.length, (
              index,
            ) {
              PrayerModelTimesType currentPrayerType =
                  PrayerModelTimesType.values[index];

              PrayerReminderType currentPrayerReminderType =
                  prayerReminderState
                      .previousReminderModes[currentPrayerType] ??
                  PrayerReminderType.alarm;

              return Container(
                decoration: BoxDecoration(
                  color:
                      index.isEven
                          ? themeState.primaryShade100
                          : themeState.primaryShade200,
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                padding: const EdgeInsets.only(left: 10, right: 5),
                margin: const EdgeInsets.only(bottom: 2, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      localizedPrayerName(context, currentPrayerType),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DropdownButton(
                      value: currentPrayerReminderType,
                      alignment: Alignment.centerRight,
                      items: List.generate(
                        PrayerReminderType.values.length,
                        (index) => DropdownMenuItem(
                          value: PrayerReminderType.values[index],
                          child: Row(
                            children: <Widget>[
                              Icon(
                                PrayerReminderType.values[index] ==
                                        PrayerReminderType.notification
                                    ? FluentIcons.alert_on_24_regular
                                    : Icons.alarm_rounded,
                              ),
                              const Gap(10),
                              Text(
                                localizedReminderName(
                                  context,
                                  PrayerReminderType.values[index],
                                ),
                              ),
                              const Gap(7),
                            ],
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        var cubit = context.read<PrayerReminderCubit>();
                        var data = ReminderTypeWithPrayModel(
                          prayerTimesType: currentPrayerType,
                          reminderType: value!,
                        );
                        cubit.setReminderMode(data);
                      },
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  String _getAdjustmentText(int minutes, AppLocalizations l10n) {
    if (minutes == 0) return l10n.atPrayerTime;
    if (minutes < 0) {
      return l10n
          .minBefore(minutes)
          .replaceFirst(
            minutes.toString(),
            localizedNumber(context, minutes.abs()),
          );
    }
    return l10n
        .minAfter(minutes)
        .replaceFirst(
          minutes.toString(),
          localizedNumber(context, minutes.abs()),
        );
  }

  String _getTimeText(
    TimeOfDay currentPrayerTime,
    int minutes,
    AppLocalizations l10n,
  ) {
    currentPrayerTime = TimeOfDay(
      hour: currentPrayerTime.hour,
      minute: currentPrayerTime.minute + minutes,
    );
    return formatTimeOfDay(context, currentPrayerTime);
  }
}
