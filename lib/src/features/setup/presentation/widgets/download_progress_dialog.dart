import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/download_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/download_state.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
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
    {"title": loc.tafsirCommentary, "subtitle": loc.tafsirCommentarySubtitle},
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
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
                blurRadius: 28,
                spreadRadius: 0,
                offset: const Offset(0, 8),
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
                  isDark,
                );
              } else if (state.status == DownloadStatus.success) {
                return _buildSuccessContent(
                  context,
                  themeState,
                  appLocalizations,
                  isDark,
                );
              } else if (state.status == DownloadStatus.failure) {
                return _buildFailureContent(
                  context,
                  themeState,
                  appLocalizations,
                  state,
                  isDark,
                );
              }
              return _buildInitialLoader(themeState);
            },
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
    bool isDark,
  ) {
    final perc = state.progress.percentage ?? 0.0;
    final displayPercentage = (perc * 100).clamp(0.0, 100.0);
    final activeIndex = state.progress.currentStepIndex;
    final setupStages = _getSetupStages(appLocalizations);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Icon & Title Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeState.primary.withValues(
                  alpha: isDark ? 0.18 : 0.1,
                ),
                border: Border.all(
                  color: themeState.primary.withValues(
                    alpha: isDark ? 0.3 : 0.15,
                  ),
                ),
              ),
              child: Icon(
                FluentIcons.arrow_download_24_filled,
                color: themeState.primary,
                size: 22,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.justAMoment,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                      color: isDark ? Colors.white : Colors.grey.shade900,
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
                      fontSize: 12.5,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: themeState.primary.withValues(
                  alpha: isDark ? 0.18 : 0.08,
                ),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: themeState.primary.withValues(
                    alpha: isDark ? 0.35 : 0.2,
                  ),
                ),
              ),
              child: Text(
                "${displayPercentage.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: themeState.primary,
                ),
              ),
            ),
          ],
        ),

        const Gap(16),

        // Animated Smooth Progress Bar
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: 0.0, end: perc),
          builder: (context, value, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value > 0 ? value : null,
                minHeight: 7,
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade100,
                color: themeState.primary,
              ),
            );
          },
        ),

        const Gap(16),

        // Step-by-Step Checklist View
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: List.generate(setupStages.length, (index) {
                final stage = setupStages[index];
                final isDone = index < activeIndex;
                final isActive = index == activeIndex;

                Color itemBg;
                Color itemBorder;
                if (isActive) {
                  itemBg = themeState.primary.withValues(
                    alpha: isDark ? 0.14 : 0.06,
                  );
                  itemBorder = themeState.primary.withValues(
                    alpha: isDark ? 0.4 : 0.25,
                  );
                } else if (isDone) {
                  itemBg = isDark
                      ? const Color(0xFF16A34A).withValues(alpha: 0.08)
                      : const Color(0xFF16A34A).withValues(alpha: 0.05);
                  itemBorder = isDark
                      ? const Color(0xFF16A34A).withValues(alpha: 0.25)
                      : const Color(0xFF16A34A).withValues(alpha: 0.2);
                } else {
                  itemBg = isDark
                      ? Colors.white.withValues(alpha: 0.02)
                      : Colors.grey.shade50;
                  itemBorder = isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.shade200;
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: itemBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: itemBorder,
                      width: isActive ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Stage Status Icon
                      if (isDone)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF16A34A),
                          size: 20,
                        )
                      else if (isActive)
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: themeState.primary,
                          ),
                        )
                      else
                        Icon(
                          Icons.radio_button_unchecked,
                          color: isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                          size: 20,
                        ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stage["title"]!,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: isActive || isDone
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isActive
                                    ? themeState.primary
                                    : (isDone
                                        ? (isDark
                                            ? Colors.white
                                            : Colors.grey.shade900)
                                        : (isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600)),
                              ),
                            ),
                            const Gap(1),
                            Text(
                              isActive && state.progress.stepName.isNotEmpty
                                  ? state.progress.stepName
                                  : stage["subtitle"]!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
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
    bool isDark,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF16A34A).withValues(
              alpha: isDark ? 0.2 : 0.1,
            ),
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF16A34A),
            size: 48,
          ),
        ),
        const Gap(16),
        Text(
          appLocalizations.success,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
        const Gap(8),
        Text(
          appLocalizations.setupCompletedOpeningQuran,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFailureContent(
    BuildContext context,
    ThemeState themeState,
    AppLocalizations appLocalizations,
    DownloadState state,
    bool isDark,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFDC2626).withValues(
              alpha: isDark ? 0.2 : 0.1,
            ),
          ),
          child: const Icon(
            Icons.error_outline_rounded,
            color: Color(0xFFDC2626),
            size: 48,
          ),
        ),
        const Gap(16),
        Text(
          appLocalizations.unableToDownloadResources,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFFDC2626),
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(8),
        Text(
          state.errorMessage ?? appLocalizations.unexpectedErrorSetup,
          style: TextStyle(
            fontSize: 12.5,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: themeState.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.refresh_rounded, size: 20),
            label: Text(
              appLocalizations.retry,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
