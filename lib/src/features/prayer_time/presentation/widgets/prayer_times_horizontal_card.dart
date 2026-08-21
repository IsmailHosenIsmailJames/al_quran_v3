import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_settings_screen.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/widgets/prayer_times_calendar_view.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";
import "package:permission_handler/permission_handler.dart";

class PrayerTimesHorizontalCard extends StatelessWidget {
  final PrayerTimes prayerTimes;

  const PrayerTimesHorizontalCard({super.key, required this.prayerTimes});

  static const List<Prayer> corePrayers = [
    Prayer.fajr,
    Prayer.dhuhr,
    Prayer.asr,
    Prayer.maghrib,
    Prayer.isha,
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final timeFormatter = DateFormat.jm(l10n.localeName);

    final currentPrayer = prayerTimes.currentPrayer(date: now);
    final nextPrayer = prayerTimes.nextPrayer(date: now);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title & Quick Control Buttons
          Row(
            children: [
              Icon(
                FluentIcons.clock_24_filled,
                size: 18,
                color: themeState.primary,
              ),
              const Gap(8),
              Text(
                l10n.prayerTimes,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                ),
              ),
              const Spacer(),

              // Master Notification Switch Pill
              BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
                builder: (context, reminderState) {
                  final isMasterEnabled =
                      reminderState.isPrayerRemindNotificationEnabled ?? false;

                  return InkWell(
                    onTap: () => _toggleMasterReminder(context, isMasterEnabled, l10n),
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isMasterEnabled
                            ? themeState.primary.withValues(alpha: isDark ? 0.25 : 0.12)
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.06)
                                : Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isMasterEnabled
                              ? themeState.primary.withValues(alpha: 0.5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isMasterEnabled
                                ? FluentIcons.alert_24_filled
                                : FluentIcons.alert_off_24_regular,
                            size: 15,
                            color: isMasterEnabled
                                ? themeState.primary
                                : (isDark
                                    ? Colors.grey.shade500
                                    : Colors.grey.shade600),
                          ),
                          const Gap(4),
                          Text(
                            isMasterEnabled
                                ? l10n.alerts.toUpperCase()
                                : l10n.muted.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: isMasterEnabled
                                  ? themeState.primary
                                  : (isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const Gap(6),

              // Settings Gear Button
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: Icon(
                  FluentIcons.settings_24_regular,
                  size: 18,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PrayerSettings(prayerTimes: prayerTimes),
                    ),
                  );
                },
              ),

              // Calendar View Button
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: Icon(
                  FluentIcons.calendar_month_24_regular,
                  size: 18,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PrayerTimesCalenderView(prayerTimes: prayerTimes),
                    ),
                  );
                },
              ),
            ],
          ),

          const Gap(10),

          // Horizontal 5-Prayer Columns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: corePrayers.map((prayer) {
              final time = prayerTimes.timeForPrayer(prayer)?.toLocal() ?? now;
              final isActive = currentPrayer == prayer;
              final isNext = nextPrayer == prayer;
              final isPassed = now.isAfter(time) && !isActive;

              return Expanded(
                child: _buildPrayerColumn(
                  context: context,
                  prayer: prayer,
                  time: time,
                  isActive: isActive,
                  isNext: isNext,
                  isPassed: isPassed,
                  themeState: themeState,
                  isDark: isDark,
                  l10n: l10n,
                  timeFormatter: timeFormatter,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerColumn({
    required BuildContext context,
    required Prayer prayer,
    required DateTime time,
    required bool isActive,
    required bool isNext,
    required bool isPassed,
    required dynamic themeState,
    required bool isDark,
    required AppLocalizations l10n,
    required DateFormat timeFormatter,
  }) {
    final localizedName =
        PrayerTimeHelper.localizedPrayerName(context, prayer)?.capitalize() ??
        prayer.name.capitalize();
    final formattedTime = timeFormatter.format(time);

    return InkWell(
      onTap: () => _showPrayerReminderSheet(
        context,
        prayer,
        time,
        localizedName,
        themeState,
        isDark,
        l10n,
      ),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        decoration: BoxDecoration(
          color: isActive
              ? themeState.primary.withValues(alpha: isDark ? 0.22 : 0.10)
              : (isNext
                  ? themeState.primary.withValues(alpha: isDark ? 0.08 : 0.04)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? themeState.primary.withValues(alpha: 0.45)
                : (isNext
                    ? themeState.primary.withValues(alpha: 0.25)
                    : Colors.transparent),
            width: isActive ? 1.2 : 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Prayer Name
            Text(
              localizedName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                color: isActive
                    ? themeState.primary
                    : (isPassed
                        ? (isDark ? Colors.grey.shade500 : Colors.grey.shade400)
                        : (isDark ? Colors.white : Colors.grey.shade800)),
              ),
            ),
            const Gap(4),

            // Prayer Time
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                formattedTime,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                  color: isActive
                      ? themeState.primary
                      : (isPassed
                          ? (isDark ? Colors.grey.shade500 : Colors.grey.shade400)
                          : (isDark ? Colors.grey.shade200 : Colors.grey.shade900)),
                ),
              ),
            ),
            const Gap(6),

            // Active / Next / Indicator Dot
            Container(
              height: 5,
              width: isActive ? 14 : 5,
              decoration: BoxDecoration(
                color: isActive
                    ? themeState.primary
                    : (isNext
                        ? themeState.primary.withValues(alpha: 0.5)
                        : (isPassed
                            ? (isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300)
                            : (isDark
                                ? Colors.grey.shade600
                                : Colors.grey.shade400))),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleMasterReminder(
    BuildContext context,
    bool isMasterEnabled,
    AppLocalizations l10n,
  ) async {
    if (!isMasterEnabled) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        final requested = await Permission.notification.request();
        final exactAlarm = await Permission.scheduleExactAlarm.request();
        if (!requested.isGranted || !exactAlarm.isGranted) {
          Fluttertoast.showToast(msg: l10n.allowNotificationPermission);
          return;
        }
      }
      await context.read<PrayerReminderCubit>().enablePrayerRemindNotification();
      Fluttertoast.showToast(msg: l10n.enablePrayerReminders);
    } else {
      await context.read<PrayerReminderCubit>().disablePrayerRemindNotification();
      Fluttertoast.showToast(msg: l10n.notificationsAndAudio);
    }
  }

  void _showPrayerReminderSheet(
    BuildContext context,
    Prayer prayer,
    DateTime time,
    String localizedName,
    dynamic themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    final arabicName = PrayerTimeHelper.arabicPrayerName(prayer);
    final formattedTime = DateFormat.jm(l10n.localeName).format(time);

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetContext) {
        return BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
          builder: (context, reminderState) {
            final isMasterEnabled =
                reminderState.isPrayerRemindNotificationEnabled ?? false;
            final isPrayerEnabled =
                isMasterEnabled && (reminderState.enabledPrayers?[prayer] ?? true);
            final currentAdjustment =
                reminderState.reminderTimeAdjustment?[prayer] ?? 0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const Gap(14),

                  // Header with Prayer Name & Arabic
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: themeState.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              PrayerTimeHelper.getPrayerIcon(prayer),
                              color: themeState.primary,
                              size: 20,
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizedName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.grey.shade900,
                                ),
                              ),
                              Text(
                                formattedTime,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: themeState.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (arabicName.isNotEmpty)
                        Text(
                          arabicName,
                          style: TextStyle(
                            fontFamily: "Amiri",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: themeState.primary.withValues(alpha: 0.8),
                          ),
                        ),
                    ],
                  ),

                  const Gap(16),
                  Divider(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade200,
                  ),
                  const Gap(8),

                  // Reminder Toggle Tile
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                          Text(
                            isPrayerEnabled ? l10n.active : l10n.off,
                            style: TextStyle(
                              fontSize: 12,
                              color: isPrayerEnabled
                                  ? themeState.primary
                                  : (isDark
                                      ? Colors.grey.shade500
                                      : Colors.grey.shade600),
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isPrayerEnabled,
                        activeTrackColor: themeState.primary,
                        onChanged: (value) async {
                          if (!isMasterEnabled && value) {
                            await context
                                .read<PrayerReminderCubit>()
                                .enablePrayerRemindNotification();
                          }
                          await context
                              .read<PrayerReminderCubit>()
                              .togglePrayerReminder(prayer);
                        },
                      ),
                    ],
                  ),

                  const Gap(12),

                  // Timing Offset Adjustments
                  Text(
                    l10n.adjustReminderTimingDescription,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                  const Gap(10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [-15, -10, -5, 0, 5, 10, 15].map((offset) {
                        final isSelected = currentAdjustment == offset;
                        final label = offset == 0
                            ? l10n.exactTime
                            : "${offset > 0 ? "+${localizedNumber(context, offset)}" : localizedNumber(context, offset)} ${l10n.minutes.toLowerCase()}";

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<PrayerReminderCubit>()
                                  .setReminderTimeAdjustment(prayer, offset);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? themeState.primary.withValues(
                                        alpha: isDark ? 0.25 : 0.12,
                                      )
                                    : (isDark
                                        ? Colors.white.withValues(alpha: 0.04)
                                        : Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected
                                      ? themeState.primary
                                      : Colors.transparent,
                                  width: 1.2,
                                ),
                              ),
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? themeState.primary
                                      : (isDark
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade800),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const Gap(20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
