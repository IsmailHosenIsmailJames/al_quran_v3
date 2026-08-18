import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";

const List<String> canonicalSurahEnglishMeanings = [
  "The Opening", "The Cow", "The Family of Imran", "The Women", "The Table Spread",
  "The Cattle", "The Heights", "The Spoils of War", "The Repentance", "Jonah",
  "Hud", "Joseph", "The Thunder", "Abraham", "The Rocky Tract", "The Honey Bees",
  "The Night Journey", "The Cave", "Mary", "Ta-Ha", "The Prophets", "The Pilgrimage",
  "The Believers", "The Light", "The Criterion", "The Poets", "The Ants", "The Stories",
  "The Spider", "The Romans", "Luqman", "The Prostration", "The Combined Forces",
  "Sheba", "The Originator", "Ya-Sin", "Those who set the Ranks", "Sad", "The Troops",
  "The Forgiver", "Explained in Detail", "The Consultation", "The Ornaments of Gold",
  "The Smoke", "The Crouching", "The Wind-Curved Sandhills", "Muhammad", "The Victory",
  "The Rooms", "Qaf", "The Winnowing Winds", "The Mount", "The Star", "The Moon",
  "The Beneficent", "The Inevitable", "The Iron", "The Pleading Woman", "The Exile",
  "The Examined One", "The Ranks", "The Congregation", "The Hypocrites",
  "The Mutual Disillusion", "The Divorce", "The Prohibition", "The Sovereignty",
  "The Pen", "The Reality", "The Ascending Stairways", "Noah", "The Jinn",
  "The Enshrouded One", "The Cloaked One", "The Resurrection", "Man", "The Emissaries",
  "The Tidings", "Those who drag forth", "He Frowned", "The Overthrowing",
  "The Cleaving", "The Defrauding", "The Splitting Asunder", "The Great Stars",
  "The Night Comer", "The Most High", "The Overwhelming", "The Dawn", "The City",
  "The Sun", "The Night", "The Morning Hours", "The Relief", "The Fig", "The Clot",
  "The Power", "The Clear Proof", "The Earthquake", "The Courser", "The Calamity",
  "The Rivalry in World Increase", "The Declining Day", "The Traducer", "The Elephant",
  "Quraysh", "The Small Kindness", "The Abundance", "The Disbelievers", "The Help",
  "The Palm Fibre", "The Sincerity", "The Daybreak", "Mankind"
];

const List<String> canonicalSurahBengaliNames = [
  "আল-ফাতিহা", "আল-বাকারা", "আলে-ইমরান", "আন-নিসা", "আল-মায়িদাহ", "আল-আনআম",
  "আল-আ'রাফ", "আল-আনফাল", "আত-তাওবাহ্", "ইউনুস", "হুদ", "ইউসুফ", "আর-রা'দ",
  "ইব্রাহীম", "আল-হিজর", "আন-নাহল", "আল-ইসরা", "আল-কাহফ", "মারইয়াম", "ত্বা-হা",
  "আল-আম্বিয়া", "আল-হজ্জ", "আল-মু'মিনূন", "আন-নূর", "আল-ফুরকান", "আশ-শু'আরা",
  "আন-নামল", "আল-কাসাস", "আল-আনকাবূত", "আর-রূম", "লুকমান", "আস-সাজদাহ",
  "আল-আহযাব", "সাবা", "ফাতির", "ইয়াসীন", "আস-সাফফাত", "সাদ", "আয-যুমার", "গাফির",
  "ফুসসিলাত", "আশ-শূরা", "আয-যুখরুফ", "আদ-দুখান", "আল-জাসিয়াহ", "আল-আহকাফ",
  "মুহাম্মাদ", "আল-ফাতহ", "আল-হুজুরাত", "ক্বাফ", "আয-যারিয়াত", "আত-তুর",
  "আন-নাজম", "আল-কামার", "আর-রাহমান", "আল-ওয়াক্বি'য়াহ", "আল-হাদীদ",
  "আল-মুজাদালাহ", "আল-হাশর", "আল-মুমতাহিনাহ", "আস-সফ", "আল-জুমুআহ", "আল-মুনাফিকূন",
  "আত-তাগাবুন", "আত-তালাক", "আত-তাহরীম", "আল-মুলক", "আল-কালাম", "আল-হাক্কাহ",
  "আল-মা'আরিজ", "নূহ", "আল-জিন", "আল-মুযযাম্মিল", "আল-মুদ্দাসসির", "আল-কিয়ামাহ",
  "আল-ইনসান", "আল-মুরসালাত", "আন-নাবা", "আন-নাযি'য়াত", "আবাসা", "আত-তাকবীর",
  "আল-ইনফিতার", "আল-মুতাফফিফীন", "আল-ইনশিকাক", "আল-বুরূজ", "আত-তারিক", "আল-আ'লা",
  "আল-গাশিয়াহ", "আল-ফজর", "আল-বালাদ", "আশ-শামস", "আল-লাইল", "আদ-দুহা",
  "আশ-শারহ", "আত-তীন", "আল-আলাক", "আল-কদর", "আল-বাইয়্যিনাহ", "আয-যিলযাল",
  "আল-আদিয়াত", "আল-ক্বারি'য়াহ", "আত-তাকাসুর", "আল-আসর", "আল-হুমাযাহ", "আল-ফীল",
  "কুরাইশ", "আল-মাউন", "আল-কাওসার", "আল-কাফিরূন", "আন-নাসর", "লাহাব", "আল-ইখলাস",
  "আল-ফালাক", "আন-নাস"
];

