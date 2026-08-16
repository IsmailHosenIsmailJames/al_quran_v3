import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/quran_ayah_count.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

Future<void> popupAyahRangeSelector(
  BuildContext context, {
  int? initialSurah,
  int? initialStartAyah,
  int? initialEndAyah,
}) async {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  final isLargeScreen = width >= 600;

  if (isLargeScreen) {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 520, maxHeight: height * 0.85),
            child: AyahRangeSelectorSheet(
              initialSurah: initialSurah,
              initialStartAyah: initialStartAyah,
              initialEndAyah: initialEndAyah,
            ),
          ),
        );
      },
    );
  } else {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AyahRangeSelectorSheet(
          initialSurah: initialSurah,
          initialStartAyah: initialStartAyah,
          initialEndAyah: initialEndAyah,
        );
      },
    );
  }
}

class AyahRangeSelectorSheet extends StatefulWidget {
  final int? initialSurah;
  final int? initialStartAyah;
  final int? initialEndAyah;

  const AyahRangeSelectorSheet({
    super.key,
    this.initialSurah,
    this.initialStartAyah,
    this.initialEndAyah,
  });

  @override
  State<AyahRangeSelectorSheet> createState() => _AyahRangeSelectorSheetState();
}

class _AyahRangeSelectorSheetState extends State<AyahRangeSelectorSheet> {
  late int _selectedSurah;
  late int _startAyah;
  late int _endAyah;
  int _repeatCount = -1; // -1 for infinite (infinity)

  static const List<int> _repeatPresets = [-1, 1, 3, 5, 10, 20];

  @override
  void initState() {
    super.initState();
    final loopState = context.read<AudioLoopCubit>().state;
    _selectedSurah = widget.initialSurah ?? (loopState.isRangeActive ? loopState.startSurah : 1);
    final totalVerses = quranAyahCount[_selectedSurah - 1];

    _startAyah = widget.initialStartAyah ??
        (loopState.isRangeActive ? loopState.startAyah : 1);
    _endAyah = widget.initialEndAyah ??
        (loopState.isRangeActive
            ? loopState.endAyah
            : (_startAyah + 9).clamp(1, totalVerses));

    _repeatCount = loopState.isRangeActive ? loopState.repeatTargetCount : -1;

    // Safety checks
    if (_startAyah < 1) _startAyah = 1;
    if (_startAyah > totalVerses) _startAyah = totalVerses;
    if (_endAyah < _startAyah) _endAyah = _startAyah;
    if (_endAyah > totalVerses) _endAyah = totalVerses;
  }

  int get _currentSurahVerses => quranAyahCount[_selectedSurah - 1];

