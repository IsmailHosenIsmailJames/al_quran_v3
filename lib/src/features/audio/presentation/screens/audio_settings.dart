import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/helpers/audio_functions.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

class AudioSettings extends StatefulWidget {
  final bool needAppBar;
  const AudioSettings({super.key, this.needAppBar = false});

  @override
  State<AudioSettings> createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final content = _buildMainUI(context, l10n);

    return widget.needAppBar
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                l10n.audioSettings,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: content,
            ),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: content,
          );
  }

  Widget _buildMainUI(BuildContext context, AppLocalizations l10n) {
    final themeState = context.read<ThemeCubit>().state;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Playback Speed Section
        _buildSectionCard(
          context,
          isDark: isDark,
          title: l10n.playbackSpeed,
          icon: FluentIcons.play_circle_20_regular,
          child: const PlayBackSpeedWidget(),
        ),

        const Gap(16),

        // 2. Streaming & Network Section
        _buildSectionCard(
          context,
          isDark: isDark,
          title: l10n.streamingAndNetwork,
          icon: FluentIcons.cellular_data_1_20_regular,
          child: BlocBuilder<QuranViewCubit, QuranViewState>(
            builder: (context, quranViewState) {
              return SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  l10n.useAudioStream,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    l10n.useAudioStreamDesc,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ),
                value: quranViewState.useAudioStream,
                activeTrackColor: themeState.primary,
                onChanged: (value) {
                  context.read<QuranViewCubit>().setViewOptions(
                        useAudioStream: value,
                      );
                  if (value) {
                    Fluttertoast.showToast(msg: l10n.useAudioStreamDesc);
                  } else {
                    Fluttertoast.showToast(msg: l10n.notUseAudioStreamDesc);
                  }
                  AudioPlayerManager.stopListeningAudioPlayerState();
                },
              );
            },
          ),
        ),

        const Gap(16),

        // 3. Audio Cache Storage Section
        _buildSectionCard(
          context,
          isDark: isDark,
          title: l10n.audioCached,
          icon: FluentIcons.storage_20_regular,
          child: _buildCacheSection(context, l10n, themeState, isDark),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required bool isDark,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final themeState = context.read<ThemeCubit>().state;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white,
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: themeState.primary),
              const Gap(8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(12),
          const Divider(height: 1),
          const Gap(12),
          child,
        ],
      ),
    );
  }

  Widget _buildCacheSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeState themeState,
    bool isDark,
  ) {
    return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
      future: getCategorizedCacheFilesWithSize(context, l10n),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: themeState.primary,
                ),
              ),
            ),
          );
        }

        final data = snapshot.data ?? {};
        final keys = data.keys.toList();

        return Column(
          children: [
            // Overall Cache Status & Clear All
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundedRadius - 2),
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : themeState.primaryShade100.withValues(alpha: 0.35),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.cacheSize,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Gap(2),
                        FutureBuilder<int>(
                          future: justAudioCache(),
                          builder: (context, sizeSnapshot) {
                            final bytes = sizeSnapshot.data ?? 0;
                            return Text(
                              formatBytes(bytes),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: themeState.primary,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
                      foregroundColor: Colors.redAccent,
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: keys.isEmpty
                        ? null
                        : () => _confirmClearAllCache(context, data, l10n),
                    child: Text(l10n.clean),
                  ),
                ],
              ),
            ),

            if (keys.isNotEmpty) ...[
              const Gap(14),
              ...keys.map((timeKey) {
                final fileList = data[timeKey] ?? [];
                var categorySize = 0;
                for (final f in fileList) {
                  categorySize += (f["size"] ?? 0) as int;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          timeKey,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        formatBytes(categorySize, 2),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                      const Gap(12),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        iconSize: 18,
                        tooltip: l10n.clean,
                        onPressed: () async {
                          for (final element in fileList) {
                            final f = File(element["path"] as String);
                            if (await f.exists()) await f.delete();
                          }
                          if (mounted) setState(() {});
                        },
                        icon: const Icon(
                          FluentIcons.delete_16_regular,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ] else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  l10n.cacheNotFound,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _confirmClearAllCache(
    BuildContext context,
    Map<String, List<Map<String, dynamic>>> data,
    AppLocalizations l10n,
  ) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(l10n.areYouSure),
          content: const Text(
            "This will delete all temporarily cached audio files to free up space.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () async {
                for (final key in data.keys) {
                  final list = data[key] ?? [];
                  for (final el in list) {
                    final f = File(el["path"] as String);
                    if (await f.exists()) await f.delete();
                  }
                }
                Navigator.pop(dialogContext);
                if (mounted) setState(() {});
              },
              child: Text(l10n.clean),
            ),
          ],
        );
      },
    );
  }
}

