import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resource_language_group_card.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/widgets/resources_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TranslationResourcesTab extends StatelessWidget {
  const TranslationResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranResourcesCubit, QuranResourcesState>(
      builder: (context, state) {
        if (state.status == QuranResourcesStatus.loading &&
            state.translationGroups.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.translationGroups.isEmpty) {
          return ResourcesEmptyState(query: state.searchQuery);
        }

        return ListView.builder(
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 60,
            bottom: 24,
            left: 12,
            right: 12,
          ),
          itemCount: state.translationGroups.length,
          itemBuilder: (context, index) {
            final group = state.translationGroups[index];
            return ResourceLanguageGroupCard(group: group, state: state);
          },
        );
      },
    );
  }
}
