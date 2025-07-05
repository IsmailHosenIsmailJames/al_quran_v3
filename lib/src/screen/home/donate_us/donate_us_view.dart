import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:flutter/material.dart";

class DonateUsView extends StatefulWidget {
  const DonateUsView({super.key});

  @override
  State<DonateUsView> createState() => _DonateUsViewState();
}

class _DonateUsViewState extends State<DonateUsView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.donateUs)),
      body: Center(child: Text(l10n.underDevelopment)),
    );
  }
}