const List<String> canonicalSurahBengaliMeanings = [
  "সূচনা", "গাভী", "ইমরানের পরিবার", "নারী", "খাদ্যের খাঞ্চা", "গৃহপালিত পশু",
  "উঁচু স্থান", "যুদ্ধলব্ধ সম্পদ", "অনুতাপ", "ইউনুস", "হুদ", "ইউসুফ", "বজ্রপাত",
  "ইব্রাহীম", "পাথুরে পাহাড়", "মৌমাছি", "রাত্রিকালীন ভ্রমণ", "গুহা", "মারইয়াম",
  "ত্বা-হা", "নবীগণ", "হজ্জ", "মুমিনগণ", "আলো", "সত্য-মিথ্যার পার্থক্যকারী",
  "কবিগণ", "পিপীলিকা", "ঘটনা", "মাকড়সা", "রোমান জাতি", "লুকমান", "সিজদা",
  "জোটবদ্ধ বাহিনী", "সাবা", "স্রষ্টা", "ইয়াসীন", "সারিবদ্ধ দল", "সোয়াদ",
  "দলসমূহ", "ক্ষমাশীল", "সুস্পষ্ট বিবরণ", "পরামর্শ", "সোনার অলংকার", "ধোঁয়া",
  "নতজানু", "বালির পাহাড়", "মুহাম্মাদ", "বিজয়", "ভেতরের কক্ষসমূহ", "ক্বাফ",
  "বিক্ষেপকারী বাতাস", "তুর পাহাড়", "নক্ষত্র", "চাঁদ", "পরম করুণাময়",
  "অবশ্যম্ভাবী ঘটনা", "লোহা", "অভিযোগকারিণী", "সমাবেশ", "পরীক্ষিতা",
  "সারিবদ্ধ সৈন্য", "শুক্রবার", "মুনাফিকগণ", "হার-জিত", "তালাক", "নিষিদ্ধকরণ",
  "সার্বভৌমত্ব", "কলম", "অনিবার্য সত্য", "উচ্চমর্যাদা", "নূহ", "জিন",
  "বস্ত্রাবৃত", "পোশাকাবৃত", "পুনরুত্থান", "মানবজাতি", "প্রেরিত দূত", "মহা সংবাদ",
  "উৎপাটনকারী", "ভ্রুকুটি", "অন্ধকারাচ্ছন্ন", "বিদীর্ণ হওয়া", "প্রতারক",
  "খণ্ড-বিখণ্ড", "নক্ষত্রমণ্ডল", "রাত্রিকালীন আগমনকারী", "সর্বোচ্চ", "আচ্ছন্নকারী",
  "ভোর", "শহর", "সূর্য", "রাত", "পূর্বাহ্ণ", "বক্ষ প্রশস্তকরণ", "ডুমুর",
  "রক্তপিণ্ড", "মর্যাদা", "সুস্পষ্ট প্রমাণ", "ভূমিকম্প", "অভিযানকারী অশ্ব",
  "মহা বিপদ", "প্রাচুর্যের প্রতিযোগিতা", "যুগ", "পরনিন্দাকারী", "হাতি",
  "কুরাইশ", "নিত্যব্যবহার্য বস্তু", "প্রাচুর্য", "অবিশ্বাসীরা", "সাহায্য",
  "খেজুরগাছের দড়ি", "একত্ববাদ", "ঊষা", "মানবজাতি"
];

/// Represents an index record for a Surah containing multi-language search tokens.
class _SurahIndexedRecord {
  final SurahInfoModel surah;
  final int id;
  final String canonicalEnglish;
  final String normalizedEnglish;
  final List<String> englishVariants;
  final String englishMeaning;
  final String normalizedEnglishMeaning;
  final String arabicRaw;
  final String arabicNormalized;
  final String normalizedBengali;
  final String normalizedBengaliMeaning;
  final Map<String, String> localizedNames;
  final Map<String, String> localizedMeanings;
  final List<String> idStrings;
  final String revelationPlace;
  final int versesCount;

