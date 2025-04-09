import 'package:flutter/material.dart';

class PageByPageView extends StatefulWidget {
  final String startKey;
  final String endKey;
  final String? toScrollKey;

  const PageByPageView({
    super.key,
    required this.startKey,
    required this.endKey,
    this.toScrollKey,
  });

  @override
  State<PageByPageView> createState() => _PageByPageViewState();
}

class _PageByPageViewState extends State<PageByPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
