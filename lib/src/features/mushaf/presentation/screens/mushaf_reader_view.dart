import "dart:collection";
import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/audio/data/player/audio_player_manager.dart";
import "package:al_quran_v3/src/features/mushaf/domain/utils/mushaf_page_helper.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_state.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/widgets/mushaf_app_bar.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/widgets/mushaf_bottom_bar.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/widgets/mushaf_delete_dialog.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/widgets/mushaf_jump_bottom_sheet.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_inappwebview/flutter_inappwebview.dart";
import "package:gap/gap.dart";

/// Full-featured, interactive Mushaf reader view.
class MushafReaderView extends StatefulWidget {
  final String baseDirPath;
  final int initialPage;
  final ValueChanged<int>? onPageChanged;
  final VoidCallback? onDeleteData;

  const MushafReaderView({
    super.key,
    required this.baseDirPath,
    this.initialPage = 1,
    this.onPageChanged,
    this.onDeleteData,
  });

  @override
  State<MushafReaderView> createState() => _MushafReaderViewState();
}

class _MushafReaderViewState extends State<MushafReaderView> {
  InAppWebViewController? _controller;
  int _currentPage = 1;
  bool _isWebViewReady = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage.clamp(1, MushafPageHelper.totalPages);
  }

  void _handleWordTap(String jsonMessage) {
    try {
      final data = jsonDecode(jsonMessage);
      log(
        "Word tapped: surah=${data['surah']}, wordId=${data['wordId']}, page=${data['page']}",
        name: "MushafReaderView",
      );

      final surah = data["surah"];
      final wordId = data["wordId"];
      final page = data["page"];

      if (surah != null && wordId != null && page != null) {
        AudioPlayerManager.playWordWithWordId(
          surah is int ? surah : int.tryParse(surah.toString()) ?? 1,
          wordId is int ? wordId : int.tryParse(wordId.toString()) ?? 1,
          page is int ? page : int.tryParse(page.toString()) ?? 1,
        );
      }
    } catch (e) {
      log("Error parsing word tap: $e", name: "MushafReaderView");
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
        name: "MushafReaderView",
      );
    } catch (e) {
      log("Error parsing quran scheme: $e", name: "MushafReaderView");
    }
  }

  void _goToPage(int page) {
    if (page < 1 || page > MushafPageHelper.totalPages) return;
    setState(() {
      _currentPage = page;
    });
    _controller?.evaluateJavascript(source: "loadPage($page)");
    widget.onPageChanged?.call(page);
  }

  void _nextPage() => _goToPage(_currentPage + 1);
  void _prevPage() => _goToPage(_currentPage - 1);

  void _openJumpModal() {
    showMushafJumpModal(
      context: context,
      currentPage: _currentPage,
      onPageSelected: (page) => _goToPage(page),
    );
  }

  Future<void> _handleDeleteData() async {
    final confirmed = await showMushafDeleteDialog(context);
    if (confirmed == true && mounted) {
      widget.onDeleteData?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final cubit = context.read<MushafCubit>();
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<MushafCubit, MushafState>(
      buildWhen: (prev, curr) => prev.isUiVisible != curr.isUiVisible,
      builder: (context, state) {
        final isUiVisible = state.isUiVisible;

        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFAF9F6),
          body: Stack(
            children: [
              // Main Reader Layout (AppBar + Responsive WebView + BottomBar)
              Column(
                children: [
                  // Top AppBar
                  MushafAppBar(
                    currentPage: _currentPage,
                    isUiVisible: isUiVisible,
                    onJumpPressed: _openJumpModal,
                    onDeletePressed: _handleDeleteData,
                    onToggleFullscreen: () {
                      cubit.toggleUiVisibility();
                    },
                  ),

                  // WebView Area - strictly bounded between top and bottom bars
                  Expanded(
                    child: Listener(
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
                          Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer(),
                          ),
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
                            source: """
window.flutter_channel = { postMessage: function(message) { window.flutter_inappwebview.callHandler('flutter_channel', message); } };
document.addEventListener('click', function(e) {
  var isInteractive = e.target.closest('[data-word-id], .word, [onclick], button, a, input, select');
  if (!isInteractive) {
    if (window.flutter_inappwebview) {
      window.flutter_inappwebview.callHandler('toggle_ui');
    }
  }
});
""",
                            injectionTime:
                                UserScriptInjectionTime.AT_DOCUMENT_START,
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
                          controller.addJavaScriptHandler(
                            handlerName: "toggle_ui",
                            callback: (args) {
                              cubit.toggleUiVisibility();
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

                            if (await pagesFile.exists() &&
                                await namesFile.exists()) {
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
                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          final url =
                              navigationAction.request.url?.toString() ?? "";
                          if (url.startsWith("quran://")) {
                            _handleQuranScheme(url);
                            return NavigationActionPolicy.CANCEL;
                          }
                          return NavigationActionPolicy.ALLOW;
                        },
                      ),
                    ),
                  ),

                  // Bottom Bar
                  MushafBottomBar(
                    currentPage: _currentPage,
                    isUiVisible: isUiVisible,
                    onPageChanged: _goToPage,
                    onNextPage: _nextPage,
                    onPrevPage: _prevPage,
                    onJumpPressed: _openJumpModal,
                  ),
                ],
              ),

              // Loading Spinner Overlay while WebView prepares data
              if (!_isWebViewReady)
                Positioned.fill(
                  child: Container(
                    color: isDark ? const Color(0xFF121212) : const Color(0xFFFAF9F6),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                themeState.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.loadingMushafPage,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Floating Exit Fullscreen Toggle Button (visible when UI is hidden)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                top: isUiVisible
                    ? -70
                    : (MediaQuery.paddingOf(context).top + 10),
                right: 14,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isUiVisible ? 0.0 : 1.0,
                  child: IgnorePointer(
                    ignoring: isUiVisible,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          cubit.toggleUiVisibility();
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: (isDark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.white)
                                .withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.12)
                                  : Colors.black.withValues(alpha: 0.08),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FluentIcons.full_screen_minimize_24_filled,
                                size: 16,
                                color: themeState.primary,
                              ),
                              const Gap(6),
                              Text(
                                l10n.fullscreen,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
