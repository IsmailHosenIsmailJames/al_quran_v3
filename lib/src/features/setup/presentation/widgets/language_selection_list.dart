import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_event.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_state.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/setup_preview_card.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class LanguageSelectionList extends StatelessWidget {
  final ScrollController scrollController;

  const LanguageSelectionList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    ThemeState themeState = context.read<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top + 8;

    return BlocBuilder<LanguageCubit, MyAppLocalization>(
      builder: (context, currentLanguage) {
        return BlocBuilder<SetupBloc, SetupState>(
          builder: (context, setupState) {
            return RadioGroup<MyAppLocalization>(
              groupValue: currentLanguage,
              onChanged: (value) {
                if (value != null) {
                  context.read<LanguageCubit>().changeLanguage(value);
                  context.read<SetupBloc>().add(SetupLanguageChanged(value));
                }
              },
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(top: topPadding, bottom: 12),
                itemCount: usedAppLanguageMap.length,
                itemBuilder: (context, index) {
                  final MyAppLocalization appLoc = usedAppLanguageMap[index];
                  final langCode = appLoc.locale.languageCode;
                  final isSelected =
                      currentLanguage.locale.languageCode == langCode;

                  final tileBg = isSelected
                      ? themeState.primary.withValues(
                          alpha: isDark ? 0.12 : 0.06,
                        )
                      : Colors.transparent;

                  final tileBorder = isSelected
                      ? themeState.primary.withValues(alpha: 0.4)
                      : (isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.grey.shade200);

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: tileBorder, width: 1),
                    ),
                    child: Material(
                      color: tileBg,
                      borderRadius: BorderRadius.circular(14),
                      clipBehavior: Clip.antiAlias,
                      child: RadioListTile<MyAppLocalization>(
                        value: appLoc,
                        selected: isSelected,
                        activeColor: themeState.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        title: Text(
                          appLoc.native,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  appLoc.english,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context).hintColor,
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
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
