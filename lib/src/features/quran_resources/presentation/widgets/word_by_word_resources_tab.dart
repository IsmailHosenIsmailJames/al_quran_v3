import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_item_tile.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resources_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordByWordResourcesTab extends StatelessWidget {
  const WordByWordResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranResourcesCubit, QuranResourcesState>(
      builder: (context, state) {
        if (state.status == QuranResourcesStatus.loading &&
            state.wordByWordResources.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.wordByWordResources.isEmpty) {
          return ResourcesEmptyState(query: state.searchQuery);
        }

        return ListView.builder(
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 60,
            bottom: 24,
            left: 16,
            right: 16,
          ),
          itemCount: state.wordByWordResources.length,
          itemBuilder: (context, index) {
            final resource = state.wordByWordResources[index];
            final bool isDownloading =
                state.downloadingResourcePath == resource.fullPath;
            return ResourceItemTile(
              resource: resource,
              isDownloading: isDownloading,
              downloadProgress: isDownloading ? state.downloadProgress : 0.0,
            );
          },
        );
      },
    );
  }
}
