import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_tab_screen_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/widgets/popup_change_reciter.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:url_launcher/url_launcher.dart";

Widget getReciterWidget({
  required ReciterInfoModel audioTabScreenState,
  required BuildContext context,
  AyahKeyManagement? ayahKeyState,
  Function(ReciterInfoModel reciterInfoModel)? onReciterChanged,
  int? currentIndex,
  bool? isWordByWord,
}) {
  final AppLocalizations l10n = AppLocalizations.of(context);
  final theme = Theme.of(context);
  final themeState = context.read<ThemeCubit>().state;
  final isDark = theme.brightness == Brightness.dark;

  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(roundedRadius + 4),
      onTap: () {
        popupChangeReciter(
          context,
          audioTabScreenState,
          onReciterChanged ??
              (ReciterInfoModel reciterInfoModel) async {
                context.read<AudioTabReciterCubit>().changeReciter(
                  reciterInfoModel,
                );
                if (ayahKeyState != null) {
                  AudioPlayerManager.playMultipleAyahAsPlaylist(
                    startAyahKey: ayahKeyState.ayahList.first,
                    endAyahKey: ayahKeyState.ayahList.last,
                    isInsideQuran: false,
                    reciterInfoModel: reciterInfoModel,
                    initialIndex: currentIndex ?? 0,
                    instantPlay: AudioPlayerManager.audioPlayer.playing,
                  );
                }
                Navigator.pop(context);
              },
          isWordByWord: isWordByWord,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(roundedRadius + 4),
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : themeState.primaryShade100.withValues(alpha: 0.45),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : themeState.primary.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            // Reciter Avatar
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(roundedRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(roundedRadius),
                child: audioTabScreenState.img != null
                    ? CachedNetworkImage(
                        imageUrl: audioTabScreenState.img!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          color: isDark
                              ? Colors.grey.shade800
                              : themeState.primaryShade100,
                          child: Icon(
                            FluentIcons.person_24_filled,
                            size: 36,
                            color: themeState.primary,
                          ),
                        ),
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              strokeWidth: 2,
                              color: themeState.primary,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: isDark
                            ? Colors.grey.shade800
                            : themeState.primaryShade100,
                        child: Icon(
                          FluentIcons.person_24_filled,
                          size: 36,
                          color: themeState.primary,
                        ),
                      ),
              ),
            ),
            const Gap(14),
            // Details
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          audioTabScreenState.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeState.primary.withValues(alpha: 0.1),
                        ),
                        child: Icon(
                          Icons.expand_more_rounded,
                          size: 18,
                          color: themeState.primary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      if (audioTabScreenState.style != null &&
                          audioTabScreenState.style!.isNotEmpty)
                        _buildBadge(
                          context,
                          label: l10n.style(audioTabScreenState.style!),
                          icon: FluentIcons.music_note_2_16_regular,
                        ),
                      if (audioTabScreenState.source != null &&
                          audioTabScreenState.source!.isNotEmpty)
                        _buildBadge(
                          context,
                          label: l10n.source(audioTabScreenState.source!),
                          icon: FluentIcons.globe_16_regular,
                        ),
                      if (audioTabScreenState.segmentsUrl != null)
                        _buildBadge(
                          context,
                          label: "Word-by-Word",
                          isAccent: true,
                          icon: FluentIcons.text_bullet_list_square_16_regular,
                        ),
                    ],
                  ),
                  if (audioTabScreenState.bio != null) ...[
                    const Gap(6),
                    InkWell(
                      onTap: () {
                        launchUrl(
                          Uri.parse(audioTabScreenState.bio!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FluentIcons.open_16_regular,
                            size: 13,
                            color: themeState.primary,
                          ),
                          const Gap(4),
                          Text(
                            Uri.parse(audioTabScreenState.bio!).host,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: themeState.primary,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildBadge(
  BuildContext context, {
  required String label,
  IconData? icon,
  bool isAccent = false,
}) {
  final themeState = context.read<ThemeCubit>().state;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  final bgColor = isAccent
      ? themeState.primary.withValues(alpha: isDark ? 0.25 : 0.15)
      : isDark
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.black.withValues(alpha: 0.05);

  final fgColor = isAccent
      ? themeState.primary
      : isDark
          ? Colors.grey.shade300
          : Colors.grey.shade800;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(6),
      border: isAccent
          ? Border.all(color: themeState.primary.withValues(alpha: 0.3))
          : null,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 11, color: fgColor),
          const Gap(4),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isAccent ? FontWeight.w600 : FontWeight.w500,
            color: fgColor,
          ),
        ),
      ],
    ),
  );
}
