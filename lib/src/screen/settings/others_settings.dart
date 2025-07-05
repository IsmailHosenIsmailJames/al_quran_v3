import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class OthersSettings extends StatefulWidget {
  const OthersSettings({super.key});

  @override
  State<OthersSettings> createState() => _OthersSettingsState();
}

class _OthersSettingsState extends State<OthersSettings> {
  late AppLocalizations appLocalizations;
  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            SwitchListTile(
              title: Text(appLocalizations.rememberHomeTab),
              subtitle: Text(
                appLocalizations.rememberHomeTabSubtitle,
              ),
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              value: state.rememberLastTab,
              onChanged: (value) {
                context.read<OthersSettingsCubit>().setRememberLastTab(value);
              },
            ),
            SwitchListTile(
              title: Text(appLocalizations.wakeLock),
              subtitle: Text(
                appLocalizations.wakeLockSubtitle,
              ),
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                Set<WidgetState> states,
              ) {
                return Icon(
                  states.contains(WidgetState.selected)
                      ? Icons.done_rounded
                      : Icons.close_rounded,
                );
              }),
              contentPadding: EdgeInsets.zero,
              value: state.wakeLock,
              onChanged: (value) {
                context.read<OthersSettingsCubit>().setWakeLock(value);
              },
            ),
          ],
        );
      },
    );
  }
}
