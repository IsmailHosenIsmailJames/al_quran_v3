import 'package:al_quran_v3/src/features/quran_resources/domain/entities/resource_group_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_item_tile.dart';
import 'package:al_quran_v3/src/theme/controller/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceLanguageGroupCard extends StatelessWidget {
  final ResourceGroupEntity group;
  final QuranResourcesState state;

  const ResourceLanguageGroupCard({
    super.key,
    required this.group,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final int downloadedCount =
        group.resources.where((r) => r.isDownloaded).length;
    final int selectedCount =
        group.resources.where((r) => r.isSelected).length;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: themeState.primaryShade100.withValues(alpha: 0.6),
          width: 1.0,
        ),
      ),
      child: ExpansionTile(
        key: PageStorageKey(group.languageKey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          group.languageNative,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              group.languageEnglish,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 8),
            if (selectedCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: themeState.primaryShade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$selectedCount Active",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: themeState.primary,
                  ),
                ),
              )
            else if (downloadedCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$downloadedCount Downloaded",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        childrenPadding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 8.0,
        ),
        children: group.resources.map((resource) {
          final bool isDownloading =
              state.downloadingResourcePath == resource.fullPath;
          return ResourceItemTile(
            resource: resource,
            isDownloading: isDownloading,
            downloadProgress: isDownloading ? state.downloadProgress : 0.0,
          );
        }).toList(),
      ),
    );
  }
}
