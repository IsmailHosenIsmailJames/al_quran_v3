import 'package:al_quran_v3/src/core/di/injection.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/cubit/quran_resources_cubit.dart';
import 'package:al_quran_v3/src/features/quran_resources/presentation/screens/quran_resources_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranResourcesView extends StatelessWidget {
  final int initTab;
  const QuranResourcesView({super.key, this.initTab = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuranResourcesCubit>(),
      child: QuranResourcesScreen(initTab: initTab),
    );
  }
}
