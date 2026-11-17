import "dart:developer";

import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_view.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:al_quran_v3/src/features/surah_info/presentation/widgets/surah_info_header_builder.dart";
import "package:dartx/dartx_io.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";

class SurahInfoView extends StatelessWidget {
  final String html;
  final SurahInfoModel surahInfoModel;
  const SurahInfoView({
    super.key,
    required this.html,
    required this.surahInfoModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 700;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${getSurahName(context, surahInfoModel.id)} (${getSurahNameArabic(surahInfoModel.id)})",
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 32 : 16,
              vertical: 20,
            ),
            child: Html(
              data: html,
              style: {
                "body": Style(
                  fontSize: FontSize(16),
                  lineHeight: const LineHeight(1.6),
                  color: theme.textTheme.bodyLarge?.color,
                ),
                "a": Style(
                  color: theme.colorScheme.primary,
                  textDecoration: TextDecoration.underline,
                ),
                "h1": Style(
                  fontSize: FontSize(22),
                  fontWeight: FontWeight.bold,
                  margin: Margins.only(top: 16, bottom: 8),
                ),
                "h2": Style(
                  fontSize: FontSize(19),
                  fontWeight: FontWeight.bold,
                  margin: Margins.only(top: 14, bottom: 6),
                ),
                "h3": Style(
                  fontSize: FontSize(17),
                  fontWeight: FontWeight.w600,
                  margin: Margins.only(top: 12, bottom: 4),
                ),
                "p": Style(
                  margin: Margins.only(bottom: 12),
                ),
              },
              onLinkTap: (url, attributes, element) {
                log(url.toString());
                try {
                  url ??= "";
                  int countOfSlash = url.characters.count(
                    (element) => element == "/",
                  );
                  int countOfDash = url.characters.count(
                    (element) => element == "-",
                  );
                  log(countOfSlash.toString());
                  log(countOfDash.toString());
                  if (countOfSlash == 1) {
                    int? surahNumber = int.tryParse(url.split("/").last);
                    if (surahNumber != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => QuranScriptView(
                                startKey: "$surahNumber:${1}",
                                endKey: getEndAyahKeyFromSurahNumber(surahNumber),
                              ),
                        ),
                      );
                    }
                  } else if (countOfSlash == 2) {
                    String surahNumber = url.split("/")[1];
                    List<String> ayahsRange = url.split("/").last.split("-");
                    String startAyahKey = "$surahNumber:${ayahsRange.first}";
                    String endAyahKey = "$surahNumber:${ayahsRange.last}";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuranScriptView(
                              startKey: startAyahKey,
                              endKey: endAyahKey,
                            ),
                      ),
                    );
                  }
                } catch (e) {
                  log(e.toString());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
