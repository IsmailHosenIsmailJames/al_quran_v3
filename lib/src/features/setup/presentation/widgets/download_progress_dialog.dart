import "dart:ui";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/download_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/download_state.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class DownloadProgressDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const DownloadProgressDialog({super.key, required this.onRetry});

  List<Map<String, String>> _getSetupStages(AppLocalizations loc) => [
        {
          "title": loc.translationDatabase,
          "subtitle": loc.translationDatabaseSubtitle,
        },
        {
          "title": loc.tafsirCommentary,
          "subtitle": loc.tafsirCommentarySubtitle,
        },
        {
          "title": loc.wordByWordAnalysis,
          "subtitle": loc.wordByWordAnalysisSubtitle,
        },
        {
          "title": loc.audioRecitationSegments,
          "subtitle": loc.audioRecitationSegmentsSubtitle,
        },
        {
          "title": loc.locationQiblaMetadata,
          "subtitle": loc.locationQiblaMetadataSubtitle,
        },
      ];

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    ThemeState themeState = context.read<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: (isDark ? Colors.grey.shade900 : Colors.white)
                    .withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: themeState.primaryShade200.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: themeState.primary.withValues(alpha: 0.15),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: BlocBuilder<DownloadCubit, DownloadState>(
                builder: (context, state) {
                  if (state.status == DownloadStatus.downloading) {
                    return _buildDownloadingContent(
                      context,
                      themeState,
                      appLocalizations,
                      state,
                    );
                  } else if (state.status == DownloadStatus.success) {
                    return _buildSuccessContent(
                      context,
                      themeState,
                      appLocalizations,
                    );
                  } else if (state.status == DownloadStatus.failure) {
                    return _buildFailureContent(
                      context,
                      themeState,
                      appLocalizations,
                      state,
                    );
                  }
                  return _buildInitialLoader(themeState);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadingContent(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    DownloadState state,
  ) {
    final perc = state.progress.percentage ?? 0.0;
    final displayPercentage = (perc * 100).clamp(0.0, 100.0);
    final activeIndex = state.progress.currentStepIndex;
    final setupStages = _getSetupStages(appLocalizations);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Glowing Icon & Title Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeState.primaryShade100,
                boxShadow: [
                  BoxShadow(
                    color: themeState.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                FluentIcons.arrow_download_24_filled,
                color: themeState.primary,
                size: 24,
              ),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.justAMoment,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    state.progress.stepName.isNotEmpty
                        ? state.progress.stepName
                        : appLocalizations.preparingResources,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                "${displayPercentage.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: themeState.primary,
                ),
              ),
            ),
          ],
        ),

        const Gap(20),

        // Animated Smooth Progress Bar
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: 0.0, end: perc),
          builder: (context, value, child) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: value > 0 ? value : null,
                    minHeight: 10,
                    backgroundColor: themeState.primaryShade100,
                    color: themeState.primary,
                  ),
                ),
              ],
            );
          },
        ),

        const Gap(22),

        // Step-by-Step Checklist View
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: List.generate(setupStages.length, (index) {
                final stage = setupStages[index];
                final isDone = index < activeIndex;
                final isActive = index == activeIndex;
                final isPending = index > activeIndex;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? themeState.primaryShade100.withValues(alpha: 0.5)
                        : (isDone
                            ? Colors.green.withValues(alpha: 0.05)
                            : Colors.transparent),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isActive
                          ? themeState.primaryShade300
                          : (isDone
                              ? Colors.green.withValues(alpha: 0.3)
                              : Colors.grey.withValues(alpha: 0.15)),
                      width: isActive ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Stage Status Icon
                      if (isDone)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 22,
                        )
                      else if (isActive)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: themeState.primary,
                          ),
                        )
                      else
                        Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.grey.shade400,
                          size: 22,
                        ),
                      const Gap(14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stage["title"]!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : (isDone
                                        ? FontWeight.w600
                                        : FontWeight.normal),
                                color: isPending
                                    ? Theme.of(context).hintColor
                                    : null,
                              ),
                            ),
                            const Gap(2),
                            Text(
                              isActive && state.progress.stepName.isNotEmpty
                                  ? state.progress.stepName
                                  : stage["subtitle"]!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessContent(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.shade50,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 54,
          ),
        ),
        const Gap(16),
        Text(
          appLocalizations.success,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Text(
          appLocalizations.setupCompletedOpeningQuran,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
        ),
      ],
    );
  }

  Widget _buildFailureContent(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    DownloadState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.shade50,
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
            size: 54,
          ),
        ),
        const Gap(16),
        Text(
          appLocalizations.unableToDownloadResources,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(8),
        Text(
          state.errorMessage ?? appLocalizations.unexpectedErrorSetup,
          style: TextStyle(fontSize: 13, color: Theme.of(context).hintColor),
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.refresh_rounded),
            label: Text(
              appLocalizations.retry,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialLoader(ThemeState themeState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [CircularProgressIndicator(color: themeState.primary)],
    );
  }
}