  void _onSurahChanged(int newSurah) {
    setState(() {
      _selectedSurah = newSurah;
      final maxV = _currentSurahVerses;
      _startAyah = 1;
      _endAyah = (10).clamp(1, maxV);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeState = context.read<ThemeCubit>().state;
    final isDark = theme.brightness == Brightness.dark;
    final totalVerses = _currentSurahVerses;
    final selectedCount = (_endAyah - _startAyah) + 1;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
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

              // Title & Close
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: themeState.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FluentIcons.arrow_repeat_all_24_filled,
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
                          "Ayah Range & Memorization",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Loop a specific range of verses for learning",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
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

              // Surah Dropdown Selector
              Text(
                "Select Surah",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : themeState.primaryShade100.withValues(alpha: 0.35),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : themeState.primary.withValues(alpha: 0.15),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedSurah,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: List.generate(114, (index) {
                      final surahNum = index + 1;
                      return DropdownMenuItem<int>(
                        value: surahNum,
                        child: Text(
                          "$surahNum. ${getSurahName(context, surahNum)} (${quranAyahCount[index]} ayahs)",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      );
                    }),
                    onChanged: (val) {
                      if (val != null) _onSurahChanged(val);
                    },
                  ),
                ),
              ),

              const Gap(16),

              // Range Summary Banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(roundedRadius),
                  color: themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1),
                  border: Border.all(
                    color: themeState.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      FluentIcons.book_letter_24_regular,
                      color: themeState.primary,
                      size: 22,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getSurahName(context, _selectedSurah)}: Ayah $_startAyah – $_endAyah",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            "$selectedCount verses selected out of $totalVerses",
                            style: TextStyle(
                              fontSize: 12,
                              color: themeState.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(16),

              // Start & End Steppers
              Row(
                children: [
                  Expanded(
                    child: _buildAyahStepper(
                      title: "From Ayah",
                      value: _startAyah,
                      min: 1,
                      max: _endAyah,
                      onChanged: (val) => setState(() => _startAyah = val),
                      themeState: themeState,
                      isDark: isDark,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: _buildAyahStepper(
                      title: "To Ayah",
                      value: _endAyah,
                      min: _startAyah,
                      max: totalVerses,
                      onChanged: (val) => setState(() => _endAyah = val),
                      themeState: themeState,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const Gap(12),

              // Range Slider
              if (totalVerses > 1)
                RangeSlider(
                  values: RangeValues(_startAyah.toDouble(), _endAyah.toDouble()),
                  min: 1.0,
                  max: totalVerses.toDouble(),
                  divisions: totalVerses > 1 ? totalVerses - 1 : 1,
                  activeColor: themeState.primary,
                  labels: RangeLabels("Ayah $_startAyah", "Ayah $_endAyah"),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _startAyah = values.start.round();
                      _endAyah = values.end.round();
                    });
                  },
                ),

              const Gap(10),

              // Quick Presets
              Text(
                "Quick Presets",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(6),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _buildQuickPreset("Full Surah", () {
                    setState(() {
                      _startAyah = 1;
                      _endAyah = totalVerses;
                    });
                  }, isDark),
                  _buildQuickPreset("First 5", () {
                    setState(() {
                      _startAyah = 1;
                      _endAyah = 5.clamp(1, totalVerses);
                    });
                  }, isDark),
                  _buildQuickPreset("First 10", () {
                    setState(() {
                      _startAyah = 1;
                      _endAyah = 10.clamp(1, totalVerses);
                    });
                  }, isDark),
                  _buildQuickPreset("First 20", () {
                    setState(() {
                      _startAyah = 1;
                      _endAyah = 20.clamp(1, totalVerses);
                    });
                  }, isDark),
                ],
              ),

              const Gap(16),

              // Repeat Count Presets
              Text(
                "Repeat Range",
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(6),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: _repeatPresets.map((count) {
                  final isSelected = _repeatCount == count;
                  final label = count == -1 ? "Continuous (∞)" : "${count}x";

                  return ChoiceChip(
                    label: Text(label),
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
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _repeatCount = count);
                      }
                    },
                  );
                }).toList(),
              ),

              const Gap(22),

              // Action Buttons
              Row(
                children: [
                  // Cancel / Clear button
                  if (context.read<AudioLoopCubit>().state.isRangeActive)
                    Expanded(
                      flex: 2,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(roundedRadius),
                          ),
                        ),
                        onPressed: () async {
                          await context.read<AudioLoopCubit>().clearRange();
                          if (context.mounted) Navigator.pop(context);
                        },
                        child: const Text("Stop Range"),
                      ),
                    ),
                  if (context.read<AudioLoopCubit>().state.isRangeActive)
                    const Gap(10),

                  // Start Loop Button
                  Expanded(
                    flex: 3,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: themeState.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(roundedRadius),
                        ),
                      ),
                      onPressed: () async {
                        final audioLoopCubit = context.read<AudioLoopCubit>();
                        await audioLoopCubit.setRange(
                          startSurah: _selectedSurah,
                          startAyah: _startAyah,
                          endSurah: _selectedSurah,
                          endAyah: _endAyah,
                          repeatTargetCount: _repeatCount,
                        );

                        // Start playing the range
                        final startKey = "$_selectedSurah:$_startAyah";
                        final endKey = "$_selectedSurah:$_endAyah";

                        AudioPlayerManager.playMultipleAyahAsPlaylist(
                          startAyahKey: startKey,
                          endAyahKey: endKey,
                          isInsideQuran: false,
                          instantPlay: true,
                          reciterInfoModel:
                              context.read<AudioTabReciterCubit>().state,
                        );

                        if (context.mounted) Navigator.pop(context);
                      },
                      icon: const Icon(Icons.play_arrow_rounded, size: 22),
                      label: Text(
                        _repeatCount == -1
                            ? "Loop Range (∞)"
                            : "Play Range (${_repeatCount}x)",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAyahStepper({
    required String title,
    required int value,
    required int min,
    required int max,
    required Function(int val) onChanged,
    required ThemeState themeState,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : themeState.primaryShade100.withValues(alpha: 0.35),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : themeState.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const Gap(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                padding: EdgeInsets.zero,
                onPressed: value > min ? () => onChanged(value - 1) : null,
                icon: const Icon(Icons.remove_rounded),
              ),
              Text(
                "$value",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                padding: EdgeInsets.zero,
                onPressed: value < max ? () => onChanged(value + 1) : null,
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPreset(String label, VoidCallback onTap, bool isDark) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      labelStyle: TextStyle(
        fontSize: 11,
        color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
      ),
      backgroundColor: isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.04),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      visualDensity: VisualDensity.compact,
    );
  }
}
