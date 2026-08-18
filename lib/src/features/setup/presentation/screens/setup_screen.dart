import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/features/home/presentation/screens/home_page.dart";
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
import "package:flutter/material.dart";
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

    final segmentsUrl =
        context.read<SegmentedQuranReciterCubit>().state.segmentsUrl ?? "";

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
            MaterialPageRoute(builder: (context) => const HomePage()),
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
                    titleSpacing: 0,
                    title: Text(appLocalizations.appLanguage),
                    centerTitle: true,
                    actions: [
                      IconButton(
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
                    ],
                  ),
                ),
              ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
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
              ? Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: LanguageSelectionList(
                        scrollController: _scrollController,
                        bottomPadding: 24,
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: SetupPreviewCard(
                          onDownloadPressed: () => _onDownloadPressed(context),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    // Full Viewport Language Selection List
                    Positioned.fill(
                      child: LanguageSelectionList(
                        scrollController: _scrollController,
                        bottomPadding: 140,
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
