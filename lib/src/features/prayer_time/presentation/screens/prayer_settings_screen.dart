import "dart:io";

import "package:flutter/foundation.dart";
import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/core/services/platform_services.dart" as platform_services;
import "package:awesome_notifications/awesome_notifications.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/utils/format_time_of_day.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:permission_handler/permission_handler.dart";

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
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    final isMobile = platformOwn == platform_services.PlatformOwn.isAndroid ||
        platformOwn == platform_services.PlatformOwn.isIos;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          l10n.prayerSettings,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // 1. Calculation & Jurisprudence Section
                _buildSectionHeader(
                  l10n.calculationAndJurisprudence,
                  FluentIcons.compass_northwest_24_regular,
                  themeState,
                  isDark,
                ),
                const Gap(10),
                _buildCalculationMethodCard(context, themeState, isDark, l10n),
                const Gap(12),
                _buildMadhabCard(context, themeState, isDark, l10n),

                const Gap(24),

                // 2. Notification & Sound Settings
                if (isMobile) ...[
                  _buildSectionHeader(
                    l10n.notificationsAndAudio,
                    FluentIcons.alert_24_regular,
                    themeState,
                    isDark,
                  ),
                  const Gap(10),
                  _buildNotificationSettingsCard(context, themeState, isDark, l10n),
                  const Gap(24),
                ],

                // 3. Manual Time Adjustments
                if (isMobile) ...[
                  _buildSectionHeader(
                    l10n.adjustReminderTime,
                    FluentIcons.timer_24_regular,
                    themeState,
                    isDark,
                  ),
                  const Gap(4),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      l10n.adjustReminderTimingDescription,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const Gap(12),
                  _buildAdjustReminderList(
                    themeState: themeState,
                    l10n: l10n,
                    prayerTimes: widget.prayerTimes,
                    isDark: isDark,
                  ),
                  const Gap(40),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    dynamic themeState,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: themeState.primary),
        ),
        const Gap(10),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculationMethodCard(
    BuildContext context,
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<LocationQiblaPrayerDataCubit, LocationQiblaPrayerDataState>(
      builder: (context, locationState) {
        final currentEnum = locationState.calculationMethod?.method ??
            CalculationMethodEnum.muslimWorldLeague;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.selectCalculationMethod,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
              const Gap(8),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<CalculationMethodEnum>(
                  initialValue: currentEnum,
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    fillColor: isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.grey.shade50,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                  dropdownColor:
                      isDark ? const Color(0xFF252525) : Colors.white,
                  items: CalculationMethodEnum.values.map((methodEnum) {
                    final params =
                        CalculationMethodParameters.fromEnum(methodEnum);
                    return DropdownMenuItem(
                      value: methodEnum,
                      child: Text(
                        params.fullName ?? methodEnum.name,
                        style: const TextStyle(fontSize: 13.5),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<LocationQiblaPrayerDataCubit>()
                          .saveCalculationMethod(
                            CalculationMethodParameters.fromEnum(value),
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMadhabCard(
    BuildContext context,
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<LocationQiblaPrayerDataCubit, LocationQiblaPrayerDataState>(
      builder: (context, locationState) {
        final currentMadhab = locationState.madhab ?? Madhab.shafi;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.asrJurisprudence,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: _buildMadhabOption(
                      title: l10n.shafie,
                      subtitle: l10n.shafieDescription,
                      isSelected: currentMadhab == Madhab.shafi,
                      onTap: () => context
                          .read<LocationQiblaPrayerDataCubit>()
                          .saveMadhab(Madhab.shafi),
                      themeState: themeState,
                      isDark: isDark,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: _buildMadhabOption(
                      title: l10n.hanafi,
                      subtitle: l10n.hanafiDescription,
                      isSelected: currentMadhab == Madhab.hanafi,
                      onTap: () => context
                          .read<LocationQiblaPrayerDataCubit>()
                          .saveMadhab(Madhab.hanafi),
                      themeState: themeState,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMadhabOption({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required dynamic themeState,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? themeState.primary.withValues(alpha: isDark ? 0.2 : 0.08)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : Colors.grey.shade50),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? themeState.primary
                : (isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade200),
            width: isSelected ? 1.6 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? themeState.primary
                        : (isDark ? Colors.white : Colors.grey.shade900),
                  ),
                ),
                if (isSelected)
                  Icon(
                    FluentIcons.checkmark_circle_24_filled,
                    size: 17,
                    color: themeState.primary,
                  ),
              ],
            ),
            const Gap(4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.5,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettingsCard(
    BuildContext context,
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
      builder: (context, reminderState) {
        final isMasterEnabled =
            reminderState.isPrayerRemindNotificationEnabled ?? false;
        final enforceAlarm = reminderState.enforceAlarmSound ?? false;
        final volume = reminderState.soundVolume ?? 0.65;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Master Toggle
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.enablePrayerReminders,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.grey.shade900,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          l10n.enablePrayerRemindersDescription,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isMasterEnabled,
                    activeTrackColor: themeState.primary,
                    onChanged: (value) async {
                      if (value) {
                        final notifAllowed =
                            await AwesomeNotifications().isNotificationAllowed();
                        if (!notifAllowed) {
                          final granted = await AwesomeNotifications()
                              .requestPermissionToSendNotifications();
                          if (!granted) {
                            Fluttertoast.showToast(
                              msg: l10n.allowNotificationPermission,
                            );
                            return;
                          }
                        }
                        if (!kIsWeb && Platform.isAndroid) {
                          try {
                            final status =
                                await Permission.scheduleExactAlarm.status;
                            if (status.isDenied) {
                              await Permission.scheduleExactAlarm.request();
                            }
                          } catch (_) {}
                        }
                        context
                            .read<PrayerReminderCubit>()
                            .enablePrayerRemindNotification();
                      } else {
                        context
                            .read<PrayerReminderCubit>()
                            .disablePrayerRemindNotification();
                      }
                    },
                  ),
                ],
              ),

              const Divider(height: 24),

              // Enforce Sound Toggle
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.enforceAlarmSound,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.grey.shade900,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          l10n.enforceAlarmSoundDescription,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: enforceAlarm,
                    activeTrackColor: themeState.primary,
                    onChanged: (value) {
                      context
                          .read<PrayerReminderCubit>()
                          .setReminderEnforceSound(value);
                    },
                  ),
                ],
              ),

              // Volume Slider (if enforce sound active)
              if (enforceAlarm) ...[
                const Gap(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.volume,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.grey.shade900,
                      ),
                    ),
                    Text(
                      "${(volume * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: themeState.primary,
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: themeState.primary,
                    inactiveTrackColor: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : themeState.primary.withValues(alpha: 0.2),
                    thumbColor: themeState.primary,
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: volume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    onChanged: (val) {
                      context
                          .read<PrayerReminderCubit>()
                          .setReminderSoundVolume(val);
                    },
                  ),
                ),
              ],

              // Ringtone Settings
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.reminderRingtone,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.grey.shade900,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          l10n.chooseRingtoneDescription,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {
                      context
                          .read<PrayerReminderCubit>()
                          .toggleRingtonePreview();
                    },
                    icon: Icon(
                      reminderState.isPlayingPreview
                          ? FluentIcons.pause_24_filled
                          : FluentIcons.play_24_filled,
                      color: themeState.primary,
                      size: 20,
                    ),
                    tooltip: reminderState.isPlayingPreview
                        ? l10n.stopPreview
                        : l10n.previewSound,
                  ),
                ],
              ),
              const Gap(10),

              // Current Sound Display Card & Browse Button
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      FluentIcons.music_note_2_24_regular,
                      size: 20,
                      color: themeState.primary,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reminderState.selectedRingtoneTitle ??
                                l10n.defaultSound,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color:
                                  isDark ? Colors.white : Colors.grey.shade900,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            reminderState.selectedRingtoneType == "default_sound" ||
                                    reminderState.selectedRingtoneType == null
                                ? "WAV Audio (notification_sound.wav)"
                                : reminderState.selectedRingtoneType == "custom"
                                    ? "Device / System Sound"
                                    : "System Preset",
                            style: TextStyle(
                              fontSize: 10.5,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    FilledButton.tonalIcon(
                      onPressed: () {
                        context.read<PrayerReminderCubit>().chooseRingtone();
                      },
                      icon: const Icon(
                        FluentIcons.folder_open_24_regular,
                        size: 16,
                      ),
                      label: Text(
                        l10n.chooseRingtone,
                        style: const TextStyle(fontSize: 12),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(12),

              // Quick Presets
              Text(
                l10n.quickPresets,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: Text(
                      l10n.defaultSound,
                      style: const TextStyle(fontSize: 11),
                    ),
                    selected: reminderState.selectedRingtoneType ==
                            "default_sound" ||
                        reminderState.selectedRingtoneType == null,
                    onSelected: (selected) {
                      if (selected) {
                        context
                            .read<PrayerReminderCubit>()
                            .selectRingtonePreset("default_sound");
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text(
                      l10n.systemNotification,
                      style: const TextStyle(fontSize: 11),
                    ),
                    selected: reminderState.selectedRingtoneType ==
                        "system_notification",
                    onSelected: (selected) {
                      if (selected) {
                        context
                            .read<PrayerReminderCubit>()
                            .selectRingtonePreset("system_notification");
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text(
                      l10n.systemAlarm,
                      style: const TextStyle(fontSize: 11),
                    ),
                    selected:
                        reminderState.selectedRingtoneType == "system_alarm",
                    onSelected: (selected) {
                      if (selected) {
                        context
                            .read<PrayerReminderCubit>()
                            .selectRingtonePreset("system_alarm");
                      }
                    },
                  ),
                  ChoiceChip(
                    label: Text(
                      l10n.systemRingtone,
                      style: const TextStyle(fontSize: 11),
                    ),
                    selected:
                        reminderState.selectedRingtoneType == "system_ringtone",
                    onSelected: (selected) {
                      if (selected) {
                        context
                            .read<PrayerReminderCubit>()
                            .selectRingtonePreset("system_ringtone");
                      }
                    },
                  ),
                ],
              ),

              const Divider(height: 24),

              // Test Notification Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await context
                        .read<PrayerReminderCubit>()
                        .sendTestNotification();
                    Fluttertoast.showToast(msg: l10n.testNotificationSent);
                  },
                  icon: Icon(
                    FluentIcons.alert_badge_24_regular,
                    size: 18,
                    color: themeState.primary,
                  ),
                  label: Text(
                    l10n.testNotification,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: themeState.primary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(
                      color: themeState.primary.withValues(alpha: 0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  Widget _buildAdjustReminderList({
    required ThemeState themeState,
    required AppLocalizations l10n,
    required PrayerTimes prayerTimes,
    required bool isDark,
  }) {
    final prayers = [
      Prayer.fajr,
      Prayer.sunrise,
      Prayer.dhuhr,
      Prayer.asr,
      Prayer.maghrib,
      Prayer.isha,
    ];

    return BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
      builder: (context, prayerReminderState) {
        return Column(
          children: prayers.map((prayerType) {
            final int offsetMinutes =
                prayerReminderState.reminderTimeAdjustment?[prayerType] ?? 0;
            final DateTime? prayerTime =
                prayerTimes.timeForPrayer(prayerType)?.toLocal();
            final actualPrayerTime =
                TimeOfDay.fromDateTime(prayerTime ?? DateTime.now());

            final adjustedTime = TimeOfDay(
              hour: (actualPrayerTime.hour +
                      (actualPrayerTime.minute + offsetMinutes) ~/ 60) %
                  24,
              minute: (actualPrayerTime.minute + offsetMinutes) % 60,
            );

            final prayerName =
                PrayerTimeHelper.localizedPrayerName(context, prayerType) ??
                    prayerType.name;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: themeState.primary
                              .withValues(alpha: isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          PrayerTimeHelper.getPrayerIcon(prayerType),
                          color: themeState.primary,
                          size: 18,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prayerName,
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : Colors.grey.shade900,
                              ),
                            ),
                            Text(
                              l10n.actualTime(
                                formatTimeOfDay(context, actualPrayerTime),
                              ),
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Offset chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: offsetMinutes == 0
                              ? (isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.grey.shade100)
                              : themeState.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          offsetMinutes == 0
                              ? l10n.exactTime
                              : (offsetMinutes > 0
                                  ? "+${localizedNumber(context, offsetMinutes)} m"
                                  : "-${localizedNumber(context, offsetMinutes.abs())} m"),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: offsetMinutes == 0
                                ? (isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade700)
                                : themeState.primary,
                          ),
                        ),
                      ),
                      const Gap(8),
                      // Adjusted alert time pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: themeState.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          formatTimeOfDay(context, adjustedTime),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: themeState.primary,
                      inactiveTrackColor: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade200,
                      thumbColor: themeState.primary,
                      overlayColor:
                          themeState.primary.withValues(alpha: 0.15),
                      trackHeight: 3.5,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 6),
                    ),
                    child: Slider(
                      value: offsetMinutes.toDouble(),
                      min: -60.0,
                      max: 60.0,
                      divisions: 120,
                      label: _getAdjustmentText(offsetMinutes, l10n),
                      onChanged: (double value) {
                        context
                            .read<PrayerReminderCubit>()
                            .setUIReminderTimeAdjustment(
                              prayerType,
                              value.round(),
                            );
                      },
                      onChangeEnd: (value) {
                        context
                            .read<PrayerReminderCubit>()
                            .setReminderTimeAdjustment(
                              prayerType,
                              value.round(),
                            );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _getAdjustmentText(int minutes, AppLocalizations l10n) {
    if (minutes == 0) return l10n.atPrayerTime;
    if (minutes < 0) {
      return l10n.minBefore(minutes).replaceFirst(
            minutes.toString(),
            localizedNumber(context, minutes.abs()),
          );
    }
    return l10n.minAfter(minutes).replaceFirst(
          minutes.toString(),
          localizedNumber(context, minutes.abs()),
        );
  }
}
