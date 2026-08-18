import 'package:al_quran_v3/l10n/app_localizations.dart';
import 'package:al_quran_v3/src/features/quran_resources/domain/entities/quran_resource_entity.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/core/theme/controller/theme_cubit.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceItemTile extends StatelessWidget {
  final QuranResourceEntity resource;
  final bool isDownloading;
  final double downloadProgress;

  const ResourceItemTile({
    super.key,
    required this.resource,
    required this.isDownloading,
    required this.downloadProgress,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<QuranResourcesCubit>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: resource.isSelected
            ? themeState.primaryShade100.withValues(alpha: 0.25)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: resource.isSelected
              ? themeState.primary
              : themeState.primaryShade100.withValues(alpha: 0.5),
          width: resource.isSelected ? 1.5 : 0.8,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        title: Row(
          children: [
            Expanded(
              child: Text(
                resource.name,
                style: TextStyle(
                  fontWeight: resource.isSelected
                      ? FontWeight.bold
                      : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            if (resource.hasFootnote) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: themeState.primaryShade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Footnotes",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: themeState.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: resource.englishName != resource.name
            ? Text(
                resource.englishName,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isDownloading)
              SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  value: downloadProgress > 0 ? downloadProgress : null,
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(themeState.primary),
                  backgroundColor: themeState.primaryShade100,
                ),
              )
            else if (!resource.isDownloaded)
              IconButton(
                icon: Icon(
                  FluentIcons.arrow_download_24_regular,
                  color: themeState.primary,
                ),
                tooltip: "Download",
                onPressed: () => cubit.downloadResource(resource),
              )
            else ...[
              IconButton(
                icon: Icon(
                  resource.isSelected
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                  color: resource.isSelected
                      ? themeState.primary
                      : Colors.grey[500],
                  size: 26,
                ),
                tooltip: resource.isSelected ? "Deselect" : "Select",
                onPressed: () => cubit.toggleSelection(resource),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                onSelected: (value) {
                  if (value == 'delete') {
                    cubit.deleteResource(resource);
                  } else if (value == 'redownload') {
                    cubit.redownloadResource(resource);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'redownload',
                    child: Row(
                      children: [
                        Icon(
                          FluentIcons.arrow_download_24_regular,
                          color: themeState.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text("Redownload"),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(
                          FluentIcons.delete_24_regular,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(appLocalizations.delete),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        onTap: () {
          if (isDownloading) return;
          if (!resource.isDownloaded) {
            cubit.downloadResource(resource);
          } else {
            cubit.toggleSelection(resource);
          }
        },
      ),
    );
  }
}
