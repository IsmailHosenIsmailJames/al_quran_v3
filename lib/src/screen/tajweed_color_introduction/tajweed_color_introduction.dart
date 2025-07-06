import "package:flutter/material.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/color/tajweed_dark.dart";
import "package:al_quran_v3/src/widget/quran_script/script_view/tajweed_view/color/tajweed_light.dart";

class TajweedRule {
  final String ruleName;
  final String description;
  final String tajweedName;
  final Color lightColor;
  final Color darkColor;

  const TajweedRule({
    required this.ruleName,
    required this.description,
    required this.tajweedName,
    required this.lightColor,
    required this.darkColor,
  });
}

class TajweedColorIntroduction extends StatelessWidget {
  const TajweedColorIntroduction({super.key});

  static final List<TajweedRule> tajweedRules = [
    const TajweedRule(
      ruleName: "Ghunnah",
      description: "Nasalization of 'ن' and 'م' when they have a shaddah.",
      tajweedName: "ghunnah",
      lightColor: lightGhunnah,
      darkColor: darkGhunnah,
    ),
    const TajweedRule(
      ruleName: "Idgham",
      description:
          "Merging of the 'n' sound of noon saakinah or tanween with the following letter.",
      tajweedName: "idgham_ghunnah",
      lightColor: lightIdghamGhunnah,
      darkColor: darkIdghamGhunnah,
    ),
    const TajweedRule(
      ruleName: "Idgham Without Ghunnah",
      description:
          "Merging of the 'n' sound of noon saakinah or tanween with the following letter, but without nasalization.",
      tajweedName: "idgham_wo_ghunnah",
      lightColor: lightIdghamWoGhunnah,
      darkColor: darkIdghamWoGhunnah,
    ),
    const TajweedRule(
      ruleName: "Idgham Mutajanisayn",
      description:
          "Merging of two letters that share the same articulation point but have different attributes.",
      tajweedName: "idgham_mutajanisayn",
      lightColor: lightIdghamMutajanisayn,
      darkColor: darkIdghamMutajanisayn,
    ),
    const TajweedRule(
      ruleName: "Idgham Mutaqaribayn",
      description:
          "Merging of two letters that have close articulation points and attributes.",
      tajweedName: "idgham_mutaqaribayn",
      lightColor: lightIdghamMutaqaribayn,
      darkColor: darkIdghamMutaqaribayn,
    ),
    const TajweedRule(
      ruleName: "Idgham Shafawi",
      description: "Merging of a meem saakinah (مْ) with a following 'ب'.",
      tajweedName: "idgham_shafawi",
      lightColor: lightIdghamShafawi,
      darkColor: darkIdghamShafawi,
    ),
    const TajweedRule(
      ruleName: "Iqlab",
      description:
          "Conversion of the 'n' sound of noon saakinah or tanween to a 'm' sound before a 'ب'.",
      tajweedName: "iqlab",
      lightColor: lightIqlab,
      darkColor: darkIqlab,
    ),
    const TajweedRule(
      ruleName: "Ikhfa'",
      description:
          "Hiding the 'n' sound of noon saakinah or tanween, and pronouncing it with a light nasal sound.",
      tajweedName: "ikhafa",
      lightColor: lightIkhafa,
      darkColor: darkIkhafa,
    ),
    const TajweedRule(
      ruleName: "Ikhfa' Shafawi",
      description: "Hiding the 'm' sound of meem saakinah (مْ) before a 'ب'.",
      tajweedName: "ikhafa_shafawi",
      lightColor: lightIkhafaShafawi,
      darkColor: darkIkhafaShafawi,
    ),
    const TajweedRule(
      ruleName: "Qalqalah",
      description:
          "A vibrating or echoing sound on certain letters when they have a sukoon.",
      tajweedName: "qalaqah",
      lightColor: lightQalaqah,
      darkColor: darkQalaqah,
    ),
    const TajweedRule(
      ruleName: "Madd",
      description: "Prolongation or stretching of a vowel sound.",
      tajweedName: "madda_normal",
      lightColor: lightMaddaNormal,
      darkColor: darkMaddaNormal,
    ),
    const TajweedRule(
      ruleName: "Madd Wajib Muttasil",
      description:
          "Obligatory madd of 4 or 5 beats when a hamza appears after a madd letter in the same word.",
      tajweedName: "madda_obligatory_mottasel",
      lightColor: lightMaddaObligatoryMottasel,
      darkColor: darkMaddaObligatoryMottasel,
    ),
    const TajweedRule(
      ruleName: "Madd Ja'iz Munfasil",
      description:
          "Permissible madd of 2, 4, or 5 beats when a hamza appears after a madd letter in the next word.",
      tajweedName: "madda_obligatory_monfasel",
      lightColor: lightMaddaObligatoryMonfasel,
      darkColor: darkMaddaObligatoryMonfasel,
    ),
    const TajweedRule(
      ruleName: "Madd Lazim",
      description:
          "Necessary madd of 6 beats when a sukoon or shaddah follows a madd letter.",
      tajweedName: "madda_necessary",
      lightColor: lightMaddaNecessary,
      darkColor: darkMaddaNecessary,
    ),
    const TajweedRule(
      ruleName: "Madd 'Arid Lil-Sukun",
      description:
          "Temporary madd that occurs when stopping on a word where a madd letter is followed by a letter with a temporary sukoon.",
      tajweedName: "madda_permissible",
      lightColor: lightMaddaPermissible,
      darkColor: darkMaddaPermissible,
    ),
    const TajweedRule(
      ruleName: "Hamzat al-Wasl",
      description:
          "A connecting hamza that is pronounced when starting a word but skipped when read in continuation.",
      tajweedName: "ham_wasl",
      lightColor: lightHamWasl,
      darkColor: darkHamWasl,
    ),
    const TajweedRule(
      ruleName: "Silent Letter",
      description: "A letter that is written but not pronounced.",
      tajweedName: "slnt",
      lightColor: lightSlnt,
      darkColor: darkSlnt,
    ),
    const TajweedRule(
      ruleName: "Laam Shamsiyyah",
      description:
          "The 'l' of the definite article 'al' is not pronounced when followed by a sun letter.",
      tajweedName: "laam_shamsiyah",
      lightColor: lightLaamShamsiyah,
      darkColor: darkLaamShamsiyah,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Tajweed Color Guide")),
      body: ListView.builder(
        itemCount: tajweedRules.length,
        itemBuilder: (context, index) {
          final rule = tajweedRules[index];
          final color = isDarkMode ? rule.darkColor : rule.lightColor;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          rule.ruleName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    rule.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
