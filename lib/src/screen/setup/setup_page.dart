import "package:al_quran_v3/src/features/setup/presentation/screens/setup_screen.dart";
import "package:flutter/material.dart";

export "package:al_quran_v3/src/features/setup/presentation/widgets/setup_preview_card.dart" show getFeaturesMark;

class AppSetupPage extends StatelessWidget {
  const AppSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SetupScreen();
  }
}
