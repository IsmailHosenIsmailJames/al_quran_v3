import "dart:io";

import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/widget/preview_quran_script/ayah_preview_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:screenshot/screenshot.dart";

import "functions/functions.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<QuranViewCubit, QuranViewState>(
          builder: (context, quranViewState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quran Script", style: titleStyle),
                const Gap(7),
                getScriptSelectionSegmentedButtons(),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quran Font Size", style: titleStyle),
                    Text(quranViewState.fontSize.toString(), style: titleStyle),
                  ],
                ),

                const Gap(10),

                SliderTheme(
                  data: const SliderThemeData(padding: EdgeInsets.zero),
                  child: Slider.adaptive(
                    value: quranViewState.fontSize,
                    max: 60,
                    min: 10,
                    divisions: 100,
                    onChanged: (value) {
                      context.read<QuranViewCubit>().changeFontSize(
                        value.toPrecision(2),
                      );
                    },
                  ),
                ),
                const Gap(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quran Line Height", style: titleStyle),
                    Text(
                      quranViewState.lineHeight.toString(),
                      style: titleStyle,
                    ),
                  ],
                ),

                const Gap(10),

                SliderTheme(
                  data: const SliderThemeData(padding: EdgeInsets.zero),
                  child: Slider.adaptive(
                    value: quranViewState.lineHeight,
                    max: 5,
                    min: 0.7,
                    divisions: 100,

                    onChanged: (value) {
                      context.read<QuranViewCubit>().changeLineHeight(
                        value.toPrecision(2),
                      );
                    },
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Translation & Tafsir Font Size", style: titleStyle),
                    Text(
                      quranViewState.translationFontSize.toString(),
                      style: titleStyle,
                    ),
                  ],
                ),

                const Gap(10),

                SliderTheme(
                  data: const SliderThemeData(padding: EdgeInsets.zero),
                  child: Slider.adaptive(
                    value: quranViewState.translationFontSize,
                    max: 60,
                    min: 8,

                    divisions: 100,

                    onChanged: (value) {
                      context.read<QuranViewCubit>().changeTranslationFontSize(
                        value.toPrecision(2),
                      );
                    },
                  ),
                ),
                const Gap(5),
                getAyahPreviewWidget(),
                const Gap(20),
                const Text(
                  "Audio Cached",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Gap(5),
                Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                    top: 5,
                    bottom: 5,
                    right: 5,
                  ),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: FutureBuilder(
                    future: getCategorizedCacheFilesWithSize(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map<String, List<Map<String, dynamic>>> data =
                            snapshot.data!;

                        List<String> keys = data.keys.toList();

                        return getListOfCacheWidget(keys, data);
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Cache Not Found"));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Column getListOfCacheWidget(
    List<String> keys,
    Map<String, List<Map<String, dynamic>>> data,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 100, child: Text("Cache Size")),
            SizedBox(
              width: 100,
              child: FutureBuilder<int>(
                future: justAudioCache(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text(formatBytes(snapshot.data ?? 0));
                  }
                },
              ),
            ),
            SizedBox(
              width: 100,
              height: 25,
              child: ElevatedButton(
                onPressed: () async {
                  for (var key in data.keys) {
                    var value = data[key];

                    // ignore: avoid_function_literals_in_foreach_calls
                    for (var element in value!) {
                      await File(element["path"]).delete();
                    }
                  }
                  setState(() {});
                },
                child: const Text("Clean"),
              ),
            ),
          ],
        ),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 100, child: Text("Last Modified")),
            SizedBox(width: 100, child: Text("Cache Size")),
            Gap(100),
          ],
        ),
        const Gap(10),
        ...List.generate(keys.length, (index) {
          List<Map<String, dynamic>> current = data[keys[index]]!;

          int fileSize = 0;

          for (var fileInfo in current) {
            fileSize += (fileInfo["size"] ?? 0) as int;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 100, child: Text(keys[index])),
              SizedBox(
                width: 100,
                child: Text((formatBytes(fileSize, 2)).toString()),
              ),
              SizedBox(
                width: 100,
                height: 29,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: OutlinedButton(
                    onPressed: () async {
                      for (var element in current) {
                        await File(element["path"]).delete();
                      }
                      setState(() {});
                    },
                    child: const Text("Clean"),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}

Future<Map<String, List<Map<String, dynamic>>>>
getCategorizedCacheFilesWithSize() async {
  Map<String, List<Map<String, dynamic>>> categorizedFiles = {};
  final cacheDir = Directory(
    join((await getTemporaryDirectory()).path, "just_audio_cache", "remote"),
  );
  final files =
      cacheDir
          .listSync()
          .whereType<File>(); // List all files in the cache directory

  final now = DateTime.now();

  for (var file in files) {
    final lastModified = file.lastModifiedSync().second;

    final differenceInDays =
        Duration(seconds: now.second - lastModified).inDays;
    final fileSize = file.lengthSync(); // Get the file size

    final fileInfo = {"path": file.path, "size": fileSize};

    String timeKey = getTheTimeKey(differenceInDays);
    List<Map<String, dynamic>> tem = categorizedFiles[timeKey] ?? [];
    tem.add(fileInfo);
    categorizedFiles[timeKey] = tem;
  }

  return categorizedFiles;
}

String getTheTimeKey(int distanceInDay) {
  String timeKey = "";
  if (distanceInDay > 365) {
    timeKey = "1 Year ago";
  } else if (distanceInDay > 182) {
    timeKey = "6 Months ago";
  } else if (distanceInDay > 91) {
    timeKey = "3 Months ago";
  } else if (distanceInDay > 60) {
    timeKey = "2 Months ago";
  } else if (distanceInDay > 30) {
    timeKey = "1 Month ago";
  } else if (distanceInDay > 21) {
    timeKey = "3 Weeks ag0";
  } else if (distanceInDay > 14) {
    timeKey = "2 Weeks ago";
  } else if (distanceInDay > 7) {
    timeKey = "1 Weeks ago";
  } else if (distanceInDay > 6) {
    timeKey = "6 Days ago";
  } else if (distanceInDay > 5) {
    timeKey = "5 Days ago";
  } else if (distanceInDay > 4) {
    timeKey = "4 Days ago";
  } else if (distanceInDay > 3) {
    timeKey = "3 Days ago";
  } else if (distanceInDay > 2) {
    timeKey = "2 Days ago";
  } else if (distanceInDay > 1) {
    timeKey = "1 Day ago";
  } else {
    timeKey = "Today";
  }
  return timeKey;
}
