import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/domain/entities/khatam_plan_entity.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:material_ui/material_ui.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";

/// Modal sheet for creating, tracking, and editing Khatam Reading Plans.
class KhatamPlannerModal extends StatefulWidget {
  const KhatamPlannerModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const KhatamPlannerModal(),
    );
  }

  @override
  State<KhatamPlannerModal> createState() => _KhatamPlannerModalState();
}

class _KhatamPlannerModalState extends State<KhatamPlannerModal> {
  int _selectedDurationDays = 30;
  String _planTitle = "30-Day Khatam";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;
    final primary = themeState.primary;

    return BlocBuilder<StreakCubit, StreakState>(
      builder: (context, state) {
        final plan = state.khatamPlan;

        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title Header
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: isDark ? 0.2 : 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        FluentIcons.book_star_20_filled,
                        size: 20,
                        color: primary,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Khatam & Goal Planner",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          plan != null
                              ? "Adaptive daily quota based on your pace"
                              : "Set a structured Quran completion plan",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (plan != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, size: 20),
                      color: Colors.red.shade400,
                      tooltip: "End Plan",
                      onPressed: () => _confirmDelete(context),
                    ),
                ],
              ),

              const Gap(16),

              if (plan != null) ...[
                // ACTIVE PLAN VIEW
                _buildActivePlanView(context, plan, isDark, primary),
              ] else ...[
                // CREATE PLAN VIEW
                _buildCreatePlanView(context, isDark, primary),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivePlanView(
    BuildContext context,
    KhatamPlanEntity plan,
    bool isDark,
    Color primary,
  ) {
    final dateFormat = DateFormat("d MMM yyyy");
    final targetStr = dateFormat.format(plan.targetDate);

    return Column(
      children: [
        // Progress Ring Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.04)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              // Circular Progress Ring
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 76,
                    height: 76,
                    child: CircularProgressIndicator(
                      value: plan.progressFraction,
                      strokeWidth: 7,
                      backgroundColor: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        plan.isCompleted ? Colors.green : primary,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${plan.progressPercent.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "${plan.completedPages}/${plan.totalPages}",
                        style: TextStyle(
                          fontSize: 9.5,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(16),

              // Plan Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "Target: $targetStr",
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      "${plan.daysRemaining} days remaining",
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const Gap(12),

        // Dynamic Quota Metric Row
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: "Daily Quota",
                value: "${plan.roundedDailyPagesQuota} p/day",
                subtitle: "Adaptive pace",
                icon: FluentIcons.target_arrow_20_regular,
                isDark: isDark,
                primary: primary,
              ),
            ),
            const Gap(10),
            Expanded(
              child: _buildMetricTile(
                title: "Pages Left",
                value: "${plan.pagesRemaining}",
                subtitle: "out of ${plan.totalPages}",
                icon: FluentIcons.document_page_bottom_right_20_regular,
                isDark: isDark,
                primary: primary,
              ),
            ),
          ],
        ),

        const Gap(12),

        // Manual Page Adjuster Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.04)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              Text(
                "Manual Page Progress:",
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                ),
              ),
              const Spacer(),
              // -1 Page Button
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.remove_circle_outline_rounded, size: 22),
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                onPressed: plan.completedPages > 0
                    ? () {
                        HapticFeedback.lightImpact();
                        context.read<StreakCubit>().updateKhatamPages(
                          plan.completedPages - 1,
                        );
                      }
                    : null,
              ),
              Text(
                "${plan.completedPages}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // +1 Page Button
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.add_circle_outline_rounded,
                  size: 22,
                  color: primary,
                ),
                onPressed: plan.completedPages < plan.totalPages
                    ? () {
                        HapticFeedback.lightImpact();
                        context.read<StreakCubit>().updateKhatamPages(
                          plan.completedPages + 1,
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),

        const Gap(12),

        // Explanatory Note
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: isDark ? 0.08 : 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 16, color: primary),
              const Gap(8),
              Expanded(
                child: Text(
                  "Reading in the Mushaf automatically updates this quota. Reading extra decreases tomorrow's quota smoothly.",
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreatePlanView(
    BuildContext context,
    bool isDark,
    Color primary,
  ) {
    final presets = [
      {"days": 30, "title": "30-Day Ramadan Khatam", "quota": "~20 pages/day"},
      {"days": 60, "title": "60-Day (2 Months)", "quota": "~10 pages/day"},
      {"days": 90, "title": "90-Day (3 Months)", "quota": "~7 pages/day"},
      {"days": 180, "title": "6 Months Khatam", "quota": "~3.4 pages/day"},
      {"days": 365, "title": "1 Year Khatam", "quota": "~1.7 pages/day"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Target Duration:",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const Gap(10),

        // Presets list
        Column(
          children: presets.map((preset) {
            final days = preset["days"] as int;
            final title = preset["title"] as String;
            final quota = preset["quota"] as String;
            final isSelected = _selectedDurationDays == days;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _selectedDurationDays = days;
                    _planTitle = title;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primary.withValues(alpha: isDark ? 0.18 : 0.08)
                        : (isDark
                              ? Colors.white.withValues(alpha: 0.03)
                              : Colors.grey.shade50),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? primary
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.08)
                                : Colors.grey.shade200),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off_rounded,
                        size: 18,
                        color: isSelected
                            ? primary
                            : (isDark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade400),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          quota,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const Gap(14),

        // Start Plan Button
        SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              final plan = KhatamPlanEntity.custom(
                title: _planTitle,
                days: _selectedDurationDays,
                totalPages: 604,
              );
              context.read<StreakCubit>().saveKhatamPlan(plan);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Start Khatam Plan",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required bool isDark,
    required Color primary,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: primary),
              const Gap(6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.5,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const Gap(6),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text("End Khatam Plan?"),
        content: const Text(
          "Are you sure you want to end your active Khatam plan? Your reading history and streaks will remain untouched.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              context.read<StreakCubit>().deleteKhatamPlan();
            },
            child: Text(
              "End Plan",
              style: TextStyle(color: Colors.red.shade400),
            ),
          ),
        ],
      ),
    );
  }
}
