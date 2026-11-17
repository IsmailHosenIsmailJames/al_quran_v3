import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_filter_chips.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_item_tile.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resources_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordByWordResourcesTab extends StatefulWidget {
  const WordByWordResourcesTab({super.key});

  @override
  State<WordByWordResourcesTab> createState() => _WordByWordResourcesTabState();
}

class _WordByWordResourcesTabState extends State<WordByWordResourcesTab> {
  ResourceFilterType _filter = ResourceFilterType.all;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranResourcesCubit, QuranResourcesState>(
      builder: (context, state) {
        if (state.status == QuranResourcesStatus.loading &&
            state.wordByWordResources.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.wordByWordResources.isEmpty && state.searchQuery.isNotEmpty) {
          return ResourcesEmptyState(query: state.searchQuery);
        }

        int totalCount = state.wordByWordResources.length;
        int downloadedCount =
            state.wordByWordResources.where((r) => r.isDownloaded).length;
        int selectedCount =
            state.wordByWordResources.where((r) => r.isSelected).length;

        final filteredResources = state.wordByWordResources.where((r) {
          if (_filter == ResourceFilterType.downloaded) {
            return r.isDownloaded;
          }
          if (_filter == ResourceFilterType.selected) {
            return r.isSelected;
          }
          return true;
        }).toList();

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
                  child: filteredResources.isEmpty
                      ? ResourcesEmptyState(
                          query: _filter == ResourceFilterType.downloaded
                              ? "downloaded word by word"
                              : "active word by word",
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth >= 640;
                            if (isWide) {
                              return GridView.builder(
                                physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(16, 6, 16, 24),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 80,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 6,
                                ),
                                itemCount: filteredResources.length,
                                itemBuilder: (context, index) {
                                  final resource = filteredResources[index];
                                  final bool isDownloading =
                                      state.downloadingResourcePath ==
                                          resource.fullPath;
                                  return ResourceItemTile(
                                    resource: resource,
                                    isDownloading: isDownloading,
                                    downloadProgress: isDownloading
                                        ? state.downloadProgress
                                        : 0.0,
                                  );
                                },
                              );
                            }

                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                              itemCount: filteredResources.length,
                              itemBuilder: (context, index) {
                                final resource = filteredResources[index];
                                final bool isDownloading =
                                    state.downloadingResourcePath ==
                                        resource.fullPath;
                                return ResourceItemTile(
                                  resource: resource,
                                  isDownloading: isDownloading,
                                  downloadProgress: isDownloading
                                      ? state.downloadProgress
                                      : 0.0,
                                );
                              },
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
