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
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          );
        }

        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: searchController,
          builder: (context, value, child) {
            return TextField(
              controller: searchController,
              autofocus: true,
              onChanged: (val) => cubit.setSearchQuery(val),
              decoration: InputDecoration(
                hintText: "${appLocalizations.search}...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.45),
                  fontSize: 16,
                ),
                suffixIcon: value.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 20),
                        onPressed: () {
                          searchController.clear();
                          cubit.setSearchQuery('');
                        },
                      )
                    : null,
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            );
          },
        );
      },
    );
  }
}

