import "dart:io";

import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

import "../../../theme/colors/app_colors.dart";
import "../functions/functions.dart";

class AudioSettings extends StatefulWidget {
  const AudioSettings({super.key});

  @override
  State<AudioSettings> createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColors.primaryShade100,
        borderRadius: BorderRadius.circular(7),
      ),
      child: FutureBuilder(
        future: getCategorizedCacheFilesWithSize(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, List<Map<String, dynamic>>> data = snapshot.data!;

            List<String> keys = data.keys.toList();

            return getListOfCacheWidget(keys, data);
          } else if (snapshot.hasError) {
            return const Center(child: Text("Cache Not Found"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
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
