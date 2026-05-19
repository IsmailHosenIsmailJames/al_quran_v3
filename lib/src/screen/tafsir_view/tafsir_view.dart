import "dart:developer" as developer;
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/resources/quran_resources/models/resources_model.dart";
import "package:al_quran_v3/src/screen/quran_resources/quran_resources_view.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_state.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/utils/quran_resources/quran_tafsir_function.dart";
import "package:al_quran_v3/src/api/quran_auth_service.dart";
import "package:al_quran_v3/src/api/quran_auth_session.dart";
import "package:al_quran_v3/src/api/quran_tafsir_api.dart";
import "package:al_quran_v3/src/api/models/tafsir_model.dart";
import "package:clipboard/clipboard.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_html/flutter_html.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:share_plus/share_plus.dart";

class TafsirTabItem {
  final String name;
  final ResourcesModel? localResource;
  final TafsirInfo? onlineResource;

  TafsirTabItem({
    required this.name,
    this.localResource,
    this.onlineResource,
  });

  bool get isOnline => onlineResource != null;
}

class TafsirView extends StatefulWidget {
  final String ayahKey;
  const TafsirView({super.key, required this.ayahKey});

  @override
  State<TafsirView> createState() => _TafsirViewState();
}

class _TafsirViewState extends State<TafsirView>
    with TickerProviderStateMixin {
  late SurahInfoModel surahInfoModel;
  late AppLocalizations appLocalizations;

  List<TafsirTabItem> _tabItems = [];
  bool _loadingOnline = false;
  late TabController _tabController;

  @override
  void initState() {
    surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah[widget.ayahKey.split(":").first]!,
    );
    _tabController = TabController(length: 0, vsync: this);
    _loadTabs();
    super.initState();
  }

  void _loadTabs() {
    final localBooks = QuranTafsirFunction.getDownloadedTafsirBooks();
    
    // Dispose the old controller if any
    _tabController.dispose();

    _tabItems = localBooks.map((e) => TafsirTabItem(
      name: e.name,
      localResource: e,
    )).toList();

    _tabController = TabController(length: _tabItems.length, vsync: this);

    if (QuranAuthSession.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadOnlineTafsirs();
      });
    }
  }

  Future<void> _loadOnlineTafsirs() async {
    if (_loadingOnline) return;
    setState(() {
      _loadingOnline = true;
    });

    try {
      // Get current locale/language of the app
      final locale = AppLocalizations.of(context).localeName;
      // Fetch available tafsirs from Quran Foundation API
      final onlineTafsirs = await QuranTafsirApi.getTafsirs(language: locale);

      // Filter out any online tafsirs that are already downloaded locally to avoid duplicates!
      final localNames = _tabItems.map((e) => e.name.toLowerCase()).toSet();
      final filteredOnline = onlineTafsirs.where((online) {
        final onlineName = online.name.toLowerCase();
        final translatedName = online.translatedName?.name.toLowerCase();
        return !localNames.contains(onlineName) && 
               (translatedName == null || !localNames.contains(translatedName));
      }).toList();

      if (filteredOnline.isNotEmpty && mounted) {
        final newOnlineItems = filteredOnline.map((e) => TafsirTabItem(
          name: e.translatedName?.name ?? e.name,
          onlineResource: e,
        )).toList();

        // Keep track of the current tab index so we don't lose the user's active tab when we update the controller
        final currentIdx = _tabController.index;

        setState(() {
          _tabItems.addAll(newOnlineItems);
          
          // Re-initialize TabController with new length
          final oldController = _tabController;
          _tabController = TabController(
            length: _tabItems.length,
            vsync: this,
            initialIndex: currentIdx < _tabItems.length ? currentIdx : 0,
          );
          // Dispose the old controller
          WidgetsBinding.instance.addPostFrameCallback((_) {
            oldController.dispose();
          });
        });
      }
    } catch (e) {
      developer.log('Error loading online tafsirs: $e', name: 'TafsirView');
    } finally {
      if (mounted) {
        setState(() {
          _loadingOnline = false;
        });
      }
    }
  }

  Future<void> _handleLogin() async {
    try {
      final result = await QuranAuthService.login();
      if (result != null) {
        Fluttertoast.showToast(msg: "Logged in successfully!");
        _loadTabs();
      } else {
        Fluttertoast.showToast(msg: "Login cancelled or failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error during login: $e");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildLoginBanner(ThemeState themeState) {
    if (QuranAuthSession.isLoggedIn) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeState.primary.withValues(alpha: 0.85),
            themeState.primaryShade200.withValues(alpha: 0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: themeState.primary.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.cloud_outlined,
            color: Colors.white,
            size: 28,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Unlock 20+ Tafsirs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Gap(2),
                Text(
                  'Access cloud Tafsirs directly in your language.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: themeState.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget onlineTafsirWidget(TafsirInfo onlineTafsir, int tabIndex) {
    return LazyOnlineTafsirWidget(
      onlineTafsir: onlineTafsir,
      ayahKey: widget.ayahKey,
      tabController: _tabController,
      tabIndex: tabIndex,
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

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    final themeState = context.read<ThemeCubit>().state;

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
              backgroundColor: themeState.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuranResourcesView(initTab: 1),
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
                    if (_tabItems.isEmpty) return;
                    final currentTab = _tabItems[_tabController.index];
                    if (currentTab.isOnline) {
                      try {
                        final ayahTafsir = await QuranTafsirApi.getTafsirForAyah(
                          resourceId: currentTab.onlineResource!.id.toString(),
                          ayahKey: widget.ayahKey,
                        );
                        String text = ayahTafsir.text.replaceAll('"', "").trim();
                        if (text.isNotEmpty) {
                          await FlutterClipboard.copy(text);
                          await Fluttertoast.showToast(msg: appLocalizations.copy);
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Failed to fetch tafsir text to copy.");
                      }
                    } else {
                      final tafsirData =
                          await QuranTafsirFunction.getTafsirForBook(
                            currentTab.localResource!,
                            widget.ayahKey,
                          );
                      String? text = tafsirData?.tafsir["text"] as String?;
                      text = text?.replaceAll('"', "").trim();
                      if (text != null && text.isNotEmpty) {
                        await FlutterClipboard.copy(text);
                        await Fluttertoast.showToast(msg: appLocalizations.copy);
                      }
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
                    if (_tabItems.isEmpty) return;
                    final currentTab = _tabItems[_tabController.index];
                    if (currentTab.isOnline) {
                      try {
                        final ayahTafsir = await QuranTafsirApi.getTafsirForAyah(
                          resourceId: currentTab.onlineResource!.id.toString(),
                          ayahKey: widget.ayahKey,
                        );
                        String text = ayahTafsir.text.replaceAll('"', "").trim();
                        if (text.isNotEmpty) {
                          await SharePlus.instance.share(
                            ShareParams(
                              text:
                                  "$text\n\n(${currentTab.name})\n\nShared via Al Quran App",
                            ),
                          );
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Failed to fetch tafsir text to share.");
                      }
                    } else {
                      final tafsirData =
                          await QuranTafsirFunction.getTafsirForBook(
                            currentTab.localResource!,
                            widget.ayahKey,
                          );
                      String? text = tafsirData?.tafsir["text"] as String?;
                      text = text?.replaceAll('"', "").trim();
                      if (text != null && text.isNotEmpty) {
                        await SharePlus.instance.share(
                          ShareParams(
                            text:
                                "$text\n\n(${currentTab.localResource!.name})\n\nShared via Al Quran App",
                          ),
                        );
                      }
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
                    if (_tabItems.isEmpty) return;
                    final currentTab = _tabItems[_tabController.index];
                    if (currentTab.isOnline) {
                      Fluttertoast.showToast(msg: "Cloud Tafsirs cannot be deleted.");
                      return;
                    }
                    final currentBook = currentTab.localResource!;
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
                      _loadTabs();
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
        bottom: _tabItems.isNotEmpty
            ? TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                tabs: List<Tab>.generate(_tabItems.length, (index) {
                  final item = _tabItems[index];
                  return Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item.name),
                        if (item.isOnline) ...[
                          const Gap(6),
                          Icon(
                            Icons.cloud_outlined,
                            size: 14,
                            color: themeState.primary,
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              )
            : null,
      ),
      body: Column(
        children: [
          _buildLoginBanner(themeState),
          Expanded(
            child: _tabItems.isNotEmpty
                ? TabBarView(
                    controller: _tabController,
                    children: List<Widget>.generate(_tabItems.length, (index) {
                      final item = _tabItems[index];
                      if (item.isOnline) {
                        return onlineTafsirWidget(item.onlineResource!, index);
                      } else {
                        return tafsirWidget(item.localResource!);
                      }
                    }),
                  )
                : Center(child: Text(appLocalizations.selectTafsirBook)),
          ),
        ],
      ),
    );
  }
}

class LazyOnlineTafsirWidget extends StatefulWidget {
  final TafsirInfo onlineTafsir;
  final String ayahKey;
  final TabController tabController;
  final int tabIndex;

  const LazyOnlineTafsirWidget({
    super.key,
    required this.onlineTafsir,
    required this.ayahKey,
    required this.tabController,
    required this.tabIndex,
  });

  @override
  State<LazyOnlineTafsirWidget> createState() => _LazyOnlineTafsirWidgetState();
}

class _LazyOnlineTafsirWidgetState extends State<LazyOnlineTafsirWidget> {
  bool _hasBeenVisited = false;

  @override
  void initState() {
    super.initState();
    _checkActive();
    widget.tabController.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(covariant LazyOnlineTafsirWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabController != widget.tabController) {
      oldWidget.tabController.removeListener(_handleTabChange);
      widget.tabController.addListener(_handleTabChange);
    }
    _checkActive();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (mounted) {
      _checkActive();
    }
  }

  void _checkActive() {
    if (widget.tabController.index == widget.tabIndex) {
      if (!_hasBeenVisited) {
        setState(() {
          _hasBeenVisited = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasBeenVisited) {
      final themeState = context.read<ThemeCubit>().state;
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: themeState.primaryShade100,
          color: themeState.primary,
        ),
      );
    }

    return _buildContent();
  }

  Widget _buildContent() {
    final themeState = context.read<ThemeCubit>().state;
    final appLocalizations = AppLocalizations.of(context);
    
    return FutureBuilder<AyahTafsir>(
      key: ValueKey('${widget.onlineTafsir.id}_${widget.ayahKey}'),
      future: QuranTafsirApi.getTafsirForAyah(
        resourceId: widget.onlineTafsir.id.toString(),
        ayahKey: widget.ayahKey,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: themeState.primaryShade100,
                  color: themeState.primary,
                ),
                const Gap(16),
                const Text(
                  'Fetching Tafsir from Quran Foundation...',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Card(
                elevation: 0,
                color: themeState.mutedGray.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.cloud_off_outlined,
                        size: 48,
                        color: Colors.redAccent,
                      ),
                      const Gap(16),
                      const Text(
                        'Failed to Fetch Tafsir',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        snapshot.error.toString().replaceAll('Exception:', '').trim(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const Gap(24),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeState.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        final tafsirData = snapshot.data;
        if (tafsirData == null || tafsirData.text.trim().isEmpty) {
          return Center(
            child: Text(
              appLocalizations.tafsirNotAvailable(widget.ayahKey),
            ),
          );
        }

        final text = tafsirData.text;

        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
            bottom: 50,
          ),
          child: BlocBuilder<QuranViewCubit, QuranViewState>(
            builder: (context, state) {
              return Html(
                data: text,
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
