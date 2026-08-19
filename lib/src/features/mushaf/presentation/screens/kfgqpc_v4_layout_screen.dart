import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_state.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/screens/mushaf_download_view.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/screens/mushaf_reader_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// Main entry point for the KFGQPC V4 Mushaf feature.
class KfgqpcV4LayoutScreen extends StatelessWidget {
  const KfgqpcV4LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MushafCubit>(),
      child: const _MushafViewOrchestrator(),
    );
  }
}

class _MushafViewOrchestrator extends StatelessWidget {
  const _MushafViewOrchestrator();

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    return BlocBuilder<MushafCubit, MushafState>(
      buildWhen: (prev, curr) =>
          prev.isChecking != curr.isChecking ||
          prev.dataReady != curr.dataReady ||
          (curr.dataReady && prev.currentPage != curr.currentPage),
      builder: (context, state) {
        if (state.isChecking) {
          return Scaffold(
            backgroundColor:
                isDark ? const Color(0xFF121212) : const Color(0xFFFAF9F6),
            body: Center(
              child: SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(themeState.primary),
                ),
              ),
            ),
          );
        }

        if (state.dataReady) {
          return MushafReaderView(
            baseDirPath: state.baseDirPath,
            initialPage: state.currentPage,
            onPageChanged: (page) {
              context.read<MushafCubit>().setPage(page);
            },
            onDeleteData: () {
              context.read<MushafCubit>().deleteMushaf();
            },
          );
        }

        return const MushafDownloadView();
      },
    );
  }
}
