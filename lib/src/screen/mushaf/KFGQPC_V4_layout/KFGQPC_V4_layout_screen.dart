import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/player/audio_player_manager.dart";
import "package:archive/archive.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:shimmer/shimmer.dart";
import "dart:collection";
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter_inappwebview/flutter_inappwebview.dart";

class KfgqpcV4LayoutScreen extends StatefulWidget {
  const KfgqpcV4LayoutScreen({super.key});

  @override
  State<KfgqpcV4LayoutScreen> createState() => _KfgqpcV4LayoutScreenState();
}

class _KfgqpcV4LayoutScreenState extends State<KfgqpcV4LayoutScreen> {
  bool _isChecking = true;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String _downloadStatus = "";

  String _baseDirPath = "";
  bool _dataReady = false;
  final int _totalPages = 604;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _checkIfDownloaded();
  }

  Future<void> _checkIfDownloaded() async {
    final rootDir = await getApplicationDocumentsDirectory();
    _baseDirPath = "${rootDir.path}/mushaf_demo_data";

    final Directory directory = Directory(_baseDirPath);

    log(
      "${directory.path}: ${await directory.exists()}",
      name: "KfgqpcV4LayoutScreen",
    );

    if (await directory.exists()) {
      // Verify that index.html exists
      final indexFile = File("$_baseDirPath/index.html");
      if (await indexFile.exists()) {
        _dataReady = true;
        final prefs = await SharedPreferences.getInstance();
        _currentPage = prefs.getInt("kfgqpc_mushaf_last_page") ?? 1;
      }
    }

    if (mounted) {
      setState(() {
        _isChecking = false;
      });
    }
  }

  Future<void> _deleteMushafData() async {
    final rootDir = await getApplicationDocumentsDirectory();
    final directory = Directory("${rootDir.path}/mushaf_demo_data");

    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }

    if (mounted) {
      setState(() {
        _dataReady = false;
        _isDownloading = false;
        _downloadProgress = 0.0;
        _downloadStatus = "";
      });
    }
  }

  Future<void> downloadAndExtractMushaf() async {
    if (mounted) {
      setState(() {
        _isDownloading = true;
        _downloadProgress = 0.0;
        _downloadStatus = "Starting download...";
      });
    }

    try {
      final rootDir = await getApplicationDocumentsDirectory();
      _baseDirPath = "${rootDir.path}/mushaf_demo_data";
      final zipFilePath = "${rootDir.path}/KFGQPC_V4_layout.zip";

      final dio = Dio();

      await Directory(_baseDirPath).create(recursive: true);

      // Download main zip
      if (mounted) {
        setState(() {
          _downloadStatus = "Downloading Mushaf Data...";
        });
      }
      await dio.download(
        "https://ismailhosenismailjames.github.io/al_quran_mushaf/KFGQPC_V4_layout.zip",
        zipFilePath,
        onReceiveProgress: (count, total) {
          if (total != -1 && mounted) {
            setState(() {
              _downloadProgress = count / total * 0.5; // First 50%
            });
          }
        },
      );

      if (mounted) {
        setState(() {
          _downloadStatus = "Extracting Data...";
        });
      }

      // Extract zip data
      final zipFile = File(zipFilePath);
      final bytes = await zipFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      int extractCount = 0;
      for (final file in archive) {
        String filename = file.name;

        // Fix for nested directory inside zip if it exists
        if (filename.startsWith("KFGQPC_V4_layout/")) {
          filename = filename.replaceFirst("KFGQPC_V4_layout/", "");
        }

        if (filename.trim().isEmpty) continue;

        if (file.isFile) {
          final data = file.content as List<int>;
          final extractedFile = File("$_baseDirPath/$filename");
          await extractedFile.create(recursive: true);
          await extractedFile.writeAsBytes(data);
        } else {
          await Directory("$_baseDirPath/$filename").create(recursive: true);
        }

        extractCount++;
        if (mounted && extractCount % 10 == 0) {
          setState(() {
            _downloadProgress =
                0.5 + ((extractCount / archive.length) * 0.5); // Second 50%
          });
        }
      }

      // Cleanup zip
      await zipFile.delete();

      if (mounted) {
        setState(() {
          _downloadStatus = "Loading...";
          _isDownloading = false;
          _dataReady = true;
        });
      }
    } catch (e) {
      debugPrint("Download error: $e");
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _downloadStatus = "Error occurred: $e";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_dataReady) {
      return _MushafWebView(
        baseDirPath: _baseDirPath,
        totalPages: _totalPages,
        initialPage: _currentPage,
        onPageChanged: (page) async {
          _currentPage = page;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt("kfgqpc_mushaf_last_page", page);
        },
        onDeleteData: _deleteMushafData,
      );
    }

    // Download screen
    return Scaffold(
      appBar: AppBar(title: const Text("KFGQPC V4")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Card(
                elevation: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://raw.githubusercontent.com/IsmailHosenIsmailJames/al_quran_mushaf/refs/heads/main/screenshot-2026-04-08_21.31.57.588.png",
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(color: Colors.white),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 100),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isDownloading) ...[
                      Text(_downloadStatus),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(value: _downloadProgress),
                      const SizedBox(height: 8),
                      Text("${(_downloadProgress * 100).toStringAsFixed(1)}%"),
                    ] else
                      SizedBox(
                        width: 600,
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: downloadAndExtractMushaf,
                          icon: const Icon(Icons.download),
                          label: Text(AppLocalizations.of(context).download),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── WebView widget for rendering the Mushaf ──

class _MushafWebView extends StatefulWidget {
  final String baseDirPath;
  final int totalPages;
  final int initialPage;
  final ValueChanged<int>? onPageChanged;
  final VoidCallback? onDeleteData;

  const _MushafWebView({
    required this.baseDirPath,
    required this.totalPages,
    this.initialPage = 1,
    this.onPageChanged,
    this.onDeleteData,
  });

  @override
  State<_MushafWebView> createState() => _MushafWebViewState();
}

class _MushafWebViewState extends State<_MushafWebView> {
  InAppWebViewController? _controller;
  int _currentPage = 1;
  bool _isWebViewReady = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  void _handleWordTap(String jsonMessage) {
    try {
      final data = jsonDecode(jsonMessage);
      log(
        "Word tapped: surah=${data['surah']}, wordId=${data['wordId']}, page=${data['page']}",
        name: "MushafWebView",
      );

      AudioPlayerManager.playWordWithWordId(
        data["surah"],
        data["wordId"],
        data["page"],
      );
    } catch (e) {
      log("Error parsing word tap: $e", name: "MushafWebView");
    }
  }

  void _handleQuranScheme(String url) {
    try {
      final uri = Uri.parse(url);
      final surah = uri.queryParameters["surah"];
      final wordId = uri.queryParameters["wordId"];
      final page = uri.queryParameters["page"];
      log(
        "Word tapped (scheme): surah=$surah, wordId=$wordId, page=$page",
        name: "MushafWebView",
      );
    } catch (e) {
      log("Error parsing quran scheme: $e", name: "MushafWebView");
    }
  }

  void _goToPage(int page) {
    if (page < 1 || page > widget.totalPages) return;
    setState(() {
      _currentPage = page;
    });
    _controller?.evaluateJavascript(source: "loadPage($page)");
    widget.onPageChanged?.call(page);
  }

  void _nextPage() => _goToPage(_currentPage + 1);
  void _prevPage() => _goToPage(_currentPage - 1);

  void _showPageNavigationDialog() {
    final TextEditingController pageController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.menu_book),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context).goToPage,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).enterPageNumber,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: pageController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  decoration: const InputDecoration(
                    hintText: "1 - 604",
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).required;
                    }
                    final page = int.tryParse(value);
                    if (page == null || page < 1 || page > 604) {
                      return AppLocalizations.of(context).invalidPage;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).cancel),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final page = int.parse(pageController.text);
                    _goToPage(page);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  AppLocalizations.of(context).goToPage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocalizations.of(context).page} $_currentPage"),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage > 1 ? _prevPage : null,
            tooltip: "Previous Page",
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage < widget.totalPages ? _nextPage : null,
            tooltip: "Next Page",
          ),
          IconButton(
            icon: const Icon(Icons.menu_book),
            tooltip: "Go to Page",
            onPressed: _showPageNavigationDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: AppLocalizations.of(context).deleteMushafData,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context).deleteMushafData),
                    content: Text(
                      AppLocalizations.of(context).deleteMushafDataDescription,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLocalizations.of(context).cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onDeleteData?.call();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: Text(AppLocalizations.of(context).delete),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Listener(
            onPointerSignal: (event) {
              if (Platform.isWindows && event is PointerScrollEvent) {
                _controller?.evaluateJavascript(
                  source:
                      "window.scrollBy({left: ${event.scrollDelta.dx}, top: ${event.scrollDelta.dy}, behavior: 'auto'});",
                );
              }
            },
            onPointerPanZoomUpdate: (event) {
              if (Platform.isWindows) {
                _controller?.evaluateJavascript(
                  source:
                      "window.scrollBy({left: ${-event.panDelta.dx}, top: ${-event.panDelta.dy}, behavior: 'auto'});",
                );
              }
            },
            child: InAppWebView(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
                ),
                Factory<HorizontalDragGestureRecognizer>(
                  () => HorizontalDragGestureRecognizer(),
                ),
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
              },
              initialUrlRequest: URLRequest(
                url: WebUri(
                  Uri.file("${widget.baseDirPath}/index.html").toString(),
                ),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                transparentBackground: false,
                allowFileAccessFromFileURLs: true,
                allowUniversalAccessFromFileURLs: true,
                allowFileAccess: true,
              ),
              initialUserScripts: UnmodifiableListView<UserScript>([
                UserScript(
                  source:
                      "window.flutter_channel = { postMessage: function(message) { window.flutter_inappwebview.callHandler('flutter_channel', message); } };",
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
                ),
              ]),
              onWebViewCreated: (controller) {
                _controller = controller;
                controller.addJavaScriptHandler(
                  handlerName: "flutter_channel",
                  callback: (args) {
                    _handleWordTap(args[0]);
                  },
                );
              },
              onLoadStop: (controller, url) async {
                if (!_isWebViewReady) {
                  final pagesFile = File(
                    "${widget.baseDirPath}/script/quran_pages.json",
                  );
                  final namesFile = File(
                    "${widget.baseDirPath}/surah_name.json",
                  );

                  if (await pagesFile.exists() && await namesFile.exists()) {
                    final pagesJson = await pagesFile.readAsString();
                    final namesJson = await namesFile.readAsString();

                    final pEscaped = jsonEncode(pagesJson);
                    final nEscaped = jsonEncode(namesJson);

                    controller.evaluateJavascript(
                      source: "initializeData($pEscaped, $nEscaped)",
                    );
                  }

                  if (_currentPage != 1) {
                    controller.evaluateJavascript(
                      source: "loadPage($_currentPage)",
                    );
                  }
                  if (mounted) {
                    setState(() {
                      _isWebViewReady = true;
                    });
                  }
                }
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final url = navigationAction.request.url?.toString() ?? "";
                if (url.startsWith("quran://")) {
                  _handleQuranScheme(url);
                  return NavigationActionPolicy.CANCEL;
                }
                return NavigationActionPolicy.ALLOW;
              },
            ),
          ),
          if (!_isWebViewReady)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
