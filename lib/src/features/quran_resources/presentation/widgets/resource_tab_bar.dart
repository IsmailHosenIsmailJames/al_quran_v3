import 'package:al_quran_v3/l10n/app_localizations.dart';
import 'package:al_quran_v3/src/core/theme/controller/theme_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceTabBar extends StatelessWidget {
  final TabController tabController;

  const ResourceTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final appLocalizations = AppLocalizations.of(context);

    final pagesName = [
      appLocalizations.translation,
      appLocalizations.tafsir,
      appLocalizations.wordByWord,
    ];

    return Container(
      color: isDark ? const Color(0xFF121212) : Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.grey.shade300,
            width: 1.0,
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
                color: themeState.primary.withValues(alpha: 0.28),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          labelColor: Colors.white,
          unselectedLabelColor:
              isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          tabs: pagesName
              .map(
                (name) => Tab(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          dividerColor: Colors.transparent,
          onTap: (index) {
            context.read<QuranResourcesCubit>().changeTab(index);
          },
        ),
      ),
    );
  }
}