  const _SurahIndexedRecord({
    required this.surah,
    required this.id,
    required this.canonicalEnglish,
    required this.normalizedEnglish,
    required this.englishVariants,
    required this.englishMeaning,
    required this.normalizedEnglishMeaning,
    required this.arabicRaw,
    required this.arabicNormalized,
    required this.normalizedBengali,
    required this.normalizedBengaliMeaning,
    required this.localizedNames,
    required this.localizedMeanings,
    required this.idStrings,
    required this.revelationPlace,
    required this.versesCount,
  });
}

/// A high-performance, multi-language Surah Search Engine with pre-computed indexes.
class SurahSearchEngine {
  static final SurahSearchEngine _instance = SurahSearchEngine._internal();
  factory SurahSearchEngine() => _instance;
  static SurahSearchEngine get instance => _instance;

  SurahSearchEngine._internal() {
    _ensureIndexed();
  }

  List<_SurahIndexedRecord>? _records;

  /// Ensures that all 114 Surahs are indexed with multi-language metadata.
  void _ensureIndexed() {
    if (_records != null && _records!.isNotEmpty) return;

    final records = <_SurahIndexedRecord>[];

    for (int surahId = 1; surahId <= 114; surahId++) {
      final surahMap = metaDataSurah[surahId.toString()] ?? {};
      final surah = SurahInfoModel.fromMap(surahMap);

      final canonicalEn = canonicalSurahTransliterations.length >= surahId
          ? canonicalSurahTransliterations[surahId - 1]
          : (surahMap["name_simple"]?.toString() ?? "Surah $surahId");

      final normalizedEn = _normalizeLatin(canonicalEn);

      // Extract English meaning (from constant list or map fallback)
      final rawEnglishMeaning = canonicalSurahEnglishMeanings.length >= surahId
          ? canonicalSurahEnglishMeanings[surahId - 1].toLowerCase()
          : (surahMap["name_translated"]?.toString() ?? "").toLowerCase();
      final normalizedEnMeaning = _normalizeLatin(rawEnglishMeaning);

      // Arabic raw and normalized
      final arabicRaw = canonicalSurahArabicNames.length >= surahId
          ? canonicalSurahArabicNames[surahId - 1]
          : (surahMap["name_arabic"]?.toString() ?? "");
      final arabicNorm = _normalizeArabic(arabicRaw);

      // Bengali canonical names & meanings
      final bengaliName = canonicalSurahBengaliNames.length >= surahId
          ? canonicalSurahBengaliNames[surahId - 1]
          : "";
      final bengaliMeaning = canonicalSurahBengaliMeanings.length >= surahId
          ? canonicalSurahBengaliMeanings[surahId - 1]
          : "";

      final normalizedBn = _normalizeBengali(bengaliName);
      final normalizedBnMeaning = _normalizeBengali(bengaliMeaning);

      // Localized names from surahNameLocalization JSON + Canonical Bengali fallback
      final localizedNames = <String, String>{};
      if (bengaliName.isNotEmpty) {
        localizedNames["bn"] = bengaliName;
      }
      if (surahNameLocalization.isNotEmpty) {
        for (final entry in surahNameLocalization.entries) {
          final list = entry.value;
          if (list is List && list.length >= surahId) {
            localizedNames[entry.key] = list[surahId - 1].toString();
          }
        }
      }

      // Localized meanings from surahMeaningLocalization JSON + Canonical Bengali fallback
      final localizedMeanings = <String, String>{};
      if (bengaliMeaning.isNotEmpty) {
        localizedMeanings["bn"] = bengaliMeaning;
      }
      if (surahMeaningLocalization.isNotEmpty) {
        for (final entry in surahMeaningLocalization.entries) {
          final list = entry.value;
          if (list is List && list.length >= surahId) {
            localizedMeanings[entry.key] = list[surahId - 1].toString();
          }
        }
      }

      // Pre-generate numeric representations: 1, 01, 001, Bengali ১, Arabic ۱
      final idStrings = <String>[
        surahId.toString(),
        surahId.toString().padLeft(2, "0"),
        surahId.toString().padLeft(3, "0"),
        _toBengaliDigits(surahId),
        _toArabicDigits(surahId),
      ];

      // Custom alias dictionary for common phonetic queries
      final variants = _generateVariants(surahId, canonicalEn, normalizedEn);

      records.add(_SurahIndexedRecord(
        surah: surah,
        id: surahId,
        canonicalEnglish: canonicalEn,
        normalizedEnglish: normalizedEn,
        englishVariants: variants,
        englishMeaning: rawEnglishMeaning,
        normalizedEnglishMeaning: normalizedEnMeaning,
        arabicRaw: arabicRaw,
        arabicNormalized: arabicNorm,
        normalizedBengali: normalizedBn,
        normalizedBengaliMeaning: normalizedBnMeaning,
        localizedNames: localizedNames,
        localizedMeanings: localizedMeanings,
        idStrings: idStrings,
        revelationPlace: surah.revelationPlace.toLowerCase(),
        versesCount: surah.versesCount,
      ));
    }

    _records = records;
  }

