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
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class QuranScriptScriptView extends StatelessWidget {
  final bool isUthmani;
  final ScriptInfo scriptInfo;
  final ThemeState themeState;
  final bool tajweedColorEnable;
  final bool? showBottomsheetOnTap;

  const QuranScriptScriptView({
    super.key,
    required this.scriptInfo,
    required this.isUthmani,
    required this.themeState,
    required this.tajweedColorEnable,
    this.showBottomsheetOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final quranViewState = context.watch<QuranViewCubit>().state;
    List words = QuranScriptFunction.getWordListOfAyah(
      isUthmani ? QuranScriptType.uthmani : QuranScriptType.indopak,
      scriptInfo.surahNumber.toString(),
      scriptInfo.ayahNumber.toString(),
      circleJojom: quranViewState.circleJojom,
    );
    if (scriptInfo.limitWord != null) {
      if (!(scriptInfo.limitWord! >= words.length)) {
        words = words.sublist(0, scriptInfo.limitWord);
      }
    }
    final TextStyle quranStyle = TextStyle(
      fontSize: scriptInfo.textStyle?.fontSize ?? 24,
      height: scriptInfo.textStyle?.height ?? 2,
      fontFamily: isUthmani
          ? quranViewState.uthmaniFontName
          : quranViewState.indopakFontName,
      letterSpacing: 0,
    );

    if (scriptInfo.wordIndex != null) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        textAlign: scriptInfo.textAlign,
        parseTajweedWord(
          wordIndex: scriptInfo.wordIndex,
          words: List<String>.from(words),
          baseStyle: quranStyle,
          context: context,
          surahNumber: scriptInfo.surahNumber,
          ayahNumber: scriptInfo.ayahNumber,
          skipWordTap:
              showBottomsheetOnTap ?? (scriptInfo.skipWordTap ?? false),
          tajweedColorEnable: tajweedColorEnable,
        ),
      );
    }

    if (scriptInfo.forImage == true || scriptInfo.showWordHighlights == false) {
      return Text.rich(
        style: quranStyle,
        textDirection: TextDirection.rtl,
        textAlign: scriptInfo.textAlign,
        TextSpan(
          children: List<InlineSpan>.generate(words.length, (index) {
            return parseTajweedWord(
              wordIndex: index,
              words: List<String>.from(words),
              baseStyle: quranStyle,
              context: context,
              surahNumber: scriptInfo.surahNumber,
              ayahNumber: scriptInfo.ayahNumber,
              skipWordTap:
                  showBottomsheetOnTap ?? (scriptInfo.skipWordTap ?? false),
              tajweedColorEnable: tajweedColorEnable,
            );
          }),
        ),
      );
    }

    final String ayahKey = "${scriptInfo.surahNumber}:${scriptInfo.ayahNumber}";
    final bool enableWordByWordHighlight =
        quranViewState.enableWordByWordHighlight;

    return BlocBuilder<ReciterCubit, ReciterInfoModel>(
      builder: (context, reciterState) {
        final List<List>? segments = reciterState.hasWordSegments
            ? context.read<ReciterCubit>().getAyahSegments(ayahKey)
            : null;

        return BlocBuilder<AudioUiCubit, AudioControllerUiState>(
          buildWhen: (prev, curr) =>
              prev.isInsideQuranPlayer != curr.isInsideQuranPlayer,
          builder: (context, audioUiState) {
            return BlocBuilder<AyahKeyCubit, AyahKeyManagement>(
              buildWhen: (prev, curr) =>
                  prev.current != curr.current &&
                  (prev.current == ayahKey || curr.current == ayahKey),
              builder: (context, ayahKeyState) {
                final bool canWordHighlight =
                    enableWordByWordHighlight &&
                    audioUiState.isInsideQuranPlayer &&
                    ayahKeyState.current == ayahKey &&
                    segments != null;

                return BlocBuilder<PlayerPositionCubit,
                    AudioPlayerPositionModel>(
                  buildWhen: (previous, current) {
                    if (!canWordHighlight) return false;
                    final prevWord = findActiveWordKeyForSegments(
                      currentAyahKey: ayahKey,
                      segments: segments,
                      position: previous.currentDuration,
                    );
                    final nextWord = findActiveWordKeyForSegments(
                      currentAyahKey: ayahKey,
                      segments: segments,
                      position: current.currentDuration,
                    );
                    return prevWord != nextWord;
                  },
                  builder: (context, positionState) {
                    final String? highlightingWordIndex = canWordHighlight
                        ? findActiveWordKeyForSegments(
                            currentAyahKey: ayahKey,
                            segments: segments,
                            position: positionState.currentDuration,
                          )
                        : null;

                    return Text.rich(
                      style: quranStyle,
                      textDirection: TextDirection.rtl,
                      textAlign: scriptInfo.textAlign,
                      TextSpan(
                        children: List<InlineSpan>.generate(words.length, (
                          index,
                        ) {
                          final bool willHighLight =
                              highlightingWordIndex == "$ayahKey:${index + 1}";

                          return parseTajweedWord(
                            wordIndex: index,
                            words: List<String>.from(words),
                            baseStyle: quranStyle.copyWith(
                              backgroundColor: willHighLight
                                  ? themeState.primaryShade200
                                  : null,
                            ),
                            context: context,
                            surahNumber: scriptInfo.surahNumber,
                            ayahNumber: scriptInfo.ayahNumber,
                            skipWordTap:
                                showBottomsheetOnTap ??
                                (scriptInfo.skipWordTap ?? false),
                            tajweedColorEnable: tajweedColorEnable,
                          );
                        }),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
