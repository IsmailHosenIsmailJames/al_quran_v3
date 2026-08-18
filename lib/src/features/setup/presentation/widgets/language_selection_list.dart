import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_event.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_state.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/setup_preview_card.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class LanguageSelectionList extends StatelessWidget {
  final ScrollController scrollController;
  final double bottomPadding;

  const LanguageSelectionList({
    super.key,
    required this.scrollController,
    this.bottomPadding = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top + 8;

    return BlocBuilder<LanguageCubit, MyAppLocalization>(
      builder: (context, currentLanguage) {
        return BlocBuilder<SetupBloc, SetupState>(
          builder: (context, setupState) {
            return ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.fromLTRB(16, topPadding, 16, bottomPadding),
              itemCount: usedAppLanguageMap.length,
              separatorBuilder: (context, index) => const Gap(8),
              itemBuilder: (context, index) {
                final MyAppLocalization appLoc = usedAppLanguageMap[index];
                final langCode = appLoc.locale.languageCode;
                final isSelected =
                    currentLanguage.locale.languageCode == langCode;

                return Material(
                  color: isSelected
                      ? themeState.primary.withValues(
                          alpha: isDark ? 0.14 : 0.05,
                        )
                      : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage(appLoc);
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
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                      ),
                      child: Row(
                        children: [
                          // Selection Indicator / Checkmark
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

                          // Language Code Avatar
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? themeState.primary
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.06)
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

                          // Title & Badges
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
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
                                ),
                                const Gap(4),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Text(
                                        appLoc.english,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDark
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade600,
                                        ),
                                      ),
                                      const Gap(6),
                                      if (setupState.doesHaveFootNote(langCode))
                                        getFeaturesMark(
                                          context,
                                          appLocalizations.footnote,
                                        ),
                                      if (setupState.doesHaveTafsirSupport(langCode))
                                        getFeaturesMark(
                                          context,
                                          appLocalizations.tafsir,
                                        ),
                                      if (setupState.doesHaveWordByWord(langCode))
                                        getFeaturesMark(
                                          context,
                                          appLocalizations.wordByWord,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
