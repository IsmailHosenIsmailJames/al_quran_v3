import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// A clean, solid TabBar header delegate for Quran categories.
class QuranTabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final List<String> tabNames;

  const QuranTabBarHeaderDelegate({
    required this.tabController,
    required this.tabNames,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : Theme.of(context).scaffoldBackgroundColor;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E1E1E)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.grey.shade300,
          ),
        ),
        child: TabBar(
          controller: tabController,
          splashBorderRadius: BorderRadius.circular(24),
          indicator: BoxDecoration(
            color: themeState.primary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: themeState.primary.withValues(alpha: 0.25),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          labelColor: Colors.white,
          unselectedLabelColor:
              isDark ? Colors.grey.shade400 : Colors.grey.shade700,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          dividerColor: Colors.transparent,
          tabs: tabNames.map((name) => Tab(text: name)).toList(),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant QuranTabBarHeaderDelegate oldDelegate) {
    return oldDelegate.tabController != tabController ||
        oldDelegate.tabNames != tabNames;
  }
}