  /// Searches Surahs with instant multi-language scoring and returns results ranked by relevance.
  List<SurahInfoModel> search(String query, {String? languageCode}) {
    _ensureIndexed();
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return _records!.map((r) => r.surah).toList();
    }

    final lowerQuery = trimmed.toLowerCase();
    final normalizedLatinQuery = _normalizeLatin(trimmed);
    final normalizedArabicQuery = _normalizeArabic(trimmed);
    final normalizedBengaliQuery = _normalizeBengali(trimmed);
    final isNumeric = _numericRegex.hasMatch(trimmed);

    final scored = <MapEntry<int, SurahInfoModel>>[];

    for (final record in _records!) {
      int score = 0;

      // 1. Direct Number Match (Tier 1: 1000 pts)
      if (isNumeric) {
        for (final idStr in record.idStrings) {
          if (idStr == trimmed || idStr == lowerQuery) {
            score = 1000;
            break;
          }
        }
        if (score == 0 && record.id.toString().startsWith(lowerQuery)) {
          score = 850;
        }
      }

      if (score < 1000) {
        // 2. English Transliteration Match (Tier 2: 800-950 pts)
        if (record.normalizedEnglish == normalizedLatinQuery) {
          score = score < 950 ? 950 : score;
        } else if (record.normalizedEnglish.startsWith(normalizedLatinQuery)) {
          score = score < 850 ? 850 : score;
        } else if (record.canonicalEnglish.toLowerCase().contains(lowerQuery) ||
            record.normalizedEnglish.contains(normalizedLatinQuery)) {
          score = score < 750 ? 750 : score;
        }

        // 3. Variant & Common Alias Match (e.g. yaseen, kursi, fatiha, tabarak)
        for (final variant in record.englishVariants) {
          if (variant == normalizedLatinQuery || variant == lowerQuery) {
            score = score < 930 ? 930 : score;
            break;
          } else if (variant.startsWith(normalizedLatinQuery) || variant.startsWith(lowerQuery)) {
            score = score < 830 ? 830 : score;
          } else if (variant.contains(normalizedLatinQuery) || variant.contains(lowerQuery)) {
            score = score < 710 ? 710 : score;
          }
        }

        // 4. Arabic Match (Raw or Normalized, with/without diacritics)
        if (record.arabicNormalized == normalizedArabicQuery || record.arabicRaw == trimmed) {
          score = score < 950 ? 950 : score;
        } else if (record.arabicNormalized.startsWith(normalizedArabicQuery) ||
            record.arabicRaw.startsWith(trimmed)) {
          score = score < 850 ? 850 : score;
        } else if (record.arabicNormalized.contains(normalizedArabicQuery) ||
            record.arabicRaw.contains(trimmed)) {
          score = score < 720 ? 720 : score;
        }

        // 5. Bengali Match (Name & Meaning, with/without prefix)
        if (record.normalizedBengali.isNotEmpty && normalizedBengaliQuery.isNotEmpty) {
          if (record.normalizedBengali == normalizedBengaliQuery) {
            score = score < 950 ? 950 : score;
          } else if (record.normalizedBengali.startsWith(normalizedBengaliQuery)) {
            score = score < 860 ? 860 : score;
          } else if (record.normalizedBengali.contains(normalizedBengaliQuery)) {
            score = score < 760 ? 760 : score;
          }
        }
        if (record.normalizedBengaliMeaning.isNotEmpty && normalizedBengaliQuery.isNotEmpty) {
          if (record.normalizedBengaliMeaning == normalizedBengaliQuery) {
            score = score < 900 ? 900 : score;
          } else if (record.normalizedBengaliMeaning.startsWith(normalizedBengaliQuery)) {
            score = score < 810 ? 810 : score;
          } else if (record.normalizedBengaliMeaning.contains(normalizedBengaliQuery)) {
            score = score < 660 ? 660 : score;
          }
        }

        // 6. English Meaning Match (e.g. "The Cow", "Opening", "Cave")
        if (record.englishMeaning.isNotEmpty) {
          if (record.englishMeaning == lowerQuery || record.normalizedEnglishMeaning == normalizedLatinQuery) {
            score = score < 900 ? 900 : score;
          } else if (record.englishMeaning.startsWith(lowerQuery) || record.normalizedEnglishMeaning.startsWith(normalizedLatinQuery)) {
            score = score < 800 ? 800 : score;
          } else if (record.englishMeaning.contains(lowerQuery) || record.normalizedEnglishMeaning.contains(normalizedLatinQuery)) {
            score = score < 650 ? 650 : score;
          }
        }

        // 7. Universal Cross-Language Localization Match across all 25 languages
        if (score == 0) {
          for (final localizedName in record.localizedNames.values) {
            final locLower = localizedName.toLowerCase();
            if (locLower.startsWith(lowerQuery)) {
              score = 600;
              break;
            } else if (locLower.contains(lowerQuery)) {
              score = 450;
              break;
            }
          }
        }

        // 8. Revelation Place Match ("meccan", "medinan", "মক্কী", "মাদানী")
        if (score == 0) {
          if (record.revelationPlace.startsWith(lowerQuery)) {
            score = 300;
          }
        }
      }

      if (score > 0) {
        scored.add(MapEntry(score, record.surah));
      }
    }

