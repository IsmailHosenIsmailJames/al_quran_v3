import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/tajweed_rules.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";

class TajweedGuideScreen extends StatelessWidget {
  const TajweedGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bool isLight = brightness == Brightness.light;
    AppLocalizations localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localizations.tajweedGuide)),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 50.0),
        itemCount: TajweedRules.all.length,
        itemBuilder: (context, index) {
          final ruleType = TajweedRules.all[index];
          final ruleDetails = _getRuleDetails(ruleType, isLight);

          return ExpansionTile(
            leading: CircleAvatar(backgroundColor: ruleDetails["color"]),
            title: Text(
              ruleDetails["name"],
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Html(
                  data: ruleDetails["description"],
                  style: {
                    "b": Style(fontWeight: FontWeight.bold),
                    "p": Style(
                      fontSize: FontSize.large,
                      textAlign: TextAlign.start,
                    ),
                    "span": Style(
                      color: ruleDetails["color"],
                      fontFamily: "QPC_Hafs",
                      fontSize: FontSize.xLarge,
                    ),
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Map<String, dynamic> _getRuleDetails(Type ruleType, bool isLight) {
    switch (ruleType) {
      case GhunnahRule:
        return {
          "name": "Ghunnah",
          "color": isLight ? GhunnahRule.lightColor : GhunnahRule.darkColor,
          "description": GhunnahRule.description,
        };
      case IdghamShafawiRule:
        return {
          "name": "Idgham Shafawi",
          "color":
              isLight
                  ? IdghamShafawiRule.lightColor
                  : IdghamShafawiRule.darkColor,
          "description": IdghamShafawiRule.description,
        };
      case IqlabRule:
        return {
          "name": "Iqlab",
          "color": isLight ? IqlabRule.lightColor : IqlabRule.darkColor,
          "description": IqlabRule.description,
        };
      case IkhafaShafawiRule:
        return {
          "name": "Ikhfa' Shafawi",
          "color":
              isLight
                  ? IkhafaShafawiRule.lightColor
                  : IkhafaShafawiRule.darkColor,
          "description": IkhafaShafawiRule.description,
        };
      case QalqalahRule:
        return {
          "name": "Qalqalah",
          "color": isLight ? QalqalahRule.lightColor : QalqalahRule.darkColor,
          "description": QalqalahRule.description,
        };
      case IdghamGhunnahRule:
        return {
          "name": "Idgham with Ghunnah",
          "color":
              isLight
                  ? IdghamGhunnahRule.lightColor
                  : IdghamGhunnahRule.darkColor,
          "description": IdghamGhunnahRule.description,
        };
      case IdghamWoGhunnahRule:
        return {
          "name": "Idgham without Ghunnah",
          "color":
              isLight
                  ? IdghamWoGhunnahRule.lightColor
                  : IdghamWoGhunnahRule.darkColor,
          "description": IdghamWoGhunnahRule.description,
        };
      case IkhafaRule:
        return {
          "name": "Ikhfa' ",
          "color": isLight ? IkhafaRule.lightColor : IkhafaRule.darkColor,
          "description": IkhafaRule.description,
        };
      case MaddTabiiRule:
        return {
          "name": "Madd Tabi' i",
          "color": isLight ? MaddTabiiRule.lightColor : MaddTabiiRule.darkColor,
          "description": MaddTabiiRule.description,
        };
      case MaddLazimRule:
        return {
          "name": "Madd Lazim",
          "color": isLight ? MaddLazimRule.lightColor : MaddLazimRule.darkColor,
          "description": MaddLazimRule.description,
        };
      case MaddLeenRule:
        return {
          "name": "Madd Leen",
          "color": isLight ? MaddLeenRule.lightColor : MaddLeenRule.darkColor,
          "description": MaddLeenRule.description,
        };
      case MaddWajibMuttasilRule:
        return {
          "name": "Madd Wajib Muttasil",
          "color":
              isLight
                  ? MaddWajibMuttasilRule.lightColor
                  : MaddWajibMuttasilRule.darkColor,
          "description": MaddWajibMuttasilRule.description,
        };
      case MaddJaizMunfasilRule:
        return {
          "name": "Madd Ja' iz Munfasil",
          "color":
              isLight
                  ? MaddJaizMunfasilRule.lightColor
                  : MaddJaizMunfasilRule.darkColor,
          "description": MaddJaizMunfasilRule.description,
        };
      case HamWaslRule:
        return {
          "name": "Hamzat al-Wasl",
          "color": isLight ? HamWaslRule.lightColor : HamWaslRule.darkColor,
          "description": HamWaslRule.description,
        };
      case LaamShamsiyahRule:
        return {
          "name": "Lam Shamsiyyah",
          "color":
              isLight
                  ? LaamShamsiyahRule.lightColor
                  : LaamShamsiyahRule.darkColor,
          "description": LaamShamsiyahRule.description,
        };
      case SlntRule:
        return {
          "name": "Silent Letter",
          "color": isLight ? SlntRule.lightColor : SlntRule.darkColor,
          "description": SlntRule.description,
        };
      case IdghamMutajanisaynRule:
        return {
          "name": "Idgham Mutajanisayn",
          "color":
              isLight
                  ? IdghamMutajanisaynRule.lightColor
                  : IdghamMutajanisaynRule.darkColor,
          "description": IdghamMutajanisaynRule.description,
        };
      case IdghamMutaqaribaynRule:
        return {
          "name": "Idgham Mutaqaribayn",
          "color":
              isLight
                  ? IdghamMutaqaribaynRule.lightColor
                  : IdghamMutaqaribaynRule.darkColor,
          "description": IdghamMutaqaribaynRule.description,
        };
      case CustomAlefMaksoraRule:
        return {
          "name": "Alif Maqsurah",
          "color":
              isLight
                  ? CustomAlefMaksoraRule.lightColor
                  : CustomAlefMaksoraRule.darkColor,
          "description": CustomAlefMaksoraRule.description,
        };
      default:
        return {
          "name": "Unknown Rule",
          "color": Colors.grey,
          "description": "No description available.",
        };
    }
  }
}
