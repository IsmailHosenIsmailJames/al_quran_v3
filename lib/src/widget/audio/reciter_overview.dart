import "package:al_quran_v3/src/core/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:url_launcher/url_launcher.dart";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "../../core/audio/player/audio_player_manager.dart";
import "../../utils/basic_functions.dart";
import "../../screen/audio/change_reciter/popup_change_reciter.dart";
import "../../screen/audio/cubit/audio_tab_screen_cubit.dart";
import "../../theme/values/values.dart";

Widget getReciterWidget({
  required ReciterInfoModel audioTabScreenState,
  required BuildContext context,
  AyahKeyManagement? ayahKeyState,
  Function(ReciterInfoModel reciterInfoModel)? onReciterChanged,
  int? currentIndex,
  bool? isWordByWord,
}) {
  AppLocalizations l10n = AppLocalizations.of(context);
  return InkWell(
    borderRadius: BorderRadius.circular(roundedRadius),
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

    child: Row(
      children: [
        SizedBox(
          height: 100,
          width: 80,
          child:
              audioTabScreenState.img != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(roundedRadius),
                    child: CachedNetworkImage(
                      imageUrl: audioTabScreenState.img!,
                      errorWidget:
                          (context, url, error) => const Icon(
                            FluentIcons.person_24_regular,
                            size: 60,
                            color: Colors.grey,
                          ),
                      progressIndicatorBuilder:
                          (context, url, progress) => Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              backgroundColor:
                                  context
                                      .read<ThemeCubit>()
                                      .state
                                      .primaryShade100,
                            ),
                          ),
                      fit: BoxFit.cover,
                    ),
                  )
                  : const Icon(
                    FluentIcons.person_24_regular,
                    size: 60,
                    color: Colors.grey,
                  ),
        ),
        const Gap(10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  safeSubString(audioTabScreenState.name, 20, replacer: "..."),
                  style: const TextStyle(fontSize: 16),
                ),
                const Gap(5),
                const Icon(Icons.arrow_drop_down_rounded, size: 30),
              ],
            ),
            Text(l10n.style(audioTabScreenState.style ?? "")),
            Text(l10n.source(audioTabScreenState.source ?? "")),
            if (audioTabScreenState.bio != null)
              Row(
                children: [
                  Text(l10n.more),
                  SizedBox(
                    height: 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        launchUrl(
                          Uri.parse(audioTabScreenState.bio!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Text(Uri.parse(audioTabScreenState.bio!).host),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}