    // Sort descending by relevance score, then ascending by Surah ID
    scored.sort((a, b) {
      final scoreCmp = b.key.compareTo(a.key);
      if (scoreCmp != 0) return scoreCmp;
      return a.value.id.compareTo(b.value.id);
    });

    return scored.map((e) => e.value).toList();
  }

  static final RegExp _latinSurahPrefixRegex = RegExp(r"^(surah|sura)\s+");
  static final RegExp _latinArticlePrefixRegex = RegExp(r"^(al|ar|an|as|at|az|ash|adh|ad)[-_\s]");
  static final RegExp _latinPunctRegex = RegExp(r"[-_'\s\.,`~]");

  static final RegExp _bengaliSurahPrefixRegex = RegExp(r"^সূ?রা\s*");
  static final RegExp _bengaliArticlePrefixRegex = RegExp(r"^(আল|আত|আশ|আন|আর|আয|আদ|আলে|আস|আস্)[-\s']?");
  static final RegExp _bengaliPunctRegex = RegExp(r"[-_'\s\.,`~্]");

  static final RegExp _arabicTashkeelRegex = RegExp(r"[\u064B-\u065F\u0670]");
  static final RegExp _arabicAlefRegex = RegExp(r"[آأإٱ]");
  static final RegExp _arabicAlPrefixRegex = RegExp(r"^ال");
  static final RegExp _numericRegex = RegExp(r"^[0-9১-৯٠-٩]+$");

  /// Normalizes Latin string by stripping "Al-", "Ar-", "An-", accents, apostrophes, hyphens, and spaces.
  static String _normalizeLatin(String text) {
    var result = text.toLowerCase().trim();
    result = result.replaceAll(_latinSurahPrefixRegex, "");
    result = result.replaceAll(_latinArticlePrefixRegex, "");
    result = result.replaceAll(_latinPunctRegex, "");
    result = result
        .replaceAll("â", "a")
        .replaceAll("á", "a")
        .replaceAll("ā", "a")
        .replaceAll("î", "i")
        .replaceAll("í", "i")
        .replaceAll("ī", "i")
        .replaceAll("û", "u")
        .replaceAll("ú", "u")
        .replaceAll("ū", "u");
    return result;
  }

  /// Normalizes Bengali text by stripping prefixes like "সূরা ", "আল-", "আত-", hyphens and punctuation.
  static String _normalizeBengali(String text) {
    var result = text.trim();
    result = result.replaceAll(_bengaliSurahPrefixRegex, "");
    result = result.replaceAll(_bengaliArticlePrefixRegex, "");
    result = result.replaceAll(_bengaliPunctRegex, "");
    return result;
  }

  /// Normalizes Arabic text by stripping diacritics/tashkeel and unifying letter variations.
  static String _normalizeArabic(String text) {
    var result = text.trim();
    result = result.replaceAll(_arabicTashkeelRegex, "");
    result = result.replaceAll(_arabicAlefRegex, "ا");
    result = result.replaceAll("ة", "ه");
    result = result.replaceAll("ى", "ي");
    result = result.replaceAll("ـ", "");
    result = result.replaceAll(_arabicAlPrefixRegex, "");
    return result;
  }

  /// Converts an integer to Bengali digit string (e.g. 2 -> "২").
  static String _toBengaliDigits(int num) {
    const bengaliDigits = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
    return num.toString().split("").map((c) {
      final d = int.tryParse(c);
      return d != null ? bengaliDigits[d] : c;
    }).join("");
  }

  /// Converts an integer to Arabic digit string (e.g. 2 -> "٢").
  static String _toArabicDigits(int num) {
    const arabicDigits = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
    return num.toString().split("").map((c) {
      final d = int.tryParse(c);
      return d != null ? arabicDigits[d] : c;
    }).join("");
  }

  /// Generates common phonetic transliteration variants and keywords for a given Surah.
  static List<String> _generateVariants(
    int surahId,
    String canonicalEn,
    String normalizedEn,
  ) {
    final variants = <String>{};
    variants.add(normalizedEn);
    variants.add(canonicalEn.toLowerCase().replaceAll(RegExp(r"[-_\s]"), ""));

    // Specific famous variants for popular surahs
    switch (surahId) {
      case 1:
        variants.addAll(["fatiha", "fateha", "alfatiha", "alfateha", "opening", "সূচনা", "ফাতিহা"]);
        break;
      case 2:
        variants.addAll(["baqara", "baqarah", "bakara", "cow", "thecow", "kursi", "ayatulkursi", "গাভী", "বাকারা"]);
        break;
      case 3:
        variants.addAll(["imran", "aliimran", "alimran", "aalimran", "ইমরান"]);
        break;
      case 4:
        variants.addAll(["nisa", "women", "annisa", "নিসা", "নারী"]);
        break;
      case 5:
        variants.addAll(["maidah", "maida", "mayidah", "tablespread", "মায়েদা", "মায়িদাহ"]);
        break;
      case 6:
        variants.addAll(["anam", "cattle", "আনআম"]);
        break;
      case 7:
        variants.addAll(["araf", "heights", "আরাফ"]);
        break;
      case 8:
        variants.addAll(["anfal", "spoils", "আনফাল"]);
        break;
      case 9:
        variants.addAll(["tawbah", "tauba", "taubah", "repentance", "তাওবা", "তাওবাহ্"]);
        break;
      case 10:
        variants.addAll(["yunus", "jonah", "ইউনুস"]);
        break;
      case 11:
        variants.addAll(["hud", "হুদ"]);
        break;
      case 12:
        variants.addAll(["yusuf", "joseph", "ইউসুফ"]);
        break;
      case 13:
        variants.addAll(["rad", "thunder", "রাদ"]);
        break;
      case 14:
        variants.addAll(["ibrahim", "abraham", "ইব্রাহীম", "ইব্রাহিম"]);
        break;
      case 15:
        variants.addAll(["hijr", "হিজর"]);
        break;
      case 16:
        variants.addAll(["nahl", "bees", "honeybees", "নাহল", "মৌমাছি"]);
        break;
      case 17:
        variants.addAll(["isra", "baniisrail", "nightjourney", "ইসরা"]);
        break;
      case 18:
        variants.addAll(["kahf", "kahaf", "alkahf", "alkahaf", "cave", "thecave", "কাহফ", "কাহাফ", "গুহা"]);
        break;
      case 19:
        variants.addAll(["maryam", "mary", "মারইয়াম", "মরিয়ম"]);
        break;
      case 20:
        variants.addAll(["taha", "ta-ha", "ত্বাহা", "তাহা"]);
        break;
      case 21:
        variants.addAll(["anbiya", "prophets", "আম্বিয়া", "নবীগণ"]);
        break;
      case 22:
        variants.addAll(["hajj", "pilgrimage", "হজ্জ", "হজ"]);
        break;
      case 23:
        variants.addAll(["muminun", "mumin", "believers", "মুমিনূন", "মুমিন"]);
        break;
      case 24:
        variants.addAll(["nur", "noor", "light", "নূর", "আলো"]);
        break;
      case 25:
        variants.addAll(["furqan", "criterion", "ফুরকান"]);
        break;
      case 26:
        variants.addAll(["shuara", "poets", "শুআরা", "কবিগণ"]);
        break;
      case 27:
        variants.addAll(["naml", "ants", "নামল", "পিপীলিকা"]);
        break;
      case 28:
        variants.addAll(["qasas", "stories", "কাসাস"]);
        break;
      case 29:
        variants.addAll(["ankabut", "spider", "আনকাবূত", "মাকড়সা"]);
        break;
      case 30:
        variants.addAll(["rum", "romans", "রূম", "রোম"]);
        break;
      case 31:
        variants.addAll(["luqman", "লুকমান"]);
        break;
      case 32:
        variants.addAll(["sajdah", "sajda", "prostration", "সাজদাহ", "সিজদা"]);
        break;
      case 33:
        variants.addAll(["ahzab", "combinedforces", "আহযাব"]);
        break;
      case 34:
        variants.addAll(["saba", "sheba", "সাবা"]);
        break;
      case 35:
        variants.addAll(["fatir", "originator", "ফাতির"]);
        break;
      case 36:
        variants.addAll(["yasin", "yaseen", "ya-sin", "yasiin", "ইয়াসীন", "ইয়াসিন"]);
        break;
      case 37:
        variants.addAll(["saffat", "ranks", "সাফফাত"]);
        break;
      case 38:
        variants.addAll(["sad", "সাদ", "সোয়াদ"]);
        break;
      case 39:
        variants.addAll(["zumar", "troops", "যুমার"]);
        break;
      case 40:
        variants.addAll(["ghafir", "mumin", "forgiver", "গাফির"]);
        break;
      case 41:
        variants.addAll(["fussilat", "ফুসসিলাত"]);
        break;
      case 42:
        variants.addAll(["shura", "consultation", "শূরা", "পরামর্শ"]);
        break;
      case 43:
        variants.addAll(["zukhruf", "gold", "যুখরুফ"]);
        break;
      case 44:
        variants.addAll(["dukhan", "smoke", "দুখান", "ধোঁয়া"]);
        break;
      case 45:
        variants.addAll(["jathiyah", "crouching", "জাসিয়াহ"]);
        break;
      case 46:
        variants.addAll(["ahqaf", "sandhills", "আহকাফ"]);
        break;
      case 47:
        variants.addAll(["muhammad", "মুহাম্মাদ", "মুহাম্মদ"]);
        break;
      case 48:
        variants.addAll(["fath", "victory", "ফাতহ", "বিজয়"]);
        break;
      case 49:
        variants.addAll(["hujurat", "rooms", "হুজুরাত"]);
        break;
      case 50:
        variants.addAll(["qaf", "ক্বাফ", "কাফ"]);
        break;
      case 51:
        variants.addAll(["dhariyat", "winds", "যারিয়াত"]);
        break;
      case 52:
        variants.addAll(["tur", "mount", "তুর"]);
        break;
      case 53:
        variants.addAll(["najm", "star", "নাজম", "নক্ষত্র"]);
        break;
      case 54:
        variants.addAll(["qamar", "moon", "কামার", "চাঁদ"]);
        break;
      case 55:
        variants.addAll(["rahman", "rehman", "arrahman", "arrehman", "beneficent", "রাহমান", "রহমান"]);
        break;
      case 56:
        variants.addAll(["waqiah", "waqia", "alwaqiah", "alwaqia", "inevitable", "ওয়াকিয়াহ", "ওয়াক্বিয়াহ"]);
        break;
      case 57:
        variants.addAll(["hadid", "iron", "হাদীদ", "লোহা"]);
        break;
      case 58:
        variants.addAll(["mujadila", "pleading", "মুজাদালাহ"]);
        break;
      case 59:
        variants.addAll(["hashr", "exile", "হাশর"]);
        break;
      case 60:
        variants.addAll(["mumtahanah", "examined", "মুমতাহিনাহ"]);
        break;
      case 61:
        variants.addAll(["saff", "ranks", "সফ"]);
        break;
      case 62:
        variants.addAll(["jumuah", "jumma", "jummah", "friday", "congregation", "জুমুআহ", "জুমা"]);
        break;
      case 63:
        variants.addAll(["munafiqun", "hypocrites", "মুনাফিকূন", "মুনাফিক"]);
        break;
      case 64:
        variants.addAll(["taghabun", "disillusion", "তাগাবুন"]);
        break;
      case 65:
        variants.addAll(["talaq", "divorce", "তালাক"]);
        break;
      case 66:
        variants.addAll(["tahrim", "prohibition", "তাহরীম"]);
        break;
      case 67:
        variants.addAll(["mulk", "almulk", "muluk", "tabarak", "sovereignty", "kingdom", "মুলক"]);
        break;
      case 68:
        variants.addAll(["qalam", "pen", "nun", "কালাম", "কলম"]);
        break;
      case 69:
        variants.addAll(["haqqah", "reality", "হাক্কাহ"]);
        break;
      case 70:
        variants.addAll(["maarij", "stairways", "মাআরিজ"]);
        break;
      case 71:
        variants.addAll(["nuh", "noah", "নূহ"]);
        break;
      case 72:
        variants.addAll(["jinn", "জিন"]);
        break;
      case 73:
        variants.addAll(["muzzammil", "enshrouded", "মুযযাম্মিল"]);
        break;
      case 74:
        variants.addAll(["muddathir", "muddaththir", "cloaked", "মুদ্দাসসির"]);
        break;
      case 75:
        variants.addAll(["qiyamah", "resurrection", "কিয়ামাহ", "কেয়ামত"]);
        break;
      case 76:
        variants.addAll(["insan", "dahr", "man", "ইনসান", "দাহর"]);
        break;
      case 77:
        variants.addAll(["mursalat", "emissaries", "মুরসালাত"]);
        break;
      case 78:
        variants.addAll(["naba", "annaba", "amma", "tidings", "নাবা", "আম্মা"]);
        break;
      case 79:
        variants.addAll(["naziat", "নাযিয়াত"]);
        break;
      case 80:
        variants.addAll(["abasa", "আবাসা"]);
        break;
      case 81:
        variants.addAll(["takwir", "overthrowing", "তাকবীর"]);
        break;
      case 82:
        variants.addAll(["infitar", "cleaving", "ইনফিতার"]);
        break;
      case 83:
        variants.addAll(["mutaffifin", "defrauding", "মুতাফফিফীন"]);
        break;
      case 84:
        variants.addAll(["inshiqaq", "splitting", "ইনশিকাক"]);
        break;
      case 85:
        variants.addAll(["buruj", "stars", "বুরূজ"]);
        break;
      case 86:
        variants.addAll(["tariq", "nightcomer", "তারিক"]);
        break;
      case 87:
        variants.addAll(["ala", "mosthigh", "আলা"]);
        break;
      case 88:
        variants.addAll(["ghashiyah", "overwhelming", "গাশিয়াহ"]);
        break;
      case 89:
        variants.addAll(["fajr", "dawn", "ফজর"]);
        break;
      case 90:
        variants.addAll(["balad", "city", "বালাদ"]);
        break;
      case 91:
        variants.addAll(["shams", "sun", "শামস", "সূর্য"]);
        break;
      case 92:
        variants.addAll(["layl", "lail", "night", "লাইল", "রাত"]);
        break;
      case 93:
        variants.addAll(["duha", "dhuha", "morning", "দুহা", "পূর্বাহ্ণ"]);
        break;
      case 94:
        variants.addAll(["sharh", "inshirah", "relief", "শারহ", "ইনশিরাহ"]);
        break;
      case 95:
        variants.addAll(["tin", "fig", "তীন", "ডুমুর"]);
        break;
      case 96:
        variants.addAll(["alaq", "iqra", "clot", "আলাক", "ইক্বরা"]);
        break;
      case 97:
        variants.addAll(["qadr", "kadr", "power", "nightofpower", "কদর", "শব-ই-কদর"]);
        break;
      case 98:
        variants.addAll(["bayyinah", "proof", "বাইয়্যিনাহ"]);
        break;
      case 99:
        variants.addAll(["zalzalah", "zilzal", "earthquake", "যিলযাল", "ভূমিকম্প"]);
        break;
      case 100:
        variants.addAll(["adiyat", "courser", "আদিয়াত"]);
        break;
      case 101:
        variants.addAll(["qariah", "calamity", "ক্বারিয়াহ"]);
        break;
      case 102:
        variants.addAll(["takathur", "rivalry", "তাকাসুর"]);
        break;
      case 103:
        variants.addAll(["asr", "time", "decliningday", "আসর"]);
        break;
      case 104:
        variants.addAll(["humazah", "traducer", "হুমাযাহ"]);
        break;
      case 105:
        variants.addAll(["fil", "feel", "elephant", "ফীল", "হাতি"]);
        break;
      case 106:
        variants.addAll(["quraysh", "quraish", "কুরাইশ"]);
        break;
      case 107:
        variants.addAll(["maun", "smallkindness", "মাউন"]);
        break;
      case 108:
        variants.addAll(["kawthar", "kawsar", "abundance", "কাওসার"]);
        break;
      case 109:
        variants.addAll(["kafirun", "kafiroon", "disbelievers", "কাফিরূন", "কাফেরুন"]);
        break;
      case 110:
        variants.addAll(["nasr", "help", "নাসর"]);
        break;
      case 111:
        variants.addAll(["masad", "lahab", "palmfibre", "লাহাব", "মাসাদ"]);
        break;
      case 112:
        variants.addAll(["ikhlas", "ekhlas", "tauheed", "tawhid", "qulhuwallah", "sincerity", "ইখলাস", "একত্ববাদ"]);
        break;
      case 113:
        variants.addAll(["falaq", "falak", "alfalaq", "daybreak", "ফালাক"]);
        break;
      case 114:
        variants.addAll(["nas", "naas", "annas", "mankind", "নাস"]);
        break;
    }

    return variants.toList();
  }
}
