import 'package:al_quran_v3/src/core/theme/controller/theme_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourcesEmptyState extends StatelessWidget {
  final String query;
  const ResourcesEmptyState({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: themeState.primary.withValues(alpha: isDark ? 0.15 : 0.08),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  FluentIcons.search_24_regular,
                  size: 36,
                  color: themeState.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "No resources found",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
            if (query.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'No resource matches "$query"',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  context.read<QuranResourcesCubit>().toggleSearching();
                },
                icon: const Icon(Icons.clear_rounded, size: 18),
                label: const Text("Clear search"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: themeState.primary,
                  side: BorderSide(
                    color: themeState.primary.withValues(alpha: 0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

