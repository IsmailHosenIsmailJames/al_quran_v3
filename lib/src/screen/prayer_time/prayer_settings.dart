import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/platform_services.dart" as platform_services;
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_cubit.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/prayer_time_functions/prayer_time_helper.dart";
import "package:al_quran_v3/src/utils/format_time_of_day.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

import "../../../main.dart";
import "../../theme/controller/theme_cubit.dart";

class PrayerSettings extends StatefulWidget {
  final PrayerTimes prayerTimes;
  const PrayerSettings({super.key, required this.prayerTimes});

  @override
  State<PrayerSettings> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    TextStyle titleStyle = const TextStyle(
      fontSize: 20,
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
            Text(l10n.adjustReminderTime, style: titleStyle),
            const Gap(5),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              getAdjustReminderWidget(
                themeState: themeState,
                l10n: l10n,
                prayerTimes: widget.prayerTimes,
              ),
            const Gap(15),
            if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                platformOwn == platform_services.PlatformOwn.isIos)
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      l10n.enforceAlarmSound,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                        value: prayerReminderState.enforceAlarmSound ?? false,
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
                  if (prayerReminderState.enforceAlarmSound ?? false) {
                    return Row(
                      children: [
                        Text(l10n.volume, style: titleStyle),
                        const Spacer(),
                        Text(
                          (prayerReminderState.soundVolume ?? 0)
                              .toStringAsFixed(2),
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
                  if (prayerReminderState.enforceAlarmSound ?? false) {
                    return SliderTheme(
                      data: const SliderThemeData(padding: EdgeInsets.zero),
                      child: Slider(
                        value: prayerReminderState.soundVolume ?? 0.65,
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

  Widget getAdjustReminderWidget({
    required ThemeState themeState,
    required AppLocalizations l10n,
    required PrayerTimes prayerTimes,
  }) {
    final bool isDark = Theme.brightnessOf(context) == Brightness.dark;
    final Color cardColor = isDark
        ? themeState.primary.withOpacity(0.1)
        : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
      builder: (context, prayerReminderState) {
        return Column(
          children: List.generate(Prayer.values.length, (index) {
            Prayer currentPrayerType = Prayer.values[index];

            int currentTimeInMinutes =
                prayerReminderState
                    .reminderTimeAdjustment?[currentPrayerType] ??
                0;
            DateTime? prayerTime = prayerTimes
                .timeForPrayer(currentPrayerType)
                ?.toLocal();
            TimeOfDay actualPrayerTime = TimeOfDay.fromDateTime(
              prayerTime ?? DateTime.now(), // better than crash
            );

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: themeState.primary.withOpacity(0.2)),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: themeState.primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.access_time_rounded,
                                color: themeState.primary,
                                size: 20,
                              ),
                            ),
                            const Gap(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  PrayerTimeHelper.localizedPrayerName(
                                        context,
                                        currentPrayerType,
                                      ) ??
                                      "-",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                Text(
                                  formatTimeOfDay(context, actualPrayerTime),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: textColor.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: themeState.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            currentTimeInMinutes == 0
                                ? l10n.atPrayerTime
                                : (currentTimeInMinutes > 0
                                      ? "+$currentTimeInMinutes min"
                                      : "$currentTimeInMinutes min"),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: themeState.primary,
                            ),
                          ),
                        ),
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: themeState.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            _getTimeText(
                              actualPrayerTime,
                              currentTimeInMinutes,
                              l10n,
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: themeState.primary,
                        inactiveTrackColor: themeState.primary.withOpacity(0.2),
                        thumbColor: isDark ? themeState.primary : Colors.white,
                        overlayColor: themeState.primary.withOpacity(0.1),
                        trackHeight: 6.0,
                        thumbShape: const RoundSliderThumbShape(
                          elevation: 4,
                          pressedElevation: 8,
                          enabledThumbRadius: 10,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 20.0,
                        ),
                      ),
                      child: Slider(
                        padding: EdgeInsets.zero,
                        value: currentTimeInMinutes.toDouble(),
                        min: -60.0,
                        max: 60.0,
                        divisions: 120,
                        label: _getAdjustmentText(
                          currentTimeInMinutes.round(),
                          l10n,
                        ),
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
              ),
            );
          }),
        );
      },
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
