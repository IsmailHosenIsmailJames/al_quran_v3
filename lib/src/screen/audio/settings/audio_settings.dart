import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/player/audio_player_manager.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:screenshot/screenshot.dart";

import "../../../theme/controller/theme_cubit.dart";
import "../functions/functions.dart";

class AudioSettings extends StatefulWidget {
  final bool needAppBar;
  const AudioSettings({super.key, this.needAppBar = false});

  @override
  State<AudioSettings> createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return widget.needAppBar
        ? Scaffold(
            appBar: AppBar(title: Text(l10n.audioSettings)),

            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: mainUI(l10n),
            ),
          )
        : mainUI(l10n);
  }

  BlocBuilder<ThemeCubit, ThemeState> mainUI(AppLocalizations l10n) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<QuranViewCubit, QuranViewState>(
              builder: (context, quranViewState) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.useAudioStream),
                  subtitle: Text(l10n.useAudioStreamDesc),
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                    Set<WidgetState> states,
                  ) {
                    return Icon(
                      states.contains(WidgetState.selected)
                          ? Icons.done_rounded
                          : Icons.close_rounded,
                    );
                  }),

                  value: quranViewState.useAudioStream,
                  onChanged: (value) {
                    context.read<QuranViewCubit>().setViewOptions(
                      useAudioStream: value,
                    );
                    if (value) {
                      Fluttertoast.showToast(msg: l10n.useAudioStreamDesc);
                    } else {
                      Fluttertoast.showToast(msg: l10n.notUseAudioStreamDesc);
                    }
                    AudioPlayerManager.stopListeningAudioPlayerState();
                  },
                );
              },
            ),
            const PlayBackSpeedWidget(),
            const Gap(10),
            Text(
              l10n.audioCached,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Gap(10),

            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: themeState.primaryShade100,
                borderRadius: BorderRadius.circular(7),
              ),
              child: FutureBuilder(
                future: getCategorizedCacheFilesWithSize(context, l10n),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, List<Map<String, dynamic>>> data =
                        snapshot.data!;

                    List<String> keys = data.keys.toList();

                    return getListOfCacheWidget(keys, data, l10n);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(l10n.cacheNotFound));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: context
                            .read<ThemeCubit>()
                            .state
                            .primaryShade100,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
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
                    return CircularProgressIndicator(
                      backgroundColor: context
                          .read<ThemeCubit>()
                          .state
                          .primaryShade100,
                    );
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

class PlayBackSpeedWidget extends StatelessWidget {
  const PlayBackSpeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<QuranViewCubit, QuranViewState>(
      builder: (context, quranViewState) {
        double currentSpeed = quranViewState.playbackSpeed;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.playbackSpeed,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Gap(5),
            Text(
              l10n.playbackSpeedDesc,
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 13,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  tooltip: l10n.playbackSpeedDesc,
                  onPressed: currentSpeed > 0.5
                      ? () async {
                          double value = (currentSpeed - 0.05).clamp(0.5, 2.0);
                          context.read<QuranViewCubit>().setViewOptions(
                            playbackSpeed: value,
                          );
                          await AudioPlayerManager.audioPlayer.setSpeed(value);
                          Fluttertoast.showToast(
                            msg:
                                "${l10n.playbackSpeed} : ${localizedNumber(context, value.toPrecision(2))}x",
                          );
                        }
                      : null,
                ),
                Text(
                  "${currentSpeed.toStringAsFixed(2)}x",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: currentSpeed < 2.0
                      ? () async {
                          double value = (currentSpeed + 0.05).clamp(0.5, 2.0);
                          context.read<QuranViewCubit>().setViewOptions(
                            playbackSpeed: value,
                          );
                          await AudioPlayerManager.audioPlayer.setSpeed(value);
                          Fluttertoast.showToast(
                            msg:
                                "${l10n.playbackSpeed} : ${localizedNumber(context, value.toPrecision(2))}x",
                          );
                        }
                      : null,
                ),
                const Gap(10),
                Expanded(
                  child: Slider(
                    value: currentSpeed,
                    min: 0.5,
                    max: 2.0,
                    divisions: 30,
                    padding: EdgeInsets.zero,
                    label: "${currentSpeed.toStringAsFixed(1)}x",
                    onChangeEnd: (value) async {
                      await AudioPlayerManager.audioPlayer.setSpeed(
                        value.toPrecision(2),
                      );
                      Fluttertoast.showToast(
                        msg:
                            "${l10n.playbackSpeed} : ${localizedNumber(context, value.toPrecision(2))}x",
                      );
                    },
                    onChanged: (value) {
                      context.read<QuranViewCubit>().setViewOptions(
                        playbackSpeed: double.parse(value.toStringAsFixed(1)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

Future<Map<String, List<Map<String, dynamic>>>>
getCategorizedCacheFilesWithSize(
  BuildContext context,
  AppLocalizations l10n,
) async {
  Map<String, List<Map<String, dynamic>>> categorizedFiles = {};
  final cacheDir = Directory(
    join((await getTemporaryDirectory()).path, "just_audio_cache", "remote"),
  );
  final files = cacheDir
      .listSync()
      .whereType<File>(); // List all files in the cache directory

  final now = DateTime.now();

  for (var file in files) {
    final lastModified = file.lastModifiedSync().second;

    final differenceInDays = Duration(
      seconds: now.second - lastModified,
    ).inDays;
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
