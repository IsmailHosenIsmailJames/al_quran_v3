import 'package:al_quran_v3/src/core/theme/controller/theme_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/resource_group_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceLanguageGroupCard extends StatelessWidget {
  final ResourceGroupEntity group;
  final QuranResourcesState state;
  final bool forceExpanded;

  const ResourceLanguageGroupCard({
    super.key,
    required this.group,
    required this.state,
    this.forceExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final int downloadedCount =
        group.resources.where((r) => r.isDownloaded).length;
    final int selectedCount =
        group.resources.where((r) => r.isSelected).length;
    final isSearchActive = state.searchQuery.trim().isNotEmpty;
    final shouldExpand = isSearchActive || forceExpanded;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: PageStorageKey("${group.languageKey}_$shouldExpand"),
          initiallyExpanded: shouldExpand,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          iconColor: themeState.primary,
          collapsedIconColor:
              isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: themeState.primary.withValues(alpha: isDark ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.translate_rounded,
                size: 20,
                color: themeState.primary,
              ),
            ),
          ),
          title: Text(
            group.languageNative,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.grey.shade900,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  group.languageEnglish,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                if (selectedCount > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: themeState.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: themeState.primary.withValues(alpha: 0.3),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 11,
                          color: themeState.primary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "$selectedCount Active",
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: themeState.primary,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (downloadedCount > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : Colors.grey.shade300,
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.download_done_rounded,
                          size: 11,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "$downloadedCount Downloaded",
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${group.resources.length}",
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color:
                          isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          childrenPadding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            bottom: 12.0,
            top: 4.0,
          ),
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 640;
                if (isWide) {
                  final rows = <Widget>[];
                  for (int i = 0; i < group.resources.length; i += 2) {
                    final r1 = group.resources[i];
                    final r2 = (i + 1 < group.resources.length)
                        ? group.resources[i + 1]
                        : null;

                    final bool isDownloading1 =
                        state.downloadingResourcePath == r1.fullPath;
                    final bool isDownloading2 = r2 != null &&
                        state.downloadingResourcePath == r2.fullPath;

                    rows.add(
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ResourceItemTile(
                                resource: r1,
                                isDownloading: isDownloading1,
                                downloadProgress: isDownloading1
                                    ? state.downloadProgress
                                    : 0.0,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: r2 != null
                                  ? ResourceItemTile(
                                      resource: r2,
                                      isDownloading: isDownloading2,
                                      downloadProgress: isDownloading2
                                          ? state.downloadProgress
                                          : 0.0,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(children: rows);
                }

                return Column(
                  children: group.resources.map((resource) {
                    final bool isDownloading =
                        state.downloadingResourcePath == resource.fullPath;
                    return ResourceItemTile(
                      resource: resource,
                      isDownloading: isDownloading,
                      downloadProgress:
                          isDownloading ? state.downloadProgress : 0.0,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

