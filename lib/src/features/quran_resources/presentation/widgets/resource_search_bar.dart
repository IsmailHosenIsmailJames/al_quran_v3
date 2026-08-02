import 'package:al_quran_v3/l10n/app_localizations.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResourceSearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const ResourceSearchBar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final cubit = context.read<QuranResourcesCubit>();

    return BlocBuilder<QuranResourcesCubit, QuranResourcesState>(
      buildWhen: (p, c) => p.isSearching != c.isSearching,
      builder: (context, state) {
        if (!state.isSearching) {
          return Text(
            appLocalizations.quranResources,
            style: const TextStyle(fontWeight: FontWeight.w600),
          );
        }

        return TextField(
          controller: searchController,
          autofocus: true,
          onChanged: (val) => cubit.setSearchQuery(val),
          decoration: InputDecoration(
            hintText: appLocalizations.search,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
      },
    );
  }
}
