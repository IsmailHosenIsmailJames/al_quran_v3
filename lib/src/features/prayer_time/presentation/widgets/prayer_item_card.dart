import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";
import "package:permission_handler/permission_handler.dart";

class PrayerItemCard extends StatelessWidget {
  final Prayer prayer;
  final DateTime time;
  final DateTime? nextPrayerTime;
  final bool isActive;
  final bool isNext;
  final bool isPassed;

  const PrayerItemCard({
    super.key,
    required this.prayer,
    required this.time,
    this.nextPrayerTime,
    this.isActive = false,
    this.isNext = false,
    this.isPassed = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final localizedName =
        PrayerTimeHelper.localizedPrayerName(context, prayer)?.capitalize() ??
        prayer.name.capitalize();
    final arabicName = PrayerTimeHelper.arabicPrayerName(prayer);
    final icon = PrayerTimeHelper.getPrayerIcon(prayer);
    final formattedTime = DateFormat.jm(l10n.localeName).format(time.toLocal());

    // Color decisions
    Color cardBg;
    Color borderColor;
    if (isActive) {
      cardBg = isDark
          ? themeState.primary.withValues(alpha: 0.22)
          : themeState.primary.withValues(alpha: 0.1);
      borderColor = themeState.primary.withValues(alpha: 0.6);
    } else if (isNext) {
      cardBg = isDark
          ? themeState.primaryShade100.withValues(alpha: 0.12)
          : themeState.primaryShade100;
      borderColor = themeState.primary.withValues(alpha: 0.35);
    } else {
      cardBg = isDark
          ? Colors.white.withValues(alpha: 0.04)
          : themeState.primaryShade100.withValues(alpha: 0.55);
      borderColor = isDark
          ? Colors.white.withValues(alpha: 0.08)
          : themeState.primaryShade200.withValues(alpha: 0.4);
    }

    final primaryTextColor = isPassed
        ? (isDark ? Colors.grey.shade500 : Colors.grey.shade500)
        : (isDark ? Colors.white : Colors.grey.shade900);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: isActive ? 1.5 : 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // Prayer Icon Box
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isActive
                    ? themeState.primary
                    : isNext
                        ? themeState.primary.withValues(alpha: 0.2)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : themeState.primaryShade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isActive
                    ? Colors.white
                    : (isPassed
                        ? (isDark ? Colors.grey.shade600 : Colors.grey.shade500)
                        : themeState.primary),
                size: 22,
              ),
            ),
            const Gap(14),

            // Prayer Name & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        localizedName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isActive ? FontWeight.w700 : FontWeight.w600,
                          color: primaryTextColor,
                        ),
                      ),
                      const Gap(8),
                      if (isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: themeState.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            l10n.active.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        )
                      else if (isNext)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: themeState.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            l10n.next.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: themeState.primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(2),
                  Text(
                    arabicName,
                    style: TextStyle(
                      fontFamily: "Amiri",
                      fontSize: 13,
                      color: isPassed
                          ? (isDark ? Colors.grey.shade600 : Colors.grey.shade400)
                          : (isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),

            // Prayer Time & Reminder Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: isActive ? themeState.primary : primaryTextColor,
                  ),
                ),
              ],
            ),

            const Gap(10),

            // Reminder status toggle
            BlocBuilder<PrayerReminderCubit, PrayerReminderState>(
              builder: (context, reminderState) {
                final isMasterEnabled =
                    reminderState.isPrayerRemindNotificationEnabled ?? false;
                final isPrayerEnabled =
                    isMasterEnabled && (reminderState.enabledPrayers?[prayer] ?? true);
                final offset =
                    reminderState.reminderTimeAdjustment?[prayer] ?? 0;

                return InkWell(
                  onTap: () async {
                    final status = await Permission.notification.status;
                    if (!status.isGranted) {
                      final requested =
                          await Permission.notification.request();
                      final exactAlarm =
                          await Permission.scheduleExactAlarm.request();
                      if (!requested.isGranted || !exactAlarm.isGranted) {
                        Fluttertoast.showToast(
                          msg: l10n.allowNotificationPermission,
                        );
                        return;
                      }
                    }

                    if (!isMasterEnabled) {
                      await context
                          .read<PrayerReminderCubit>()
                          .enablePrayerRemindNotification();
                    }

                    await context
                        .read<PrayerReminderCubit>()
                        .togglePrayerReminder(prayer);

                    final willBeEnabled = !isPrayerEnabled;
                    Fluttertoast.showToast(
                      msg: willBeEnabled
                          ? l10n.reminderAdded(localizedName)
                          : l10n.reminderRemoved(localizedName),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      isPrayerEnabled
                          ? (offset != 0
                              ? FluentIcons.alert_badge_24_filled
                              : FluentIcons.alert_24_filled)
                          : FluentIcons.alert_off_24_regular,
                      size: 20,
                      color: isPrayerEnabled
                          ? themeState.primary
                          : (isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
