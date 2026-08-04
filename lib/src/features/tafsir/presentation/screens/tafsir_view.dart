import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/screens/quran_resources_screen.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:clipboard/clipboard.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:share_plus/share_plus.dart";

class TafsirView extends StatefulWidget {
  final String ayahKey;
  const TafsirView({super.key, required this.ayahKey});

  @override
  State<TafsirView> createState() => _TafsirViewState();
}

class _TafsirViewState extends State<TafsirView>
    with SingleTickerProviderStateMixin {
  late SurahInfoModel surahInfoModel;
  late AppLocalizations appLocalizations;

  late List<ResourcesModel> tafsirBookList;

  @override
  void initState() {
    surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah[widget.ayahKey.split(":").first]!,
    );
    tafsirBookList = QuranTafsirFunction.getDownloadedTafsirBooks();
    _tabController = TabController(length: tafsirBookList.length, vsync: this);
    super.initState();
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          appLocalizations.tafsirAppBarTitle(
            getSurahName(context, surahInfoModel.id),
            getSurahNameArabic(surahInfoModel.id),
            widget.ayahKey,
          ),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.read<ThemeCubit>().state.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuranResourcesScreen(initTab: 1),
                ),
              );
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TafsirView(ayahKey: widget.ayahKey),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () async {
                    final currentBook = tafsirBookList[_tabController.index];
                    final tafsirData =
                        await QuranTafsirFunction.getTafsirForBook(
                          currentBook,
                          widget.ayahKey,
                        );
                    String? text = tafsirData?.tafsir["text"] as String?;
                    text = text?.replaceAll('"', "").trim();
                    if (text != null && text.isNotEmpty) {
                      await FlutterClipboard.copy(text);
                      await Fluttertoast.showToast(msg: appLocalizations.copy);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.copy),
                      const Gap(5),
                      Text(appLocalizations.copy),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () async {
                    final currentBook = tafsirBookList[_tabController.index];
                    final tafsirData =
                        await QuranTafsirFunction.getTafsirForBook(
                          currentBook,
                          widget.ayahKey,
                        );
                    String? text = tafsirData?.tafsir["text"] as String?;
                    text = text?.replaceAll('"', "").trim();
                    if (text != null && text.isNotEmpty) {
                      await SharePlus.instance.share(
                        ShareParams(
                          text:
                              "$text\n\n(${currentBook.name})\n\nShared via Al Quran App",
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.share),
                      const Gap(5),
                      Text(appLocalizations.share),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () async {
                    final currentBook = tafsirBookList[_tabController.index];
                    bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(appLocalizations.delete),
                          content: Text(
                            "Are you sure you want to delete ${currentBook.name}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(appLocalizations.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(
                                appLocalizations.delete,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      await QuranTafsirFunction.removeFromListAlreadyDownloaded(
                        currentBook,
                      );
                      tafsirBookList =
                          QuranTafsirFunction.getDownloadedTafsirBooks();
                      if (tafsirBookList.isEmpty) {
                        if (mounted) Navigator.pop(this.context);
                      } else {
                        setState(() {
                          _tabController = TabController(
                            length: tafsirBookList.length,
                            vsync: this,
                          );
                        });
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.delete, color: Colors.red),
                      const Gap(5),
                      Text(
                        appLocalizations.delete,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
        bottom: tafsirBookList.isNotEmpty
            ? TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                tabs: List<Tab>.generate(tafsirBookList.length, (index) {
                  return Tab(child: Text(tafsirBookList[index].name));
                }),
              )
            : null,
      ),
      body: tafsirBookList.isNotEmpty
          ? TabBarView(
              controller: _tabController,
              children: List<Widget>.generate(tafsirBookList.length, (index) {
                return tafsirWidget(tafsirBookList[index]);
              }),
            )
          : Center(child: Text(appLocalizations.selectTafsirBook)),
    );
  }

  FutureBuilder<TafsirOfAyah?> tafsirWidget(ResourcesModel tafsirModel) {
    return FutureBuilder(
      future: QuranTafsirFunction.getTafsirForBook(tafsirModel, widget.ayahKey),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: context.read<ThemeCubit>().state.primaryShade100,
            ),
          );
        }

        bool isLinkedToAnother = false;
        Map? data = snapshot.data?.tafsir;
        String anotherAyahLinkKey = "";
        String tafsirDataString = "";

        final String? text = data?["text"] as String?;

        final parts = text?.split(":");
        if (parts?.length == 2 &&
            int.tryParse(parts?[0] ?? "") != null &&
            int.tryParse(parts?[1] ?? "") != null) {
          anotherAyahLinkKey = text!;
        }

        tafsirDataString = text?.replaceAll('"', "") ?? "";
        if (tafsirDataString.split(":").first.isInt == true &&
            tafsirDataString.split(":").last.isInt == true) {
          isLinkedToAnother = true;
          anotherAyahLinkKey = tafsirDataString;
        } else {
          tafsirDataString = tafsirDataString;
        }

        return tafsirDataString.isEmpty
            ? Center(
                child: Text(
                  appLocalizations.tafsirNotAvailable(widget.ayahKey),
                ),
              )
            : isLinkedToAnother
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      appLocalizations.tafsirFoundAt(anotherAyahLinkKey),
                    ),
                  ),
                  const Gap(20),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TafsirView(ayahKey: anotherAyahLinkKey);
                            },
                          ),
                          (route) {
                            return true;
                          },
                        );
                      },
                      child: Text(
                        appLocalizations.tafsirJumpTo(anotherAyahLinkKey),
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                  right: 12,
                  bottom: 50,
                ),
                child: BlocBuilder<QuranViewCubit, QuranViewState>(
                  builder: (context, state) {
                    return Html(
                      data: tafsirDataString,
                      style: {
                        "*": Style(
                          padding: HtmlPaddings.zero,
                          margin: Margins.zero,
                          fontSize: FontSize(state.translationFontSize),
                        ),
                      },
                    );
                  },
                ),
              );
      },
    );
  }
}
