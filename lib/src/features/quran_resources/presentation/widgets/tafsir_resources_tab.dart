import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_filter_chips.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_language_group_card.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resources_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TafsirResourcesTab extends StatefulWidget {
  const TafsirResourcesTab({super.key});

  @override
  State<TafsirResourcesTab> createState() => _TafsirResourcesTabState();
}

class _TafsirResourcesTabState extends State<TafsirResourcesTab> {
  ResourceFilterType _filter = ResourceFilterType.all;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranResourcesCubit, QuranResourcesState>(
      builder: (context, state) {
        if (state.status == QuranResourcesStatus.loading &&
            state.tafsirGroups.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.tafsirGroups.isEmpty && state.searchQuery.isNotEmpty) {
          return ResourcesEmptyState(query: state.searchQuery);
        }

        int totalCount = 0;
        int downloadedCount = 0;
        int selectedCount = 0;

        for (final g in state.tafsirGroups) {
          for (final r in g.resources) {
            totalCount++;
            if (r.isDownloaded) downloadedCount++;
            if (r.isSelected) selectedCount++;
          }
        }

        final filteredGroups = state.tafsirGroups.map((g) {
          if (_filter == ResourceFilterType.downloaded) {
            return g.copyWith(
              resources: g.resources.where((r) => r.isDownloaded).toList(),
            );
          } else if (_filter == ResourceFilterType.selected) {
            return g.copyWith(
              resources: g.resources.where((r) => r.isSelected).toList(),
            );
          }
          return g;
        }).where((g) => g.resources.isNotEmpty).toList();

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: Column(
              children: [
                Center(
                  child: ResourceFilterChips(
                    activeFilter: _filter,
                    onFilterChanged: (f) => setState(() => _filter = f),
                    totalCount: totalCount,
                    downloadedCount: downloadedCount,
                    selectedCount: selectedCount,
                  ),
                ),
                Expanded(
                  child: filteredGroups.isEmpty
                      ? ResourcesEmptyState(
                          query: _filter == ResourceFilterType.downloaded
                              ? "downloaded tafsirs"
                              : "active tafsirs",
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                          itemCount: filteredGroups.length,
                          itemBuilder: (context, index) {
                            final group = filteredGroups[index];
                            return ResourceLanguageGroupCard(
                              group: group,
                              state: state,
                              forceExpanded: _filter != ResourceFilterType.all,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
