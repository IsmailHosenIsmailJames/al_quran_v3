import "package:flutter/material.dart";

class SearchResultView extends StatefulWidget {
  final dynamic searchRes;
  const SearchResultView({super.key, this.searchRes});

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Result")),
      body: const Center(child: Text("Under Development")),
    );
  }
}
