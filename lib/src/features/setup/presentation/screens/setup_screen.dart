import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/reciter_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_guidance_setup_screen.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_translation_function.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/settings_page.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/download_cubit.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/download_state.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_bloc.dart";
import "package:al_quran_v3/src/features/setup/presentation/bloc/setup_event.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/download_progress_dialog.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/language_selection_list.dart";
import "package:al_quran_v3/src/features/setup/presentation/widgets/setup_preview_card.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:material_ui/material_ui.dart";
import "package:flutter/rendering.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SetupBloc>(
          create: (context) =>
              getIt<SetupBloc>()
                ..add(SetupInitRequested(context.read<LanguageCubit>().state)),
        ),
        BlocProvider<DownloadCubit>(
          create: (context) => getIt<DownloadCubit>(),
        ),
      ],
      child: const _SetupScreenContent(),
    );
  }
}

class _SetupScreenContent extends StatefulWidget {
  const _SetupScreenContent();

  @override
  State<_SetupScreenContent> createState() => _SetupScreenContentState();
}

class _SetupScreenContentState extends State<_SetupScreenContent> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onDownloadPressed(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    final setupBloc = context.read<SetupBloc>();
    final downloadCubit = context.read<DownloadCubit>();

    if (!setupBloc.state.config.isReadyForDownload) {
      Fluttertoast.showToast(msg: appLocalizations.pleaseSelectRequiredOption);
      return;
    }

    final segmentsUrl = context.read<ReciterCubit>().state.segmentsUrl ?? "";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: downloadCubit,
          child: DownloadProgressDialog(
            onRetry: () {
              downloadCubit.startDownload(
                config: setupBloc.state.config,
                segmentsUrl: segmentsUrl,
              );
            },
          ),
        );
      },
    );

    downloadCubit.startDownload(
      config: setupBloc.state.config,
      segmentsUrl: segmentsUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isLandscape = MediaQuery.of(context).size.width > 600;
    bool isSmallScreen = MediaQuery.of(context).size.height < 450;

    return BlocListener<DownloadCubit, DownloadState>(
      listener: (context, downloadState) {
        if (downloadState.status == DownloadStatus.success) {
          QuranTranslationFunction.init(
            locale: context.read<LanguageCubit>().state.locale,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PrayerGuidanceSetupScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: isSmallScreen
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  offset: _isAppBarVisible ? Offset.zero : const Offset(0, -1),
                  child: AppBar(
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    backgroundColor: isLandscape
                        ? (isDark ? const Color(0xFF161817) : Colors.white)
                        : null,
                    bottom: isLandscape
                        ? PreferredSize(
                            preferredSize: const Size.fromHeight(1),
                            child: Divider(
                              height: 1,
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.07)
                                  : Colors.grey.shade200,
                            ),
                          )
                        : null,
                    titleSpacing: 0,
                    title: Text(
                      appLocalizations.appSetup,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          tooltip: appLocalizations.settings,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              ),
                            );
                          },
                          icon: const Icon(FluentIcons.settings_24_regular),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        extendBodyBehindAppBar: !isLandscape,
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (isLandscape) return false;
            if (notification.direction == ScrollDirection.reverse) {
              if (_isAppBarVisible) {
                setState(() {
                  _isAppBarVisible = false;
                });
              }
            } else if (notification.direction == ScrollDirection.forward) {
              if (!_isAppBarVisible) {
                setState(() {
                  _isAppBarVisible = true;
                });
              }
            }
            return true;
          },
          child: isLandscape
              ? Container(
                  color: isDark
                      ? const Color(0xFF101312)
                      : const Color(0xFFF3F5F4),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 1120,
                        maxHeight: 660,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 5,
                              child: LanguageSelectionList(
                                scrollController: _scrollController,
                                isDesktopCard: true,
                                bottomPadding: 16,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 6,
                              child: SetupPreviewCard(
                                onDownloadPressed: () =>
                                    _onDownloadPressed(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    // Full Viewport Language Selection List
                    Positioned.fill(
                      child: LanguageSelectionList(
                        scrollController: _scrollController,
                        bottomPadding: 175,
                      ),
                    ),

                    // Floating / Pinned Bottom Setup Bar
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SetupBottomBar(
                        onDownloadPressed: () => _onDownloadPressed(context),
                        onCustomizePressed: () {
                          showSetupCustomizationSheet(
                            context,
                            onDownloadPressed: () =>
                                _onDownloadPressed(context),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