class PlayBackSpeedWidget extends StatelessWidget {
  const PlayBackSpeedWidget({super.key});

  static const List<double> _speedPresets = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.read<ThemeCubit>().state;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, quranViewState) {
        final currentSpeed = quranViewState.playbackSpeed;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.playbackSpeedDesc,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const Gap(12),

            // Speed Preset Chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _speedPresets.map((speed) {
                final isSelected = (currentSpeed - speed).abs() < 0.04;
                return ChoiceChip(
                  label: Text("${speed.toStringAsFixed(speed == speed.roundToDouble() ? 0 : 2)}x"),
                  selected: isSelected,
                  selectedColor: themeState.primary,
                  backgroundColor: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.04),
                  side: BorderSide.none,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade800,
                  ),
                  onSelected: (selected) async {
                    if (selected) {
                      context.read<QuranViewCubit>().setViewOptions(
                            playbackSpeed: speed,
                          );
                      await AudioPlayerManager.audioPlayer.setSpeed(speed);
                    }
                  },
                );
              }).toList(),
            ),

            const Gap(14),

            // Fine-tuning Slider
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                  visualDensity: VisualDensity.compact,
                  onPressed: currentSpeed > 0.5
                      ? () async {
                          final value = double.parse(
                            (currentSpeed - 0.05).clamp(0.5, 2.0).toStringAsFixed(2),
                          );
                          context.read<QuranViewCubit>().setViewOptions(
                                playbackSpeed: value,
                              );
                          await AudioPlayerManager.audioPlayer.setSpeed(value);
                        }
                      : null,
                ),
                Text(
                  "${currentSpeed.toStringAsFixed(2)}x",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  visualDensity: VisualDensity.compact,
                  onPressed: currentSpeed < 2.0
                      ? () async {
                          final value = double.parse(
                            (currentSpeed + 0.05).clamp(0.5, 2.0).toStringAsFixed(2),
                          );
                          context.read<QuranViewCubit>().setViewOptions(
                                playbackSpeed: value,
                              );
                          await AudioPlayerManager.audioPlayer.setSpeed(value);
                        }
                      : null,
                ),
                Expanded(
                  child: Slider(
                    value: currentSpeed.clamp(0.5, 2.0),
                    min: 0.5,
                    max: 2.0,
                    divisions: 30,
                    activeColor: themeState.primary,
                    onChanged: (value) {
                      final parsed = double.parse(value.toStringAsFixed(2));
                      context.read<QuranViewCubit>().setViewOptions(
                            playbackSpeed: parsed,
                          );
                    },
                    onChangeEnd: (value) async {
                      final parsed = double.parse(value.toStringAsFixed(2));
                      await AudioPlayerManager.audioPlayer.setSpeed(parsed);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

Future<Map<String, List<Map<String, dynamic>>>>
    getCategorizedCacheFilesWithSize(
  BuildContext context,
  AppLocalizations l10n,
) async {
  final Map<String, List<Map<String, dynamic>>> categorizedFiles = {};
  final tempDir = await getTemporaryDirectory();
  final cacheDir = Directory(join(tempDir.path, "just_audio_cache", "remote"));

  if (!await cacheDir.exists()) return categorizedFiles;

  final files = cacheDir.listSync().whereType<File>();
  final now = DateTime.now();

  for (final file in files) {
    final lastModified = file.lastModifiedSync();
    final differenceInDays = now.difference(lastModified).inDays;
    final fileSize = file.lengthSync();

    final fileInfo = {"path": file.path, "size": fileSize};
    final timeKey = getTheTimeKey(context, l10n, differenceInDays);
    final tem = categorizedFiles[timeKey] ?? [];
    tem.add(fileInfo);
    categorizedFiles[timeKey] = tem;
  }

  return categorizedFiles;
}

String getTheTimeKey(
  BuildContext context,
  AppLocalizations l10n,
  int distanceInDay,
) {
  if (distanceInDay > 365) return l10n.oneYearAgo;
  if (distanceInDay > 182) return l10n.monthsAgo(localizedNumber(context, 6));
  if (distanceInDay > 91) return l10n.monthsAgo(localizedNumber(context, 3));
  if (distanceInDay > 60) return l10n.monthsAgo(localizedNumber(context, 2));
  if (distanceInDay > 30) return l10n.monthsAgo(localizedNumber(context, 1));
  if (distanceInDay > 21) return l10n.weeksAgo(localizedNumber(context, 3));
  if (distanceInDay > 14) return l10n.weeksAgo(localizedNumber(context, 2));
  if (distanceInDay > 7) return l10n.weeksAgo(localizedNumber(context, 1));
  if (distanceInDay > 1) return l10n.daysAgo(localizedNumber(context, distanceInDay));
  return l10n.today;
}
