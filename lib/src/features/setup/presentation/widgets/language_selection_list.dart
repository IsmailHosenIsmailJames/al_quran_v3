import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_event.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class LanguageSelectionList extends StatefulWidget {
  final ScrollController scrollController;
  final double bottomPadding;

  const LanguageSelectionList({
    super.key,
    required this.scrollController,
    this.bottomPadding = 140.0,
  });

  @override
  State<LanguageSelectionList> createState() => _LanguageSelectionListState();
}

class _LanguageSelectionListState extends State<LanguageSelectionList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight + 8;

    final query = _searchQuery.trim().toLowerCase();
    final List<MyAppLocalization> filteredList = query.isEmpty
        ? usedAppLanguageMap
        : usedAppLanguageMap.where((appLoc) {
            return appLoc.english.toLowerCase().contains(query) ||
                appLoc.native.toLowerCase().contains(query) ||
                appLoc.locale.languageCode.toLowerCase().contains(query);
          }).toList();

    return BlocBuilder<LanguageCubit, MyAppLocalization>(
      builder: (context, currentLanguage) {
        return BlocBuilder<SetupBloc, SetupState>(
          builder: (context, setupState) {
            return ListView(
              controller: widget.scrollController,
              padding: EdgeInsets.fromLTRB(
                16,
                topPadding,
                16,
                widget.bottomPadding,
              ),
              children: [
                // 1. Spiritual Welcome Card (shown when not searching)
                if (query.isEmpty) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? themeState.primary.withValues(alpha: 0.08)
                          : themeState.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: themeState.primary.withValues(
                          alpha: isDark ? 0.2 : 0.12,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: themeState.primary,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          appLocalizations.selectAppLanguage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // 2. Search Field
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          "${appLocalizations.search} (e.g. English, বাংলা, العربية)...",
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                      prefixIcon: Icon(
                        FluentIcons.search_20_regular,
                        size: 20,
                        color: Theme.of(context).hintColor,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = "");
                              },
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      setState(() => _searchQuery = val);
                    },
                  ),
                ),

                // 3. Count indicator
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    query.isEmpty
                        ? "Languages (${usedAppLanguageMap.length})"
                        : "${filteredList.length} ${filteredList.length == 1 ? 'language' : 'languages'} found",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),

                // 4. Empty state or List of Languages
                if (filteredList.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(28),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 40,
                          color: Theme.of(
                            context,
                          ).hintColor.withValues(alpha: 0.5),
                        ),
                        const Gap(10),
                        Text(
                          "No languages found matching \"$_searchQuery\"",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(12),
                        TextButton.icon(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = "");
                          },
                          icon: const Icon(Icons.refresh_rounded, size: 16),
                          label: const Text("Show all languages"),
                        ),
                      ],
                    ),
                  )
                else
                  ...filteredList.map((appLoc) {
                    final langCode = appLoc.locale.languageCode;
                    final isSelected =
                        currentLanguage.locale.languageCode == langCode;
                    final hasTafsir = setupState.doesHaveTafsirSupport(
                      langCode,
                    );
                    final hasWordByWord = setupState.doesHaveWordByWord(
                      langCode,
                    );
                    final hasFootnote = setupState.doesHaveFootNote(langCode);
                    final hasBadges =
                        hasTafsir || hasWordByWord || hasFootnote;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: isSelected
                            ? themeState.primary.withValues(
                                alpha: isDark ? 0.14 : 0.05,
                              )
                            : (isDark
                                ? const Color(0xFF1E1E1E)
                                : Colors.white),
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            context.read<LanguageCubit>().changeLanguage(
                              appLoc,
                            );
                            context
                                .read<SetupBloc>()
                                .add(SetupLanguageChanged(appLoc));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? themeState.primary
                                    : (isDark
                                        ? Colors.white.withValues(alpha: 0.06)
                                        : Colors.grey.shade200),
                                width: isSelected ? 1.5 : 1.0,
                              ),
                              boxShadow: isDark || isSelected
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.02,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                            ),
                            child: Row(
                              children: [
                                // Selection Radio / Checkmark Indicator
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? themeState.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected
                                          ? themeState.primary
                                          : (isDark
                                              ? Colors.grey.shade600
                                              : Colors.grey.shade400),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          size: 14,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),

                                const Gap(12),

                                // Language Code Avatar Badge
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? themeState.primary
                                        : (isDark
                                            ? Colors.white.withValues(
                                                alpha: 0.06,
                                              )
                                            : Colors.grey.shade100),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    langCode.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : (isDark
                                              ? Colors.grey.shade300
                                              : Colors.grey.shade700),
                                    ),
                                  ),
                                ),

                                const Gap(12),

                                // Title Row & Feature Badges
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title Line: Native • English
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              appLoc.native,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.w600,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.grey.shade900,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (appLoc.native.toLowerCase() !=
                                              appLoc.english
                                                  .toLowerCase()) ...[
                                            const Gap(6),
                                            Text(
                                              "•  ${appLoc.english}",
                                              style: TextStyle(
                                                fontSize: 12.5,
                                                color: isDark
                                                    ? Colors.grey.shade400
                                                    : Colors.grey.shade600,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),

                                      // Badges Row using Wrap to completely prevent horizontal clipping
                                      if (hasBadges) ...[
                                        const Gap(6),
                                        Wrap(
                                          spacing: 5,
                                          runSpacing: 4,
                                          children: [
                                            if (hasTafsir)
                                              _buildFeatureBadge(
                                                context,
                                                icon: FluentIcons
                                                    .reading_list_24_regular,
                                                label: appLocalizations.tafsir,
                                                themeColor: themeState.primary,
                                                isDark: isDark,
                                              ),
                                            if (hasWordByWord)
                                              _buildFeatureBadge(
                                                context,
                                                icon: FluentIcons
                                                    .book_letter_24_regular,
                                                label: appLocalizations
                                                    .wordByWord,
                                                themeColor: themeState.primary,
                                                isDark: isDark,
                                              ),
                                            if (hasFootnote)
                                              _buildFeatureBadge(
                                                context,
                                                icon: FluentIcons
                                                    .note_20_regular,
                                                label:
                                                    appLocalizations.footnote,
                                                themeColor: themeState.primary,
                                                isDark: isDark,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFeatureBadge(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color themeColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: themeColor.withValues(alpha: isDark ? 0.14 : 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: themeColor.withValues(alpha: isDark ? 0.25 : 0.16),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: themeColor),
          const Gap(4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey.shade300 : themeColor,
            ),
          ),
        ],
      ),
    );
  }
}
