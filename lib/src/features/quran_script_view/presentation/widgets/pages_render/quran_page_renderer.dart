import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_controller_ui_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/audio_player_position_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/domain/utils/segment_highlight_helper.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/reciter_cubit.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/models/script_info.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/tajweed_text_preser.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:dartx/dartx.dart";
import "package:material_ui/material_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuranPagesRenderer extends StatelessWidget {
  final bool isUthmani;
  final List<String> ayahsKey;
  final TextStyle baseTextStyle;
  final bool enableWordByWordHighlight;
  final bool tajweedColorEnable;

  const QuranPagesRenderer({
    super.key,
    required this.ayahsKey,
    required this.baseTextStyle,
    required this.isUthmani,
    required this.enableWordByWordHighlight,
    required this.tajweedColorEnable,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeState themeState = context.read<ThemeCubit>().state;
    final bool isDark = Theme.brightnessOf(context) == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: BlocBuilder<ReciterCubit, ReciterInfoModel>(
        builder: (context, reciterState) {
          final Map<String, List<List>> audioSegmentsMap = {};
          if (reciterState.hasWordSegments) {
            final reciterCubit = context.read<ReciterCubit>();
            for (final ayahKey in ayahsKey) {
              final segments = reciterCubit.getAyahSegments(ayahKey);
              if (segments != null) {
                audioSegmentsMap[ayahKey] = segments;
              }
            }
          }

          return BlocBuilder<AudioUiCubit, AudioControllerUiState>(
            buildWhen: (prev, curr) =>
                prev.isInsideQuranPlayer != curr.isInsideQuranPlayer,
            builder: (context, audioUiState) {
              return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
                buildWhen: (prev, curr) =>
                    prev.current != curr.current &&
                    (ayahsKey.contains(prev.current) ||
                        ayahsKey.contains(curr.current)),
                builder: (context, ayahKeyState) {
                  final String highlightingAyahKey = ayahKeyState.current;
                  final bool canWordHighlightPage =
                      enableWordByWordHighlight &&
                      audioUiState.isInsideQuranPlayer &&
                      ayahsKey.contains(highlightingAyahKey) &&
                      audioSegmentsMap.containsKey(highlightingAyahKey);

                  return BlocBuilder<
                    PlayerPositionCubit,
                    AudioPlayerPositionModel
                  >(
                    buildWhen: (previous, current) {
                      if (!canWordHighlightPage) return false;
                      final segments = audioSegmentsMap[highlightingAyahKey];
                      final prevWord = findActiveWordKeyForSegments(
                        currentAyahKey: highlightingAyahKey,
                        segments: segments,
                        position: previous.currentDuration,
                      );
                      final nextWord = findActiveWordKeyForSegments(
                        currentAyahKey: highlightingAyahKey,
                        segments: segments,
                        position: current.currentDuration,
                      );
                      return prevWord != nextWord;
                    },
                    builder: (context, positionState) {
                      final String? highlightingWord = canWordHighlightPage
                          ? findActiveWordKeyForSegments(
                              currentAyahKey: highlightingAyahKey,
                              segments: audioSegmentsMap[highlightingAyahKey],
                              position: positionState.currentDuration,
                            )
                          : null;

                      final quranViewState = context
                          .read<QuranViewCubit>()
                          .state;

                      return Text.rich(
                        TextSpan(
                          children: ayahsKey.map((ayahKey) {
                            final List words =
                                QuranScriptFunction.getWordListOfAyah(
                                  isUthmani
                                      ? QuranScriptType.uthmani
                                      : QuranScriptType.indopak,
                                  ayahKey.split(":").first,
                                  ayahKey.split(":").last,
                                  circleJojom: quranViewState.circleJojom,
                                );

                            final bool isAyahHighlighted =
                                audioUiState.isInsideQuranPlayer &&
                                highlightingAyahKey == ayahKey;

                            return TextSpan(
                              style: TextStyle(
                                backgroundColor: isAyahHighlighted
                                    ? (isDark
                                          ? Colors.white.withValues(alpha: 0.08)
                                          : Colors.black.withValues(
                                              alpha: 0.08,
                                            ))
                                    : null,
                              ),
                              children: List.generate(words.length, (index) {
                                final bool isWordHighlighted =
                                    enableWordByWordHighlight &&
                                    highlightingWord == "$ayahKey:${index + 1}";

                                return parseTajweedWord(
                                  wordIndex: index,
                                  baseStyle: TextStyle(
                                    fontSize: baseTextStyle.fontSize ?? 24,
                                    fontFamily:
                                        baseTextStyle.fontFamily ??
                                        "AlQuranNeov5x1",
                                    height: baseTextStyle.height,
                                    backgroundColor: isWordHighlighted
                                        ? themeState.primaryShade300
                                        : null,
                                  ),
                                  surahNumber: ayahKey.split(":").first.toInt(),
                                  ayahNumber: ayahKey.split(":").last.toInt(),
                                  skipWordTap: false,
                                  words: List<String>.from(words),
                                  context: context,
                                  tajweedColorEnable: tajweedColorEnable,
                                );
                              }),
                            );
                          }).toList(),
                        ),
                        style: TextStyle(
                          fontSize: baseTextStyle.fontSize ?? 24,
                          fontFamily:
                              baseTextStyle.fontFamily ??
                              (isUthmani
                                  ? quranViewState.uthmaniFontName
                                  : quranViewState.indopakFontName),
                          fontWeight: baseTextStyle.fontWeight,
                          height: baseTextStyle.height,
                          letterSpacing: 0,
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
