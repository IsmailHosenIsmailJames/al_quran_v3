import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_sleep_timer_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

String formatSleepCountdown(int totalSeconds) {
  if (totalSeconds <= 0) return "0:00";
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;
  if (hours > 0) {
    return "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

Future<void> showSleepTimerSheet(BuildContext context) async {
  final width = MediaQuery.of(context).size.width;
  if (width >= 600) {
    await showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: const SleepTimerSheet(),
        ),
      ),
    );
  } else {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const SleepTimerSheet(),
    );
  }
}

class SleepTimerSheet extends StatelessWidget {
  const SleepTimerSheet({super.key});

  static const List<int> _minutePresets = [5, 10, 15, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeState = context.read<ThemeCubit>().state;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
      child: SafeArea(
        top: false,
        child: BlocBuilder<AudioSleepTimerCubit, AudioSleepTimerState>(
          builder: (context, sleepState) {
            final cubit = context.read<AudioSleepTimerCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Gap(12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: themeState.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        FluentIcons.weather_moon_24_filled,
                        color: themeState.primary,
                        size: 20,
                      ),
                    ),
                    const Gap(10),
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
                            sleepState.mode == SleepTimerMode.timed
                                ? "Pausing in ${formatSleepCountdown(sleepState.remainingSeconds)}"
                                : sleepState.mode == SleepTimerMode.endOfAyah
                                    ? "Stops after the current Ayah"
                                    : sleepState.mode == SleepTimerMode.endOfSurah
                                        ? "Stops after the current Surah"
                                        : "Automatically pause playback",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: sleepState.isActive
                                  ? themeState.primary
                                  : theme.hintColor,
                              fontWeight: sleepState.isActive
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const Gap(16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _minutePresets.map((mins) {
                    return ActionChip(
                      label: Text("$mins min"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(roundedRadius),
                      ),
                      onPressed: () {
                        cubit.startTimed(Duration(minutes: mins));
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
                const Gap(12),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(roundedRadius),
                  ),
                  leading: Icon(
                    FluentIcons.text_align_right_24_regular,
                    color: sleepState.mode == SleepTimerMode.endOfAyah
                        ? themeState.primary
                        : null,
                  ),
                  title: const Text("Stop after current Ayah"),
                  trailing: sleepState.mode == SleepTimerMode.endOfAyah
                      ? Icon(Icons.check_rounded, color: themeState.primary)
                      : null,
                  onTap: () {
                    cubit.setStopAfterCurrentAyah();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(roundedRadius),
                  ),
                  leading: Icon(
                    FluentIcons.book_24_regular,
                    color: sleepState.mode == SleepTimerMode.endOfSurah
                        ? themeState.primary
                        : null,
                  ),
                  title: const Text("Stop after current Surah"),
                  trailing: sleepState.mode == SleepTimerMode.endOfSurah
                      ? Icon(Icons.check_rounded, color: themeState.primary)
                      : null,
                  onTap: () {
                    cubit.setStopAfterCurrentSurah();
                    Navigator.pop(context);
                  },
                ),
                if (sleepState.isActive) ...[
                  const Gap(10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(roundedRadius),
                        ),
                      ),
                      onPressed: () {
                        cubit.cancel();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.timer_off_outlined, size: 18),
                      label: const Text("Turn Off Timer"),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
