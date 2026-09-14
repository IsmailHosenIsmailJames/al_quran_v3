import 'package:al_quran_v3/src/core/theme/controller/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ResourceFilterType { all, downloaded, selected }

class ResourceFilterChips extends StatelessWidget {
  final ResourceFilterType activeFilter;
  final ValueChanged<ResourceFilterType> onFilterChanged;
  final int totalCount;
  final int downloadedCount;
  final int selectedCount;

  const ResourceFilterChips({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
    required this.totalCount,
    required this.downloadedCount,
    required this.selectedCount,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    Widget buildChip({
      required ResourceFilterType filter,
      required String label,
      required int count,
      required IconData icon,
    }) {
      final isSelected = activeFilter == filter;
      return FilterChip(
        selected: isSelected,
        showCheckmark: false,
        avatar: Icon(
          icon,
          size: 15,
          color: isSelected
              ? Colors.white
              : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
        ),
        label: Text(
          "$label ($count)",
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.grey.shade300 : Colors.grey.shade800),
          ),
        ),
        backgroundColor:
            isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        selectedColor: themeState.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected
                ? themeState.primary
                : (isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade300),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        onSelected: (_) => onFilterChanged(filter),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildChip(
            filter: ResourceFilterType.all,
            label: "All",
            count: totalCount,
            icon: Icons.all_inclusive_rounded,
          ),
          const SizedBox(width: 8),
          buildChip(
            filter: ResourceFilterType.downloaded,
            label: "Downloaded",
            count: downloadedCount,
            icon: Icons.download_done_rounded,
          ),
          const SizedBox(width: 8),
          buildChip(
            filter: ResourceFilterType.selected,
            label: "Active",
            count: selectedCount,
            icon: Icons.check_circle_rounded,
          ),
        ],
      ),
    );
  }
}
