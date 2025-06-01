import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/audio/resources/recitations.dart";
import "package:al_quran_v3/src/functions/basic_functions.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

class ChangeReciter extends StatefulWidget {
  final int initReciterIndex;
  final Function(int index) onReciterChanged;
  const ChangeReciter({
    super.key,
    required this.initReciterIndex,
    required this.onReciterChanged,
  });

  @override
  State<ChangeReciter> createState() => _ChangeReciterState();
}

class _ChangeReciterState extends State<ChangeReciter> {
  ScrollController scrollController = ScrollController();
  late int selectedIndex = widget.initReciterIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Stack(
            children: [
              const Center(child: Text("Select Reciter")),
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
            itemCount: recitationsInfoList.length,
            controller: scrollController,
            padding: const EdgeInsets.all(5),
            itemBuilder: (context, index) {
              ReciterInfoModel reciterInfoModel = ReciterInfoModel.fromMap(
                recitationsInfoList[index],
              );
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:
                      selectedIndex == index
                          ? AppColors.primaryColor.withValues(alpha: 0.2)
                          : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            safeSubString(
                              reciterInfoModel.name,
                              20,
                              replacer: "...",
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            reciterInfoModel.source.toString(),
                            style: const TextStyle(color: Colors.grey),
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
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: const Text("Save")),
          ),
        ),
      ],
    );
  }
}
