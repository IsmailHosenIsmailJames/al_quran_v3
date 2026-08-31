import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/sleep_timer_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

Future<void> showSleepTimerBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const SleepTimerBottomSheet(),
  );
}

class SleepTimerBottomSheet extends StatelessWidget {
  const SleepTimerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;
    final sleepTimerCubit = context.watch<SleepTimerCubit>();
    final timerState = sleepTimerCubit.state;

    final presetMinutes = [15, 30, 45, 60];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(16),

            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: themeState.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    FluentIcons.timer_20_filled,
                    color: themeState.primary,
                    size: 22,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sleep Timer",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timerState.isActive
                            ? (timerState.isEndOfSurah
                                ? "Active: Stop at end of Surah"
                                : "Active: ${_formatDuration(timerState.remainingDuration)} remaining")
                            : "Auto-pause playback when you fall asleep",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: timerState.isActive
                              ? themeState.primary
                              : theme.hintColor,
                          fontWeight: timerState.isActive
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (timerState.isActive)
                  TextButton.icon(
                    onPressed: () {
                      sleepTimerCubit.cancelTimer();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded, size: 16),
                    label: const Text("Turn Off"),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red.shade400,
                    ),
                  ),
              ],
            ),
            const Gap(20),

            // Preset Options
            ...presetMinutes.map((minutes) {
              final isSelected =
                  timerState.isActive &&
                  !timerState.isEndOfSurah &&
                  timerState.selectedMinutes == minutes;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Material(
                  color: isSelected
                      ? themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(roundedRadius),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(roundedRadius),
                    onTap: () {
                      sleepTimerCubit.setTimerMinutes(minutes);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            FluentIcons.snooze_20_regular,
                            size: 20,
                            color: isSelected
                                ? themeState.primary
                                : (isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600),
                          ),
                          const Gap(14),
                          Expanded(
                            child: Text(
                              "$minutes Minutes",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? themeState.primary
                                    : (isDark
                                        ? Colors.white
                                        : Colors.grey.shade900),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: themeState.primary,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            // End of Surah Option
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Material(
                color: timerState.isEndOfSurah
                    ? themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(roundedRadius),
                child: InkWell(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  onTap: () {
                    sleepTimerCubit.setEndOfSurah();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.book_pulse_20_regular,
                          size: 20,
                          color: timerState.isEndOfSurah
                              ? themeState.primary
                              : (isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600),
                        ),
                        const Gap(14),
                        Expanded(
                          child: Text(
                            "End of Current Surah",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: timerState.isEndOfSurah
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: timerState.isEndOfSurah
                                  ? themeState.primary
                                  : (isDark
                                      ? Colors.white
                                      : Colors.grey.shade900),
                            ),
                          ),
                        ),
                        if (timerState.isEndOfSurah)
                          Icon(
                            Icons.check_circle_rounded,
                            color: themeState.primary,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return "0:00";
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
