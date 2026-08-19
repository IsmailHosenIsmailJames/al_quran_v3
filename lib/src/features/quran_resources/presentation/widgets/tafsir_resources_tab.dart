import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_language_group_card.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resources_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TafsirResourcesTab extends StatelessWidget {
  const TafsirResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranResourcesCubit, QuranResourcesState>(
      builder: (context, state) {
        if (state.status == QuranResourcesStatus.loading &&
            state.tafsirGroups.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.tafsirGroups.isEmpty) {
          return ResourcesEmptyState(query: state.searchQuery);
        }

        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
          itemCount: state.tafsirGroups.length,
          itemBuilder: (context, index) {
            final group = state.tafsirGroups[index];
            return ResourceLanguageGroupCard(group: group, state: state);
          },
        );
      },
    );
  }
}
