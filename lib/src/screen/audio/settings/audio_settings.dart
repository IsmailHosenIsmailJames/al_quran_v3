import "dart:io";

import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:al_quran_v3/app_localizations.dart"; // Import AppLocalizations

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
    final l10n = AppLocalizations.of(context)!; // Get AppLocalizations instance

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: themeState.primaryShade100,
            borderRadius: BorderRadius.circular(7),
          ),
          child: FutureBuilder(
            future: getCategorizedCacheFilesWithSize(context), // Pass context
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, List<Map<String, dynamic>>> data = snapshot.data!;
                List<String> keys = data.keys.toList();
                return getListOfCacheWidget(keys, data, l10n); // Pass l10n
              } else if (snapshot.hasError) {
                return Center(child: Text(l10n.audioSettingsCacheNotFound)); // Localized text
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
    AppLocalizations l10n, // Add l10n parameter
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 100, child: Text(l10n.audioSettingsCacheSizeLabel)), // Localized text
            SizedBox(
              width: 100,
              child: FutureBuilder<int>(
                future: justAudioCache(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(l10n.audioSettingsErrorLabel(snapshot.error.toString())); // Localized text
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
                child: Text(l10n.audioSettingsCleanButtonLabel), // Localized text
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 100, child: Text(l10n.audioSettingsLastModifiedLabel)), // Localized text
            SizedBox(width: 100, child: Text(l10n.audioSettingsCacheSizeLabel)), // Localized text
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
              SizedBox(width: 100, child: Text(keys[index])), // This key is already localized by getTheTimeKey
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
                    child: Text(l10n.audioSettingsCleanButtonLabel), // Localized text
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
    getCategorizedCacheFilesWithSize(BuildContext context) async { // Pass context
  final l10n = AppLocalizations.of(context)!; // Get AppLocalizations instance
  Map<String, List<Map<String, dynamic>>> categorizedFiles = {};
  final cacheDir = Directory(
    join((await getTemporaryDirectory()).path, "just_audio_cache", "remote"),
  );
  final files =
      cacheDir.listSync().whereType<File>();

  final now = DateTime.now();

  for (var file in files) {
    final lastModified = file.lastModifiedSync().second;
    final differenceInDays =
        Duration(seconds: now.second - lastModified).inDays;
    final fileSize = file.lengthSync();

    final fileInfo = {"path": file.path, "size": fileSize};

    String timeKey = getTheTimeKey(differenceInDays, l10n); // Pass l10n
    List<Map<String, dynamic>> tem = categorizedFiles[timeKey] ?? [];
    tem.add(fileInfo);
    categorizedFiles[timeKey] = tem;
  }

  return categorizedFiles;
}

String getTheTimeKey(int distanceInDay, AppLocalizations l10n) { // Add l10n parameter and correct logic/typos
  if (distanceInDay > 365) {
    return l10n.timeAgo1Year;
  } else if (distanceInDay > 182) {
    return l10n.timeAgo6Months;
  } else if (distanceInDay > 91) {
    return l10n.timeAgo3Months;
  } else if (distanceInDay > 60) {
    return l10n.timeAgo2Months;
  } else if (distanceInDay > 30) {
    return l10n.timeAgo1Month;
  } else if (distanceInDay > 21) {
    return l10n.timeAgo3Weeks; // Corrected typo from "ag0"
  } else if (distanceInDay > 14) {
    return l10n.timeAgo2Weeks;
  } else if (distanceInDay > 7) {
    return l10n.timeAgo1Week; // Corrected "1 Weeks ago" to "1 Week ago"
  } else if (distanceInDay == 7) { // Handle exactly 1 week
    return l10n.timeAgo1Week;
  } else if (distanceInDay > 1) { // Handle 2-6 days
     // This part needs specific keys if we want "X Days ago"
     // For simplicity, using existing keys or we can add more specific ones.
     // Let's use a switch for clarity for 2-6 days or more specific keys.
    switch (distanceInDay) {
      case 6: return l10n.timeAgo6Days;
      case 5: return l10n.timeAgo5Days;
      case 4: return l10n.timeAgo4Days;
      case 3: return l10n.timeAgo3Days;
      case 2: return l10n.timeAgo2Days;
      default: return l10n.timeAgo1Day; // Fallback, though logic should cover 2-6
    }
  } else if (distanceInDay == 1) {
    return l10n.timeAgo1Day;
  } else {
    return l10n.timeToday;
  }
}
