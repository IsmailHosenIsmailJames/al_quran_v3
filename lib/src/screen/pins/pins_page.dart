import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:dartx/dartx.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";

class PinsPage extends StatefulWidget {
  final CollectionType collectionType;
  const PinsPage({super.key, required this.collectionType});

  @override
  State<PinsPage> createState() => _PinsPageState();
}

class _PinsPageState extends State<PinsPage> {
  TextEditingController searchTextFieldController = TextEditingController();
  List listOfPinned = [];
  @override
  Widget build(BuildContext context) {
    Color svgColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade100
            : Colors.grey.shade900;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.collectionType.name.capitalize()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.arrow_sync_24_regular),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: SizedBox(
          //     height: 25,
          //     width: 25,
          //     child: SvgPicture.asset(
          //       "assets/img/login-2-svgrepo-com.svg",
          //       colorFilter: ColorFilter.mode(svgColor, BlendMode.srcIn),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (listOfPinned.isNotEmpty)
            Container(
              height: 45,
              margin: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryShade100,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TextFormField(
                        controller: searchTextFieldController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(FluentIcons.search_24_regular),
                          hintText:
                              "Search By ${widget.collectionType.name} Name",
                        ),
                      ),
                    ),
                  ),
                  const Gap(15),
                  SizedBox(
                    width: 60,
                    height: 45,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.primaryShade100,
                      ),
                      onPressed: () {},
                      icon: SizedBox(
                        height: 23,
                        width: 23,
                        child: SvgPicture.asset(
                          "assets/img/adjust-horizontal-settings-svgrepo-com.svg",
                          colorFilter: ColorFilter.mode(
                            svgColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/img/empty-folder-svgrepo-com.svg",
                  colorFilter: ColorFilter.mode(svgColor, BlendMode.srcIn),
                ),
                const Gap(10),
                Text(
                  "No ${widget.collectionType.name} added yet",
                  style: const TextStyle(fontSize: 16),
                ),
                const Gap(10),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryShade100,
                  ),
                  onPressed: () {},
                  icon: const Icon(FluentIcons.add_24_regular),
                  label: const Text("Add New Topic"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum CollectionType { pinned, notes }
