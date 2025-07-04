import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:al_quran_v3/src/screen/prayer_time/resources/list_of_methods.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:al_quran_v3/src/widget/prayers/prayer_calculation_method_info_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

Future<void> showCalculationMethodPopup(
  BuildContext context,
  Function(CalculationMethod calculationMethod) onSelect,
) async {
  final l10n = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                l10n.selectCalculationMethodTitle,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      prayerTimeCalculationMethodModelList.length,
                      (index) {
                        CalculationMethod current =
                            prayerTimeCalculationMethodModelList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(roundedRadius),
                            onTap: () {
                              onSelect(current);
                            },
                            child: getPrayerCalculationMethodInfoWidget(
                              context,
                              current,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
