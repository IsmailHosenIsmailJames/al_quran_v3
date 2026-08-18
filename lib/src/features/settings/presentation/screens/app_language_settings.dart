import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class AppLanguageSettings extends StatefulWidget {
  const AppLanguageSettings({super.key});

  @override
  State<AppLanguageSettings> createState() => _AppLanguageSettingsState();
}

class _AppLanguageSettingsState extends State<AppLanguageSettings> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final query = _searchController.text.trim().toLowerCase();

    final filteredLanguages = usedAppLanguageMap.where((lang) {
      if (query.isEmpty) return true;
      return lang.english.toLowerCase().contains(query) ||
          lang.native.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.languageSettings,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<LanguageCubit, MyAppLocalization>(
        builder: (context, currentLanguage) {
          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: l10n.selectAppLanguage,
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade400,
                      ),
                      prefixIcon: Icon(
                        FluentIcons.search_20_regular,
                        size: 18,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                      suffixIcon: query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                FluentIcons.dismiss_circle_20_filled,
                                size: 16,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 11,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),

              const Gap(4),

              // Language List
              Expanded(
                child: filteredLanguages.isEmpty
                    ? Center(
                        child: Text(
                          "No languages found",
                          style: TextStyle(
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                        itemCount: filteredLanguages.length,
                        separatorBuilder: (context, index) => const Gap(8),
                        itemBuilder: (context, index) {
                          final lang = filteredLanguages[index];
                          final isSelected = currentLanguage.locale.languageCode ==
                              lang.locale.languageCode;

                          return Material(
                            color: isSelected
                                ? themeState.primary.withValues(
                                    alpha: isDark ? 0.15 : 0.06,
                                  )
                                : (isDark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                context.read<LanguageCubit>().changeLanguage(lang);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
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
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? themeState.primary
                                            : (isDark
                                                ? Colors.white.withValues(
                                                    alpha: 0.08,
                                                  )
                                                : Colors.grey.shade100),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        lang.locale.languageCode.toUpperCase(),
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
                                    const Gap(14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lang.native,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.w600,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.grey.shade900,
                                            ),
                                          ),
                                          const Gap(2),
                                          Text(
                                            lang.english,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark
                                                  ? Colors.grey.shade400
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        FluentIcons.checkmark_circle_24_filled,
                                        color: themeState.primary,
                                        size: 22,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
