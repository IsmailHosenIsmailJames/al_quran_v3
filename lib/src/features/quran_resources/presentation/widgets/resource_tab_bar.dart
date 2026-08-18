import 'package:al_quran_v3/l10n/app_localizations.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/core/theme/controller/theme_cubit.dart';
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
    final appLocalizations = AppLocalizations.of(context);

    final pagesName = [
      appLocalizations.translation,
      appLocalizations.tafsir,
      appLocalizations.wordByWord,
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Theme.brightnessOf(context) == Brightness.dark
                ? const Color(0xFF1E1E1E)
                : themeState.primaryShade100.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Theme.brightnessOf(context) == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.08)
                  : themeState.primaryShade200,
              width: 1.0,
            ),
          ),
          child: TabBar(
                controller: tabController,
                splashBorderRadius: BorderRadius.circular(100),
                indicator: BoxDecoration(
                  color: themeState.primaryShade200,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: themeState.primary.withValues(alpha: 0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onSurfaceVariant,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                tabs: pagesName.map((name) => Tab(text: name)).toList(),
                dividerColor: Colors.transparent,
                onTap: (index) {
                  context.read<QuranResourcesCubit>().changeTab(index);
                },
              ),
        ),
      ),
    );
  }
}
