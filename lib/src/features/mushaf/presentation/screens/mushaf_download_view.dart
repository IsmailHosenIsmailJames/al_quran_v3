import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_state.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/widgets/mushaf_feature_card.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:shimmer/shimmer.dart";

/// Modern, clean, fully-localized Mushaf download and overview screen.
class MushafDownloadView extends StatelessWidget {
  const MushafDownloadView({super.key});

  static const String _previewImageUrl =
      "https://github.com/IsmailHosenIsmailJames/al_quran_mushaf/releases/download/v1.0.0/WhatsApp.Image.2026-02-20.at.16.11.16.jpeg";

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.mushaf,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<MushafCubit, MushafState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Preview Card
                _buildHeroCard(context, isDark, themeState, l10n),
                const Gap(18),

                // Feature Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    const MushafInfoBadge(
                      icon: FluentIcons.book_24_regular,
                      label: "KFGQPC V4",
                    ),
                    MushafInfoBadge(
                      icon: FluentIcons.document_text_24_regular,
                      label: l10n.madani15Line,
                    ),
                    MushafInfoBadge(
                      icon: FluentIcons.book_open_24_regular,
                      label: l10n.totalPagesCount,
                    ),
                    MushafInfoBadge(
                      icon: FluentIcons.speaker_2_24_regular,
                      label: l10n.wordAudio,
                    ),
                    MushafInfoBadge(
                      icon: FluentIcons.arrow_download_24_regular,
                      label: l10n.offlineReady,
                    ),
                    MushafInfoBadge(
                      icon: FluentIcons.text_font_24_regular,
                      label: l10n.vectorFonts,
                    ),
                  ],
                ),
                const Gap(24),

                // Download / Progress Action Section
                _buildDownloadSection(context, state, isDark, themeState, l10n),
                const Gap(24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(
    BuildContext context,
    bool isDark,
    dynamic themeState,
    AppLocalizations l10n,
  ) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 260),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: _previewImageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor:
                    isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                highlightColor:
                    isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                child: Container(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                child: Center(
                  child: Icon(
                    FluentIcons.book_open_48_regular,
                    size: 56,
                    color: themeState.primary.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            // Banner Title Overlay
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.madaniMushafLayout,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    l10n.kfgqpcDescription,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadSection(
    BuildContext context,
    MushafState state,
    bool isDark,
    dynamic themeState,
    AppLocalizations l10n,
  ) {
    if (state.isDownloading || state.isExtracting) {
      final percentage = (state.downloadProgress * 100).toStringAsFixed(1);
      final isExtracting = state.isExtracting;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: themeState.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: state.downloadProgress > 0
                        ? state.downloadProgress
                        : null,
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      themeState.primary,
                    ),
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isExtracting
                            ? l10n.extractingAndInstallingData
                            : l10n.downloadingMushafPackage,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        state.downloadStatus.isNotEmpty
                            ? state.downloadStatus
                            : (isExtracting
                                ? l10n.settingUpOfflinePages
                                : l10n.fetchingLayoutArchive),
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
                Text(
                  "$percentage%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeState.primary,
                  ),
                ),
              ],
            ),
            const Gap(16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: state.downloadProgress > 0
                    ? state.downloadProgress
                    : null,
                minHeight: 8,
                backgroundColor:
                    themeState.primary.withValues(alpha: isDark ? 0.15 : 0.1),
                valueColor:
                    AlwaysStoppedAnimation<Color>(themeState.primary),
              ),
            ),
            const Gap(10),
            Text(
              l10n.keepAppOpenDuringDownload,
              style: TextStyle(
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state.hasError) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: isDark ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(FluentIcons.warning_24_regular,
                    color: Colors.red, size: 24),
                const Gap(12),
                Expanded(
                  child: Text(
                    l10n.downloadFailed,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              state.errorMessage.isNotEmpty
                  ? state.errorMessage
                  : state.downloadStatus,
              style: TextStyle(
                fontSize: 12.5,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const Gap(14),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeState.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.read<MushafCubit>().downloadMushaf();
                },
                icon: const Icon(FluentIcons.arrow_clockwise_24_regular,
                    size: 18),
                label: Text(
                  l10n.retryDownload,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Default Idle State
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.packageSize,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color:
                      isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: themeState.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "~55 MB",
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: themeState.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeState.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                context.read<MushafCubit>().downloadMushaf();
              },
              icon: const Icon(FluentIcons.arrow_download_24_filled, size: 20),
              label: Text(
                "${l10n.download} ${l10n.mushaf}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
