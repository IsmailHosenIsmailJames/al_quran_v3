import "package:flutter/material.dart";

class DonateUsView extends StatefulWidget {
  const DonateUsView({super.key});

  @override
  State<DonateUsView> createState() => _DonateUsViewState();
}

class _DonateUsViewState extends State<DonateUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donate Us")),
      body: const Center(child: Text("Under developent")),
    );
  }
}
