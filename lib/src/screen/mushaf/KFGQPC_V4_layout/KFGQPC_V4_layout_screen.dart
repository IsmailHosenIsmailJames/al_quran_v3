import 'dart:convert';
import "dart:developer";
import 'dart:io';

import "package:al_quran_v3/src/resources/quran_resources/meta/chapter_header_meta.dart";
import "package:archive/archive.dart";
import "package:dartx/dartx_io.dart";
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";

import '../utils/font_loader.dart';
import 'models/mushaf_script_model.dart';

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
  List<MushafScriptPageModel> _pages = [];

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
      await _loadPages();
    } else {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

  Future<void> _loadPages() async {
    // try {
    final jsonFile = File("$_baseDirPath/script/quran_pages.json");
    log(
      "${jsonFile.path}: ${await jsonFile.exists()}",
      name: "KfgqpcV4LayoutScreen",
    );

    if (await jsonFile.exists()) {
      final jsonString = await jsonFile.readAsString();
      log(jsonString.substring(0, 100), name: "KfgqpcV4LayoutScreen");
      // try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _pages = jsonList.map((x) => MushafScriptPageModel.fromMap(x)).toList();
      // } catch (e) {
      //   log(e.toString(), name: "KfgqpcV4LayoutScreen");
      // }
      log("Total pages: ${_pages.length}", name: "KfgqpcV4LayoutScreen");
    } else {
      // log  tree of folders and files
      final directory = Directory(_baseDirPath);
      final List<FileSystemEntity> files = directory.listSync(recursive: true);
      for (final file in files) {
        log(file.path, name: "KfgqpcV4LayoutScreen");
      }
    }

    // Attempt to load the surah name font
    await DynamicFontLoader.loadLocalFont(
      "SurahName",
      "$_baseDirPath/NeoHeader_COLOR-Regular.ttf",
    );

    if (mounted) {
      setState(() {
        _isChecking = false;
      });
    }
    // } catch (e) {
    // debugPrint("Error loading pages: $e");
    // if (mounted) {
    //   setState(() {
    //     _isChecking = false;
    //   });
    // }
    // }
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
      final fontFilePath = "$_baseDirPath/NeoHeader_COLOR-Regular.ttf";

      final dio = Dio();

      // Download surah name font to base dir
      await Directory(_baseDirPath).create(recursive: true);

      if (mounted) {
        setState(() {
          _downloadStatus = "Downloading Surah Header Font...";
        });
      }
      await dio.download(
        "https://ismailhosenismailjames.github.io/al_quran_mushaf/NeoHeader_COLOR-Regular.ttf",
        fontFilePath,
      );

      // Download main zip
      if (mounted) {
        setState(() {
          _downloadStatus = "Downloading Mushaf Data (Zip)...";
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

      // Cleanup sip
      await zipFile.delete();

      if (mounted) {
        setState(() {
          _downloadStatus = "Loading data...";
          _isDownloading = false;
        });
      }

      await _loadPages();
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

  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_pages.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("KFGQPC V4"),
          actions: [
            DropdownButton(
              items: _pages.map((page) {
                return DropdownMenuItem(
                  value: page.pageNumber,
                  child: Text(page.pageNumber.toString()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _pageController.jumpToPage(value);
                  setState(() {});
                }
              },
            ),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (index) {
            setState(() {});
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: MushafPageView(
                pageData: _pages[index],
                baseDirPath: _baseDirPath,
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Mushaf Download")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://ismailhosenismailjames.github.io/al_quran_mushaf/WhatsApp%20Image%202026-02-20%20at%2016.11.16.jpeg",
                height: 300,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 100),
              ),
              const SizedBox(height: 32),
              const Text(
                "KFGQPC V4 Layout requires additional data.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              if (_isDownloading) ...[
                Text(_downloadStatus),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: _downloadProgress),
                const SizedBox(height: 8),
                Text("${(_downloadProgress * 100).toStringAsFixed(1)}%"),
              ] else
                ElevatedButton.icon(
                  onPressed: downloadAndExtractMushaf,
                  icon: const Icon(Icons.download),
                  label: const Text("Download & Preview"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MushafPageView extends StatefulWidget {
  final MushafScriptPageModel pageData;
  final String baseDirPath;

  const MushafPageView({
    super.key,
    required this.pageData,
    required this.baseDirPath,
  });

  @override
  State<MushafPageView> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends State<MushafPageView> {
  bool _fontLoaded = false;
  String _fontFamily = "";

  @override
  void initState() {
    super.initState();
    _loadFont();
  }

  @override
  void didUpdateWidget(covariant MushafPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pageData.pageNumber != widget.pageData.pageNumber) {
      _loadFont();
    }
  }

  Future<void> _loadFont() async {
    int pageNum = widget.pageData.pageNumber;
    _fontFamily = "Page$pageNum";
    final fontPath = "${widget.baseDirPath}/fonts/p$pageNum.ttf";

    _fontFamily = await DynamicFontLoader.loadLocalFont(_fontFamily, fontPath);

    if (mounted) {
      setState(() {
        _fontLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_fontLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: widget.pageData.lines.map((line) {
          // Check if it's a surah name
          if (line.lineType == LineType.SURAH_NAME) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: Text(
                  chapterHeaderCodes[line.content
                          .replaceAll("Surah Name ", "")
                          .replaceAll("\n", " ")
                          .toIntOrNull() ??
                      1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "SurahName",
                    fontSize: 100,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }

          // For Basmallah
          if (line.lineType == LineType.BASMALLAH) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                line.content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily:
                      "QPC_Hafs", // Depending on standard, might need fallback
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            );
          }

          // Normal Ayah line
          return SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                line.content.replaceAll("  ", " "),
                textAlign: line.isCentered
                    ? TextAlign.center
                    : TextAlign.justify,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: 32,
                  height: 1.5,

                  color: Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
