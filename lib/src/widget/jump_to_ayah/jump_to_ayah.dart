import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../theme/controller/theme_cubit.dart";
import "../../theme/controller/theme_state.dart";

class JumpToAyahView extends StatefulWidget {
  final String? initAyahKey;
  final bool isAudioPlayer;
  final Function(String ayahKey)? onPlaySelected;
  final Function(String ayahKey)? onSelectAyah;

  const JumpToAyahView({
    super.key,
    this.initAyahKey,
    required this.isAudioPlayer,
    this.onPlaySelected,
    this.onSelectAyah,
  });

  @override
  State<JumpToAyahView> createState() => _JumpToAyahViewState();
}

class _JumpToAyahViewState extends State<JumpToAyahView> {
  late int? surahNumber = int.tryParse(widget.initAyahKey?.split(":")[0] ?? "");
  late int? ayahNumber = int.tryParse(widget.initAyahKey?.split(":")[1] ?? "");
  ScrollController surahScrollController = ScrollController();
  ScrollController ayahScrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  List<String> selectedAyahKeys = [];

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    final l10n = AppLocalizations.of(context); // Get AppLocalizations instance

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedRadius),
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.grey.shade100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(roundedRadius),
                topRight: Radius.circular(roundedRadius),
              ),
              color: themeState.primaryShade100,
            ),
            width: double.infinity,
            height: 50,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    l10n.jumpToAyahDialogTitle, // Localized text
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 15.0,
                          right: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(roundedRadius),
                          color: themeState.primaryShade100,
                        ),
                        child: TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            // Localized text
                            prefixIcon: const Icon(Icons.search),
                            hintText: l10n.jumpToAyahSearchSurahHint,
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: Scrollbar(
                          controller: surahScrollController,
                          interactive: true,
                          radius: Radius.circular(roundedRadius),
                          thickness: 10,
                          child: ListView.builder(
                            controller: surahScrollController,
                            itemCount: metaDataSurah.length,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              final surah = SurahInfoModel.fromMap(
                                metaDataSurah[(index + 1).toString()],
                              );
                              return surah.toJson().contains(
                                    textEditingController.text,
                                  )
                                  ? TextButton(
                                    style: TextButton.styleFrom(
                                      alignment: Alignment.centerLeft,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          roundedRadius,
                                        ),
                                      ),
                                      backgroundColor:
                                          index == (surahNumber ?? 0) - 1
                                              ? themeState.primary.withValues(
                                                alpha: 0.2,
                                              )
                                              : Colors.transparent,
                                      foregroundColor:
                                          Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        surahNumber = index + 1;
                                        ayahNumber = 1;
                                        textEditingController.text = "";
                                      });
                                    },
                                    child: Text(
                                      "${index + 1}. ${surah.nameSimple}",
                                    ),
                                  )
                                  : const SizedBox();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Scrollbar(
                    controller: ayahScrollController,
                    interactive: true,
                    radius: Radius.circular(roundedRadius),
                    thickness: 10,
                    child: ListView.builder(
                      controller: ayahScrollController,
                      padding: const EdgeInsets.all(10),

                      itemCount:
                          surahNumber != null
                              ? SurahInfoModel.fromMap(
                                metaDataSurah[surahNumber.toString()],
                              ).versesCount
                              : 0,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 35,
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,

                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  roundedRadius,
                                ),
                              ),
                              backgroundColor:
                                  (index == (ayahNumber ?? 0) - 1)
                                      ? themeState.primaryShade300
                                      : Colors.transparent,
                              foregroundColor:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                            ),
                            onPressed: () {
                              ayahNumber = index + 1;
                              setState(() {});
                            },
                            child: Text((index + 1).toString()),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.isAudioPlayer)
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
                top: 5,
              ),
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(roundedRadius),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  widget.onPlaySelected!("$surahNumber:$ayahNumber");
                },
                label: Text(l10n.jumpToAyahPlayButtonLabel), // Localized text
                icon: const Icon(Icons.play_circle_outline_rounded, size: 26),
              ),
            ),
        ],
      ),
    );
  }
}
