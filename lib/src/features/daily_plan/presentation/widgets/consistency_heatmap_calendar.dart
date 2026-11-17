import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_state.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";

/// A GitHub-style monthly activity heatmap calendar visualizing Quran reading consistency.
class ConsistencyHeatmapCalendar extends StatefulWidget {
  const ConsistencyHeatmapCalendar({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ConsistencyHeatmapCalendar(),
    );
  }

  @override
  State<ConsistencyHeatmapCalendar> createState() =>
      _ConsistencyHeatmapCalendarState();
}

class _ConsistencyHeatmapCalendarState
    extends State<ConsistencyHeatmapCalendar> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
  }

  void _previousMonth() {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    final now = DateTime.now();
    final currentMonthStart = DateTime(now.year, now.month, 1);
    if (_selectedMonth.isBefore(currentMonthStart)) {
      HapticFeedback.selectionClick();
      setState(() {
        _selectedMonth = DateTime(
          _selectedMonth.year,
          _selectedMonth.month + 1,
          1,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeState = context.watch<ThemeCubit>().state;
    final primary = themeState.primary;
    final now = DateTime.now();
    final isCurrentMonth = _selectedMonth.year == now.year &&
        _selectedMonth.month == now.month;

    return BlocBuilder<StreakCubit, StreakState>(
      builder: (context, state) {
        final streak = state.streak;
        final activeDatesSet = streak.activeDates.toSet();

        // Calculate days in selected month
        final daysInMonth = DateTime(
          _selectedMonth.year,
          _selectedMonth.month + 1,
          0,
        ).day;

        // First day of month weekday (1 = Mon, 7 = Sun)
        final firstWeekday = _selectedMonth.weekday; // 1 = Mon ... 7 = Sun
        final leadingBlanks = firstWeekday - 1; // Mon = 0 blanks

        // Active days count in this month
        int activeCountInMonth = 0;
        for (int day = 1; day <= daysInMonth; day++) {
          final dateStr =
              "${_selectedMonth.year}-${_selectedMonth.month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
          if (activeDatesSet.contains(dateStr)) {
            activeCountInMonth++;
          }
        }

        final monthPercent = daysInMonth > 0
            ? (activeCountInMonth / (isCurrentMonth ? now.day : daysInMonth)) * 100
            : 0.0;

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
              // Drag Handle
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title and Month Navigator
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: isDark ? 0.2 : 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.calendar_month_rounded,
                        size: 20,
                        color: primary,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Consistency Heatmap",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat("MMMM yyyy").format(_selectedMonth),
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

                  // Month Navigation Arrows
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded, size: 24),
                    onPressed: _previousMonth,
                    tooltip: "Previous Month",
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: isCurrentMonth
                          ? (isDark ? Colors.grey.shade700 : Colors.grey.shade300)
                          : null,
                    ),
                    onPressed: isCurrentMonth ? null : _nextMonth,
                    tooltip: "Next Month",
                  ),
                ],
              ),

              const Gap(14),

              // Monthly Summary KPI Strip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildKpiItem(
                      label: "Active Days",
                      value: "$activeCountInMonth / ${isCurrentMonth ? now.day : daysInMonth}",
                      isDark: isDark,
                      primary: primary,
                    ),
                    Container(
                      width: 1,
                      height: 28,
                      color: isDark ? Colors.white12 : Colors.grey.shade300,
                    ),
                    _buildKpiItem(
                      label: "Consistency",
                      value: "${monthPercent.clamp(0, 100).toStringAsFixed(0)}%",
                      isDark: isDark,
                      primary: primary,
                    ),
                    Container(
                      width: 1,
                      height: 28,
                      color: isDark ? Colors.white12 : Colors.grey.shade300,
                    ),
                    _buildKpiItem(
                      label: "Streak",
                      value: "${streak.currentStreak}d",
                      isDark: isDark,
                      primary: const Color(0xFFFF9800),
                    ),
                  ],
                ),
              ),

              const Gap(16),

              // Weekday Header Row (Mon - Sun)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ["M", "T", "W", "T", "F", "S", "S"].map((day) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Gap(8),

              // Calendar Days Grid (7 columns)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leadingBlanks + daysInMonth,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  if (index < leadingBlanks) {
                    return const SizedBox.shrink();
                  }

                  final day = index - leadingBlanks + 1;
                  final date = DateTime(
                    _selectedMonth.year,
                    _selectedMonth.month,
                    day,
                  );
                  final dateStr =
                      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  final isActive = activeDatesSet.contains(dateStr);
                  final isToday = now.year == date.year &&
                      now.month == date.month &&
                      now.day == date.day;
                  final isFuture = date.isAfter(now);

                  return InkWell(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      _showDayDetails(
                        context,
                        dateStr: dateStr,
                        day: day,
                        isActive: isActive,
                        isToday: isToday,
                        isDark: isDark,
                        primary: primary,
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isActive
                            ? (isDark
                                ? const Color(0xFF00C853).withValues(alpha: 0.85)
                                : const Color(0xFF00C853))
                            : (isFuture
                                ? Colors.transparent
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.05)
                                    : Colors.grey.shade100)),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isToday
                              ? primary
                              : (isActive
                                  ? Colors.transparent
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.08)
                                      : Colors.grey.shade200)),
                          width: isToday ? 2.0 : 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "$day",
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: isActive || isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isActive
                                ? Colors.white
                                : (isFuture
                                    ? (isDark
                                        ? Colors.grey.shade700
                                        : Colors.grey.shade300)
                                    : (isDark
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade800)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const Gap(14),

              // Legend Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendIndicator(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.grey.shade200,
                    label: "Rest / Missed",
                    isDark: isDark,
                  ),
                  const Gap(16),
                  _buildLegendIndicator(
                    color: const Color(0xFF00C853),
                    label: "Quran Read",
                    isDark: isDark,
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: primary, width: 2),
                        ),
                      ),
                      const Gap(6),
                      Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Gap(14),

              // Encouraging Hadith
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: isDark ? 0.08 : 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "\"Take up good deeds only as much as you are able, for Allah does not tire until you tire... the most beloved deed to Allah is the most regular.\" — Sahih al-Bukhari",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontStyle: FontStyle.italic,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKpiItem({
    required String label,
    required String value,
    required bool isDark,
    required Color primary,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            color: primary,
          ),
        ),
        const Gap(2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendIndicator({
    required Color color,
    required String label,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const Gap(6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  void _showDayDetails(
    BuildContext context, {
    required String dateStr,
    required int day,
    required bool isActive,
    required bool isToday,
    required bool isDark,
    required Color primary,
  }) {
    final statusText = isActive
        ? "✓ Quran read on this day. Streak maintained!"
        : (isToday
            ? "Read Quran today to light up this day!"
            : "No reading logged for this date.");

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$dateStr: $statusText",
          style: const TextStyle(fontSize: 12),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
