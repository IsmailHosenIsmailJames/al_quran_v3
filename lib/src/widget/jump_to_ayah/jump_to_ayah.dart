import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class JumpToAyahView extends StatefulWidget {
  final String initAyahKey;
  final bool isAudioPlayer;
  final Function(String ayahKey)? onPlaySelected;

  const JumpToAyahView({
    super.key,
    required this.initAyahKey,
    required this.isAudioPlayer,
    this.onPlaySelected,
  });

  @override
  State<JumpToAyahView> createState() => _JumpToAyahViewState();
}

class _JumpToAyahViewState extends State<JumpToAyahView> {
  late int surahNumber = int.parse(widget.initAyahKey.split(":")[0]);
  late int ayahNumber = int.parse(widget.initAyahKey.split(":")[1]);
  ScrollController surahScrollController = ScrollController();
  ScrollController ayahScrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
            ),
            width: double.infinity,
            height: 50,
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    "Jump To Ayah",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                        ),
                        child: TextFormField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search for a surah",
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
                          radius: const Radius.circular(10),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor:
                                          index == surahNumber - 1
                                              ? AppColors.primaryColor
                                                  .withValues(alpha: 0.2)
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
                const VerticalDivider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Scrollbar(
                    controller: ayahScrollController,
                    interactive: true,
                    radius: const Radius.circular(10),
                    thickness: 10,
                    child: ListView.builder(
                      controller: ayahScrollController,
                      padding: const EdgeInsets.all(10),

                      itemCount:
                          SurahInfoModel.fromMap(
                            metaDataSurah[surahNumber.toString()],
                          ).versesCount,
                      itemBuilder: (context, index) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor:
                                index == ayahNumber - 1
                                    ? AppColors.primaryColor.withValues(
                                      alpha: 0.2,
                                    )
                                    : Colors.transparent,
                            foregroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              ayahNumber = index + 1;
                            });
                          },
                          child: Text((index + 1).toString()),
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
                onPressed: () {
                  Navigator.pop(context);
                  widget.onPlaySelected!("$surahNumber:$ayahNumber");
                },
                label: const Text("Play From Selected Ayah"),
                icon: const Icon(Icons.play_circle_outline_rounded, size: 26),
              ),
            ),
          if (!widget.isAudioPlayer)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Jump to Tafsir"),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Jump to Ayah"),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
