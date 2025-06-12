import "dart:developer";

import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

Future<void> showAddNotePopup(BuildContext context, String ayahKey) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedRadius),
        ),
        child: const AddNoteWidget(),
      );
    },
  );
}

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({super.key});

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  TextEditingController noteEditingController = TextEditingController();
  bool selectCollectionStep = false;
  bool addNewCollectionStep = false;
  List<String> selectedCollection = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.note_add_24_regular),
              const Gap(10),
              const Text(
                "Add Note",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),

              if (selectCollectionStep) const Spacer(),
              if (selectCollectionStep)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      addNewCollectionStep = true;
                    });
                  },
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(FluentIcons.add_24_regular),
                  label: const Text("New Collection"),
                ),
            ],
          ),
          const Divider(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height:
                selectCollectionStep
                    ? addNewCollectionStep
                        ? 250
                        : 200
                    : 0,
            child: Column(
              children: [
                if (addNewCollectionStep)
                  SizedBox(
                    height: 45,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryShade100,
                              borderRadius: BorderRadius.circular(
                                roundedRadius,
                              ),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: "Write collection name...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          width: 60,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.primaryShade100,
                              foregroundColor: AppColors.primary,
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.done_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Gap(10),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        minTileHeight: 40,
                        leading: Container(
                          height: 60,
                          width: 40,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(roundedRadius),
                            color: AppColors.primaryShade200,
                          ),
                        ),
                        title: const Text("Collection name"),
                        subtitle: const Text("4 notes found"),
                        trailing: Icon(
                          Icons.check_box_rounded,
                          color: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (!selectCollectionStep)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryShade100,
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              child: TextFormField(
                controller: noteEditingController,
                maxLines: 10,
                minLines: 4,
                autofocus: true,
                autocorrect: true,
                decoration: const InputDecoration(
                  hintText: "Write you note here...",
                  border: InputBorder.none,
                ),
              ),
            ),
          const Gap(10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius),
                ),
              ),
              onPressed: () {
                if (!selectCollectionStep) {
                  setState(() {
                    selectCollectionStep = true;
                  });
                } else {
                  log("Save");
                  Navigator.pop(context);
                }
              },
              iconAlignment:
                  selectCollectionStep
                      ? IconAlignment.start
                      : IconAlignment.end,
              icon: Icon(
                selectCollectionStep ? Icons.done : Icons.arrow_forward_rounded,
              ),
              label: Text(selectCollectionStep ? "Save" : "Next"),
            ),
          ),
        ],
      ),
    );
  }
}
