import 'package:al_quran_v3/src/screen/setup/setup_page.dart';
import 'package:al_quran_v3/src/widget/theme_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: themeIconButton(context)),
          const Gap(20),
          ElevatedButton.icon(
            onPressed: () async {
              await Hive.deleteFromDisk();
              await Hive.openBox('quran_translation');
              await Hive.openBox('user');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AppSetupPage()),
                (route) {
                  return false;
                },
              );
            },
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset App'),
          ),
        ],
      ),
    );
  }
}
