import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/daily_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_state.dart";
import "package:al_quran_v3/src/features/home/presentation/cubit/quran_history_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/widgets/surah_info_header_builder.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class TodayPlanHelperCard extends StatelessWidget {
  const TodayPlanHelperCard({super.key});

  void _openSurah(BuildContext context, int surahNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuranScriptView(
          startKey: "$surahNumber:1",
          endKey: getEndAyahKeyFromSurahNumber(surahNumber),
          toScrollKey: "$surahNumber:1",
        ),
      ),
    );
  }

  void _openLastReadOrFatihah(BuildContext context) {
    final history = context.read<QuranHistoryCubit>().state.history;
    int surah = 1;
    String toScroll = "1:1";
    if (history.isNotEmpty) {
      final last = history.first;
      surah = last.surahNumber;
      toScroll = last.ayahNumber != null
          ? "$surah:${last.ayahNumber}"
          : "$surah:1";
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuranScriptView(
          startKey: "$surah:1",
          endKey: getEndAyahKeyFromSurahNumber(surah),
          toScrollKey: toScroll,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;
    final primary = themeState.primary;

    final isFriday = DateTime.now().weekday == DateTime.friday;
    final sunnahSurahNumber = isFriday ? 18 : 67;
    final sunnahSurahName = isFriday ? "Surah Al-Kahf" : "Surah Al-Mulk";
    final sunnahSurahSubtitle =
        isFriday ? "Friday Sunnah • Verses 1–110" : "Night Sunnah • 30 Verses";

    return BlocBuilder<StreakCubit, StreakState>(
      builder: (context, state) {
        final streak = state.streak;
        final plan = state.plan;

        final isQuranDone = streak.isActiveToday;
        final isSunnahDone = plan.isSunnahSurahCompleted;
        final isPrayersDone = plan.allPrayersCompleted;

        int completedGoals = 0;
        if (isQuranDone) completedGoals++;
        if (isSunnahDone) completedGoals++;
        if (isPrayersDone) completedGoals++;

        final isCollapsed = plan.isCollapsed;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Row (Always visible, tap to collapse/expand)
              InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  context.read<StreakCubit>().togglePlanCollapsed();
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      // Circular Progress / Checkmark Indicator
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: completedGoals == 3
                              ? Colors.green.withValues(alpha: 0.15)
                              : primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            completedGoals == 3
                                ? Icons.check_circle_rounded
                                : FluentIcons.task_list_square_ltr_20_regular,
                            size: 18,
                            color: completedGoals == 3 ? Colors.green : primary,
                          ),
                        ),
                      ),
                      const Gap(10),

                      // Title & Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Today's Plan",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Gap(6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (completedGoals == 3
                                            ? Colors.green
                                            : primary)
                                        .withValues(
                                          alpha: isDark ? 0.18 : 0.1,
                                        ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "$completedGoals/3 Done",
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: completedGoals == 3
                                          ? Colors.green
                                          : primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(2),
                            Text(
                              completedGoals == 3
                                  ? "All spiritual tasks completed for today!"
                                  : "Complete your daily reading & prayers",
                              style: TextStyle(
                                fontSize: 11.5,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expand / Collapse Chevron
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 200),
                        turns: isCollapsed ? 0.0 : 0.5,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded Checklist Content
              if (!isCollapsed) ...[
                Divider(
                  height: 1,
                  thickness: 0.8,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.grey.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                  child: Column(
                    children: [
                      // Task 1: Daily Quran Reading
                      _buildTaskRow(
                        context,
                        isDone: isQuranDone,
                        title: "Daily Quran Reading",
                        subtitle: streak.isActiveToday
                            ? "${streak.todayAyahsRead} ayahs read today"
                            : "Read at least 1 page or Ayah",
                        isDark: isDark,
                        primary: primary,
                        actionLabel: streak.isActiveToday ? "Resume" : "Read",
                        onAction: () => _openLastReadOrFatihah(context),
                      ),

                      const Gap(8),

                      // Task 2: Sunnah Surah (Al-Kahf on Friday / Al-Mulk daily)
                      _buildTaskRow(
                        context,
                        isDone: isSunnahDone,
                        title: sunnahSurahName,
                        subtitle: sunnahSurahSubtitle,
                        isDark: isDark,
                        primary: primary,
                        actionLabel: "Open",
                        onToggleCheck: () {
                          HapticFeedback.selectionClick();
                          context.read<StreakCubit>().toggleSunnahSurah();
                        },
                        onAction: () => _openSurah(context, sunnahSurahNumber),
                      ),

                      const Gap(10),

                      // Task 3: 5 Daily Prayers
                      _buildPrayersRow(
                        context,
                        plan: plan,
                        isDark: isDark,
                        primary: primary,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskRow(
    BuildContext context, {
    required bool isDone,
    required String title,
    required String subtitle,
    required bool isDark,
    required Color primary,
    required String actionLabel,
    VoidCallback? onToggleCheck,
    required VoidCallback onAction,
  }) {
    return Row(
      children: [
        // Checkbox button
        GestureDetector(
          onTap: onToggleCheck,
          child: Icon(
            isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
            size: 20,
            color: isDone
                ? Colors.green
                : (isDark ? Colors.grey.shade500 : Colors.grey.shade400),
          ),
        ),
        const Gap(10),

        // Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  color: isDone
                      ? (isDark ? Colors.grey.shade400 : Colors.grey.shade600)
                      : (isDark ? Colors.white : Colors.black87),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),

        // Action Pill Button
        InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onAction();
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: isDark ? 0.16 : 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: primary.withValues(alpha: isDark ? 0.3 : 0.2),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                const Gap(2),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 9,
                  color: primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrayersRow(
    BuildContext context, {
    required DailyPlanEntity plan,
    required bool isDark,
    required Color primary,
  }) {
    final l10n = AppLocalizations.of(context);
    final names = [
      {"key": "fajr", "label": l10n.fajr},
      {"key": "dhuhr", "label": l10n.dhuhr},
      {"key": "asr", "label": l10n.asr},
      {"key": "maghrib", "label": l10n.maghrib},
      {"key": "isha", "label": l10n.isha},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              plan.allPrayersCompleted
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              size: 20,
              color: plan.allPrayersCompleted
                  ? Colors.green
                  : (isDark ? Colors.grey.shade500 : Colors.grey.shade400),
            ),
            const Gap(10),
            Text(
              "5 Daily Prayers",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const Spacer(),
            Text(
              "${plan.completedPrayersCount}/5",
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const Gap(8),

        // 5 Prayer Pill Buttons Row
        Row(
          children: names.map((item) {
            final key = item["key"]!;
            final label = item["label"]!;
            final isChecked = plan.prayersCompleted[key] == true;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    context.read<StreakCubit>().togglePrayer(key);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.5),
                    decoration: BoxDecoration(
                      color: isChecked
                          ? primary.withValues(alpha: isDark ? 0.22 : 0.12)
                          : (isDark
                              ? Colors.white.withValues(alpha: 0.04)
                              : Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isChecked
                            ? primary.withValues(alpha: isDark ? 0.45 : 0.35)
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.08)
                                : Colors.grey.shade300),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isChecked ? FontWeight.bold : FontWeight.w500,
                            color: isChecked
                                ? primary
                                : (isDark
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade700),
                          ),
                        ),
                        const Gap(2),
                        Icon(
                          isChecked
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          size: 13,
                          color: isChecked
                              ? primary
                              : (isDark
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
