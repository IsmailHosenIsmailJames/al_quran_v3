import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../theme/controller/theme_cubit.dart";
import "../../../theme/controller/theme_state.dart";

class ChangeReciter extends StatefulWidget {
  final ReciterInfoModel initReciterIndex;
  final bool? isWordByWord;
  final Function(ReciterInfoModel index) onReciterChanged;
  const ChangeReciter({
    super.key,
    required this.initReciterIndex,
    required this.onReciterChanged,
    this.isWordByWord,
  });

  @override
  State<ChangeReciter> createState() => _ChangeReciterState();
}

class _ChangeReciterState extends State<ChangeReciter> {
  ScrollController scrollController = ScrollController();
  late ReciterInfoModel selectedReciter = widget.initReciterIndex;

  late List<ReciterInfoModel> recitersListCurrent;

  @override
  void initState() {
    if (widget.isWordByWord == true) {
      recitersListCurrent =
          recitationsInfoList
              .map((e) => ReciterInfoModel.fromMap(e))
              .toList()
              .where((element) => element.segmentsUrl != null)
              .toList();
    } else {
      recitersListCurrent =
          recitationsInfoList.map((e) => ReciterInfoModel.fromMap(e)).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    final l10n = AppLocalizations.of(context); // Get AppLocalizations instance

    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: themeState.primaryShade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(roundedRadius),
              topRight: Radius.circular(roundedRadius),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  l10n.changeReciterTitle, // Localized title
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recitersListCurrent.length,
            controller: scrollController,
            padding: const EdgeInsets.all(5),
            itemBuilder: (context, index) {
              ReciterInfoModel reciterInfoModel = recitersListCurrent[index];
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:
                      selectedReciter.link == reciterInfoModel.link
                          ? themeState.primaryShade100
                          : null,
                  border:
                      selectedReciter.link == reciterInfoModel.link
                          ? Border.all(color: themeState.primary)
                          : null,
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedReciter = reciterInfoModel;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Container(
                        height: 85,
                        width: 65,
                        decoration: BoxDecoration(
                          color: themeState.primaryShade100,
                          borderRadius: BorderRadius.circular(roundedRadius),
                        ),
                        child:
                            reciterInfoModel.img != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    roundedRadius,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: reciterInfoModel.img!,
                                    errorWidget:
                                        (context, url, error) => const Icon(
                                          FluentIcons.person_24_filled,
                                          size: 36,
                                          color: Colors.grey,
                                        ),
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : null,
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            safeSubString(
                              reciterInfoModel.name,
                              25,
                              replacer: "...",
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            l10n.reciterStyleLabel(
                              reciterInfoModel.style.toString(),
                            ),
                          ), // Localized Style
                          Text(
                            l10n.reciterSourceLabel(
                              reciterInfoModel.source.toString(),
                            ),
                          ), // Localized Source
                          if (reciterInfoModel.bio != null)
                            Row(
                              children: [
                                Text(
                                  l10n.reciterMoreInfoLabel,
                                ), // Localized More
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
                                        Uri.parse(reciterInfoModel.bio!),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    child: Text(
                                      Uri.parse(reciterInfoModel.bio!).host,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
            ),
            onPressed: () {
              widget.onReciterChanged(selectedReciter);
            },
            icon: const Icon(Icons.done),
            label: Text(l10n.saveButtonLabel), // Localized Save
          ),
        ),
      ],
    );
  }
}
