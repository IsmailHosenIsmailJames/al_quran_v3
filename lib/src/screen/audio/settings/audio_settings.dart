import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/functions/number_localization.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

import "../../../theme/controller/theme_cubit.dart";
import "../functions/functions.dart";

class AudioSettings extends StatefulWidget {
  const AudioSettings({super.key});

  @override
  State<AudioSettings> createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: themeState.primaryShade100,
            borderRadius: BorderRadius.circular(7),
          ),
          child: FutureBuilder(
            future: getCategorizedCacheFilesWithSize(context, l10n),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, List<Map<String, dynamic>>> data = snapshot.data!;

                List<String> keys = data.keys.toList();

                return getListOfCacheWidget(keys, data, l10n);
              } else if (snapshot.hasError) {
                return Center(child: Text(l10n.cacheNotFound));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  Column getListOfCacheWidget(
    List<String> keys,
    Map<String, List<Map<String, dynamic>>> data,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 100, child: Text(l10n.cacheSize)),
            SizedBox(
              width: 100,
              child: FutureBuilder<int>(
                future: justAudioCache(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(l10n.error(snapshot.error.toString()));
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
                child: Text(l10n.clean),
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 100, child: Text(l10n.lastModified)),
            SizedBox(width: 100, child: Text(l10n.cacheSize)),
            const Gap(100),
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
                    child: Text(l10n.clean),
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
getCategorizedCacheFilesWithSize(BuildContext context, AppLocalizations l10n) async {
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

    String timeKey = getTheTimeKey(context, l10n, differenceInDays);
    List<Map<String, dynamic>> tem = categorizedFiles[timeKey] ?? [];
    tem.add(fileInfo);
    categorizedFiles[timeKey] = tem;
  }

  return categorizedFiles;
}

String getTheTimeKey(
  BuildContext context,
  AppLocalizations l10n,
  int distanceInDay,
) {
  String timeKey = "";
  if (distanceInDay > 365) {
    timeKey = l10n.oneYearAgo; //"1 Year ago";
  } else if (distanceInDay > 182) {
    timeKey = l10n.monthsAgo(localizedNumber(context, 6));
  } else if (distanceInDay > 91) {
    timeKey = l10n.monthsAgo(localizedNumber(context, 3)); //"3 Months ago";
  } else if (distanceInDay > 60) {
    timeKey = l10n.monthsAgo(localizedNumber(context, 2)); //"2 Months ago";
  } else if (distanceInDay > 30) {
    timeKey = l10n.monthsAgo(localizedNumber(context, 1)); //"1 Month ago";
  } else if (distanceInDay > 21) {
    timeKey = l10n.weeksAgo(localizedNumber(context, 3)); //"3 Weeks ag0";
  } else if (distanceInDay > 14) {
    timeKey = l10n.weeksAgo(localizedNumber(context, 2)); //"2 Weeks ago";
  } else if (distanceInDay > 7) {
    timeKey = l10n.weeksAgo(localizedNumber(context, 1)); //"1 Weeks ago";
  } else if (distanceInDay > 6) {
    timeKey = l10n.daysAgo(localizedNumber(context, 6)); //"6 Days ago";
  } else if (distanceInDay > 5) {
    timeKey = l10n.daysAgo(localizedNumber(context, 5)); //"5 Days ago";
  } else if (distanceInDay > 4) {
    timeKey = l10n.daysAgo(localizedNumber(context, 4)); //"4 Days ago";
  } else if (distanceInDay > 3) {
    timeKey = l10n.daysAgo(localizedNumber(context, 3)); //"3 Days ago";
  } else if (distanceInDay > 2) {
    timeKey = l10n.daysAgo(localizedNumber(context, 2)); //"2 Days ago";
  } else if (distanceInDay > 1) {
    timeKey = l10n.daysAgo(localizedNumber(context, 1)); //"1 Day ago";
  } else {
    timeKey = l10n.today; //"Today";
  }
  return timeKey;
}
