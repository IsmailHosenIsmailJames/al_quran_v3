import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

Future<void> showPlaybackSpeedBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const PlaybackSpeedBottomSheet(),
  );
}

class PlaybackSpeedBottomSheet extends StatefulWidget {
  const PlaybackSpeedBottomSheet({super.key});

  @override
  State<PlaybackSpeedBottomSheet> createState() =>
      _PlaybackSpeedBottomSheetState();
}

class _PlaybackSpeedBottomSheetState extends State<PlaybackSpeedBottomSheet> {
  final List<double> speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;
    final currentSpeed = AudioPlayerManager.audioPlayer.speed;

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
                    FluentIcons.play_circle_20_filled,
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
                        "Playback Speed",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Adjust recitation playback rate (${currentSpeed}x)",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),

            // Speed options
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: speeds.map((speed) {
                final isSelected = (currentSpeed - speed).abs() < 0.05;
                return ChoiceChip(
                  label: Text(
                    speed == 1.0 ? "Normal (1.0x)" : "${speed}x",
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white : Colors.grey.shade800),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: themeState.primary,
                  onSelected: (selected) async {
                    if (selected) {
                      await AudioPlayerManager.audioPlayer.setSpeed(speed);
                      if (mounted) {
                        setState(() {});
                      }
                      Navigator.pop(context);
                    }
                  },
                );
              }).toList(),
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
