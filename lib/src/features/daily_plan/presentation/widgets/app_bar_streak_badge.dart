import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_state.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/widgets/khatam_planner_modal.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class AppBarStreakBadge extends StatelessWidget {
  const AppBarStreakBadge({super.key});

  void _showStreakDetails(BuildContext context, StreakState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeState = context.read<ThemeCubit>().state;
    final streak = state.streak;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header icon
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800).withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_fire_department_rounded,
                      color: Color(0xFFFF9800),
                      size: 32,
                    ),
                  ),
                ),
                const Gap(10),

                // Title
                const Text(
                  "Istiqamah Streak",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(3),
                Text(
                  streak.isActiveToday
                      ? "Masha'Allah! You've maintained your streak today."
                      : "Read any page or Ayah to keep your streak alive today!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                const Gap(16),

                // Stats Cards Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildStatTile(
                        context,
                        title: "Current",
                        value: "${streak.currentStreak} Days",
                        icon: Icons.local_fire_department_rounded,
                        color: const Color(0xFFFF9800),
                        isDark: isDark,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: _buildStatTile(
                        context,
                        title: "Best Record",
                        value: "${streak.bestStreak} Days",
                        icon: FluentIcons.trophy_20_filled,
                        color: themeState.primary,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatTile(
                        context,
                        title: "Today's Ayahs",
                        value: "${streak.todayAyahsRead}",
                        icon: FluentIcons.book_letter_20_regular,
                        color: Colors.blueAccent,
                        isDark: isDark,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: _buildStatTile(
                        context,
                        title: "Grace Days",
                        value: "${streak.graceDaysRemaining} Left",
                        icon: FluentIcons.shield_checkmark_20_regular,
                        color: Colors.teal,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),

                const Gap(12),

                // Khatam Planner Shortcut
                InkWell(
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    KhatamPlannerModal.show(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: themeState.primary
                          .withValues(alpha: isDark ? 0.15 : 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: themeState.primary
                            .withValues(alpha: isDark ? 0.3 : 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.book_star_20_filled,
                          size: 18,
                          color: themeState.primary,
                        ),
                        const Gap(10),
                        Expanded(
                          child: Text(
                            state.khatamPlan != null
                                ? "${state.khatamPlan!.title}: ${state.khatamPlan!.roundedDailyPagesQuota} p/day (${state.khatamPlan!.progressPercent.toStringAsFixed(0)}%)"
                                : "Set a Khatam & Daily Reading Goal",
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: themeState.primary,
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(14),

                // Hadith Footer
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "\"The most beloved of deeds to Allah are those that are most consistent, even if they are small.\" — Sahih al-Bukhari",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatTile(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF282828) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<StreakCubit, StreakState>(
      builder: (context, state) {
        final streak = state.streak;
        final isActiveToday = streak.isActiveToday;
        final streakCount = streak.currentStreak;

        return Tooltip(
          message: isActiveToday
              ? "Streak active! ($streakCount days)"
              : "Read today to keep streak active ($streakCount days)",
          child: InkWell(
            onTap: () => _showStreakDetails(context, state),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: isActiveToday
                    ? const Color(0xFFFF9800).withValues(
                        alpha: isDark ? 0.18 : 0.12,
                      )
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActiveToday
                      ? const Color(0xFFFF9800).withValues(
                          alpha: isDark ? 0.35 : 0.3,
                        )
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade300),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isActiveToday
                        ? Icons.local_fire_department_rounded
                        : Icons.local_fire_department_outlined,
                    size: 17,
                    color: isActiveToday
                        ? const Color(0xFFFF9800)
                        : (isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600),
                  ),
                  const Gap(4),
                  Text(
                    "$streakCount",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isActiveToday
                          ? const Color(0xFFFF9800)
                          : (isDark ? Colors.white : Colors.grey.shade800),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
