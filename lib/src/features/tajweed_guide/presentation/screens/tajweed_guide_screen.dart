import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../cubit/tajweed_guide_cubit.dart";
import "../cubit/tajweed_guide_state.dart";
import "../widgets/tajweed_rule_card.dart";

class TajweedGuideScreen extends StatelessWidget {
  const TajweedGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TajweedGuideCubit>()..loadTajweedRules(),
      child: const TajweedGuideView(),
    );
  }
}

class TajweedGuideView extends StatefulWidget {
  const TajweedGuideView({super.key});

  @override
  State<TajweedGuideView> createState() => _TajweedGuideViewState();
}

class _TajweedGuideViewState extends State<TajweedGuideView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.tajweedGuide),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Field & Filter header
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<TajweedGuideCubit>().filterRules(value);
              },
              decoration: InputDecoration(
                hintText: "Search Tajweed rules...",
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          context.read<TajweedGuideCubit>().filterRules("");
                        },
                      )
                    : null,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Body Content
          Expanded(
            child: BlocBuilder<TajweedGuideCubit, TajweedGuideState>(
              builder: (context, state) {
                if (state is TajweedGuideLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TajweedGuideError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 12),
                        Text(state.message),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TajweedGuideCubit>().loadTajweedRules();
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                } else if (state is TajweedGuideLoaded) {
                  if (state.filteredRules.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No Tajweed rules found",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    itemCount: state.filteredRules.length,
                    itemBuilder: (context, index) {
                      final rule = state.filteredRules[index];
                      return TajweedRuleCard(
                        rule: rule,
                        isInitiallyExpanded: false,
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
