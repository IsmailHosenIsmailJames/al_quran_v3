import "package:al_quran_v3/src/features/quran_script_view/domain/utils/tajweed_rules.dart";
import "../models/tajweed_rule_model.dart";

abstract class TajweedGuideLocalDataSource {
  List<TajweedRuleModel> getTajweedRules();
}

class TajweedGuideLocalDataSourceImpl implements TajweedGuideLocalDataSource {
  @override
  List<TajweedRuleModel> getTajweedRules() {
    return const [
      // 1. Ghunnah
      TajweedRuleModel(
        id: "1",
        ruleKey: GhunnahRule.key,
        name: "Ghunnah",
        arabicName: "غُنَّة",
        description:
            "A nasal sound produced from the nose, held for approximately 2 counts. It applies to Noon (ن) and Meem (م) when they carry a Shaddah (نّ, مّ).",
        howToPronounce:
            "Press firmly onto the letter and hold the nasal sound for two counts before releasing.",
        lightColor: GhunnahRule.lightColor,
        darkColor: GhunnahRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "إِ<rule class=\"ghunnah\">نَّ</rule>آ",
            transliteration: "Inna",
            surahAyahRef: "Surah Al-Kawthar 108:1",
            surahNumber: 108,
            ayahNumber: 1,
            wordIndex: 0,
          ),
          TajweedExampleModel(
            arabicText: "ثُ<rule class=\"ghunnah\">مَّ</rule>",
            transliteration: "Thumma",
            surahAyahRef: "Surah At-Takathur 102:3",
            surahNumber: 102,
            ayahNumber: 3,
            wordIndex: 3,
          ),
          TajweedExampleModel(
            arabicText:
                "مِ<rule class=\"ghunnah\">نَ ٱلْجِنَّ</rule>ةِ وَٱل<rule class=\"ghunnah\">نَّ</rule>اسِ",
            transliteration: "Mina al-jinnati wan-naas",
            surahAyahRef: "Surah An-Nas 114:6",
            surahNumber: 114,
            ayahNumber: 6,
            wordIndex: 1,
          ),
        ],
      ),

      // 2. Idgham Shafawi
      TajweedRuleModel(
        id: "2",
        ruleKey: IdghamShafawiRule.key,
        name: "Idgham Shafawi",
        arabicName: "إِدْغَام شَفَوِي",
        description:
            "Occurs when a Meem Sakinah (مْ) is followed by another Meem (م). The two Meems merge completely into a single doubled Meem with Ghunnah.",
        howToPronounce:
            "Close the lips completely and merge the sound into the second Meem, sustaining nasalization for 2 counts.",
        lightColor: IdghamShafawiRule.lightColor,
        darkColor: IdghamShafawiRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "لَكُ<rule class=\"idgham_shafawi\">م مَّ</rule>ا كَسَبْتُمْ",
            transliteration: "Lakum-ma kasabtum",
            surahAyahRef: "Surah Al-Baqarah 2:134",
            surahNumber: 2,
            ayahNumber: 134,
            wordIndex: 7,
          ),
          TajweedExampleModel(
            arabicText: "فِي قُلُوبِهِ<rule class=\"idgham_shafawi\">م مَّ</rule>رَضٌ",
            transliteration: "Fee quloobihim-maradun",
            surahAyahRef: "Surah Al-Baqarah 2:10",
            surahNumber: 2,
            ayahNumber: 10,
            wordIndex: 1,
          ),
        ],
      ),

      // 3. Iqlab
      TajweedRuleModel(
        id: "3",
        ruleKey: IqlabRule.key,
        name: "Iqlab",
        arabicName: "إِقْلَاب",
        description:
            "Occurs when a Noon Sakinah (نْ) or Tanween (ـًـــٍـــٌ) is followed by the letter Ba (ب). The N sound transforms into a hidden Meem (م) with Ghunnah.",
        howToPronounce:
            "Change the 'N' sound to an 'M' sound, keeping light contact between the lips while holding the Ghunnah.",
        lightColor: IqlabRule.lightColor,
        darkColor: IqlabRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "مِ<rule class=\"iqlab\">نۢ بَ</rule>عْدِ",
            transliteration: "Mim-ba'di",
            surahAyahRef: "Surah Al-Baqarah 2:27",
            surahNumber: 2,
            ayahNumber: 27,
            wordIndex: 0,
          ),
          TajweedExampleModel(
            arabicText: "أَ<rule class=\"iqlab\">نۢ بَ</rule>وَّأْنَا",
            transliteration: "Am-bawwa'na",
            surahAyahRef: "Surah Al-Hajj 22:26",
            surahNumber: 22,
            ayahNumber: 26,
            wordIndex: 1,
          ),
        ],
      ),

      // 4. Ikhfa Shafawi
      TajweedRuleModel(
        id: "4",
        ruleKey: IkhafaShafawiRule.key,
        name: "Ikhfa' Shafawi",
        arabicName: "إِخْفَاء شَفَوِي",
        description:
            "Occurs when a Meem Sakinah (مْ) is followed by the letter Ba (ب). The Meem sound is concealed with Ghunnah.",
        howToPronounce:
            "Pronounce the Meem softly with nasalization without tightly pressing the lips together before moving to Ba.",
        lightColor: IkhafaShafawiRule.lightColor,
        darkColor: IkhafaShafawiRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText:
                "تَرْمِيهِ<rule class=\"ikhafa_shafawi\">م بِ</rule>حِجَارَةٍ",
            transliteration: "Tarmeehim-bi-hijarah",
            surahAyahRef: "Surah Al-Fil 105:4",
            surahNumber: 105,
            ayahNumber: 4,
            wordIndex: 0,
          ),
          TajweedExampleModel(
            arabicText: "وَمَا هُ<rule class=\"ikhafa_shafawi\">م بِ</rule>مُؤْمِنِينَ",
            transliteration: "Wama hum-bi-mu'mineen",
            surahAyahRef: "Surah Al-Baqarah 2:8",
            surahNumber: 2,
            ayahNumber: 8,
            wordIndex: 2,
          ),
        ],
      ),

      // 5. Qalqalah
      TajweedRuleModel(
        id: "5",
        ruleKey: QalqalahRule.key,
        name: "Qalqalah",
        arabicName: "قَلْقَلَة",
        description:
            "An echoing or bouncing sound produced when one of the 5 Qalqalah letters (ق, ط, ب, ج, د - Qutb Jad) has a Sukoon (ـْ) or is stopped upon.",
        howToPronounce:
            "Quickly release the articulation point of the letter with a sharp bounce, without creating an extra vowel sound.",
        lightColor: QalqalahRule.lightColor,
        darkColor: QalqalahRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "خَلَ<rule class=\"qalaqah\">قْ</rule>نَا",
            transliteration: "Khalaqna",
            surahAyahRef: "Surah At-Tin 95:4",
            surahNumber: 95,
            ayahNumber: 4,
            wordIndex: 1,
          ),
          TajweedExampleModel(
            arabicText: "يَ<rule class=\"qalaqah\">دْ</rule>عُونَ",
            transliteration: "Yad'oon",
            surahAyahRef: "Surah Al-An'am 6:52",
            surahNumber: 6,
            ayahNumber: 52,
            wordIndex: 3,
          ),
          TajweedExampleModel(
            arabicText: "قُلْ هُوَ ٱللَّهُ أَحَ<rule class=\"qalaqah\">دٌ</rule>",
            transliteration: "Qul huwa Allahu ahad",
            surahAyahRef: "Surah Al-Ikhlas 112:1",
            surahNumber: 112,
            ayahNumber: 1,
            wordIndex: 3,
          ),
        ],
      ),

      // 6. Idgham with Ghunnah
      TajweedRuleModel(
        id: "6",
        ruleKey: IdghamGhunnahRule.key,
        name: "Idgham with Ghunnah",
        arabicName: "إِدْغَام بِغُنَّة",
        description:
            "Occurs when Noon Sakinah (نْ) or Tanween is followed by any of the letters: ي, ن, م, و (Yanmoo). The sound is merged into the letter with a 2-count nasal sound.",
        howToPronounce:
            "Bypass the N sound and blend smoothly into the following letter while holding nasalization.",
        lightColor: IdghamGhunnahRule.lightColor,
        darkColor: IdghamGhunnahRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "مَ<rule class=\"idgham_ghunnah\">ن يَ</rule>قُولُ",
            transliteration: "May-yaqoolu",
            surahAyahRef: "Surah Al-Baqarah 2:8",
            surahNumber: 2,
            ayahNumber: 8,
            wordIndex: 3,
          ),
          TajweedExampleModel(
            arabicText:
                "وُجُوهٌ يَ<rule class=\"idgham_ghunnah\">وۡمَئِذٍ نَّ</rule>اعِمَةٌ",
            transliteration: "Wujoohuny-yawmaidin-na'imah",
            surahAyahRef: "Surah Al-Ghashiyah 88:8",
            surahNumber: 88,
            ayahNumber: 8,
            wordIndex: 0,
          ),
        ],
      ),

      // 7. Idgham without Ghunnah
      TajweedRuleModel(
        id: "7",
        ruleKey: IdghamWoGhunnahRule.key,
        name: "Idgham without Ghunnah",
        arabicName: "إِدْغَام بِلا غُنَّة",
        description:
            "Occurs when Noon Sakinah (نْ) or Tanween is followed by Lam (ل) or Ra (ر). The N sound merges completely into the letter with no nasal sound.",
        howToPronounce:
            "Completely skip the N sound and stress the following Lam or Ra clearly.",
        lightColor: IdghamWoGhunnahRule.lightColor,
        darkColor: IdghamWoGhunnahRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "مِ<rule class=\"idgham_wo_ghunnah\">ن لَّ</rule>دُنْهُ",
            transliteration: "Mil-ladunhu",
            surahAyahRef: "Surah An-Nisa 4:40",
            surahNumber: 4,
            ayahNumber: 40,
            wordIndex: 10,
          ),
          TajweedExampleModel(
            arabicText: "مِ<rule class=\"idgham_wo_ghunnah\">ن رَّ</rule>بِّهِمْ",
            transliteration: "Mir-rabbihim",
            surahAyahRef: "Surah Al-Baqarah 2:5",
            surahNumber: 2,
            ayahNumber: 5,
            wordIndex: 4,
          ),
        ],
      ),

      // 8. Ikhfa
      TajweedRuleModel(
        id: "8",
        ruleKey: IkhafaRule.key,
        name: "Ikhfa'",
        arabicName: "إِخْفَاء",
        description:
            "Occurs when Noon Sakinah (نْ) or Tanween is followed by one of the 15 Ikhfa letters. The N sound is hidden between Izhar and Idgham with a Ghunnah.",
        howToPronounce:
            "Prepare your tongue at the position of the next letter while producing a light nasal sound.",
        lightColor: IkhafaRule.lightColor,
        darkColor: IkhafaRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "ٱلْإِ<rule class=\"ikhafa\">ن</rule>سَٰنُ",
            transliteration: "Al-Insaanu",
            surahAyahRef: "Surah At-Tin 95:4",
            surahNumber: 95,
            ayahNumber: 4,
            wordIndex: 2,
          ),
          TajweedExampleModel(
            arabicText: "عَ<rule class=\"ikhafa\">ن صَ</rule>لَاتِهِمْ",
            transliteration: "'An-salaatihim",
            surahAyahRef: "Surah Al-Ma'un 107:5",
            surahNumber: 107,
            ayahNumber: 5,
            wordIndex: 2,
          ),
        ],
      ),

      // 9. Madd Tabi'i
      TajweedRuleModel(
        id: "9",
        ruleKey: MaddTabiiRule.key,
        name: "Madd Tabi'i",
        arabicName: "مَدّ طَبِيعِي",
        description:
            "The natural prolongation of a vowel for 2 counts. Occurs with Alif after Fatha, Ya after Kasra, or Waw after Dammah.",
        howToPronounce:
            "Extend the vowel sound naturally for two beats, keeping it smooth and unhurried.",
        lightColor: MaddTabiiRule.lightColor,
        darkColor: MaddTabiiRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "قَ<rule class=\"madda_normal\">ا</rule>لَ",
            transliteration: "Qaala",
            surahAyahRef: "Surah Al-Baqarah 2:30",
            surahNumber: 2,
            ayahNumber: 30,
            wordIndex: 1,
          ),
          TajweedExampleModel(
            arabicText: "قِ<rule class=\"madda_normal\">ي</rule>لَ",
            transliteration: "Qeela",
            surahAyahRef: "Surah Al-Baqarah 2:11",
            surahNumber: 2,
            ayahNumber: 11,
            wordIndex: 1,
          ),
          TajweedExampleModel(
            arabicText: "يَقُ<rule class=\"madda_normal\">و</rule>لُ",
            transliteration: "Yaqoolu",
            surahAyahRef: "Surah Al-Baqarah 2:8",
            surahNumber: 2,
            ayahNumber: 8,
            wordIndex: 4,
          ),
        ],
      ),

      // 10. Madd Lazim
      TajweedRuleModel(
        id: "10",
        ruleKey: MaddLazimRule.key,
        name: "Madd Lazim",
        arabicName: "مَدّ لازِم",
        description:
            "Compulsory prolongation held for 6 counts. Occurs when a Madd letter is followed by an original Sukoon or Shaddah in the same word.",
        howToPronounce:
            "Elongate the vowel sound significantly for a full six counts.",
        lightColor: MaddLazimRule.lightColor,
        darkColor: MaddLazimRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText:
                "وَلاَ ٱلضَّ<rule class=\"madda_necessary\">آ</rule>لِّينَ",
            transliteration: "Wala ad-daalleen",
            surahAyahRef: "Surah Al-Fatihah 1:7",
            surahNumber: 1,
            ayahNumber: 7,
            wordIndex: 8,
          ),
          TajweedExampleModel(
            arabicText: "ٱلْحَ<rule class=\"madda_necessary\">آ</rule>قَّةُ",
            transliteration: "Al-Haaqqah",
            surahAyahRef: "Surah Al-Haaqqah 69:1",
            surahNumber: 69,
            ayahNumber: 1,
            wordIndex: 0,
          ),
        ],
      ),

      // 11. Madd Leen
      TajweedRuleModel(
        id: "11",
        ruleKey: MaddLeenRule.key,
        name: "Madd Leen",
        arabicName: "مَدّ لِين",
        description:
            "Soft prolongation occurring when Waw (و) or Ya (ي) carrying a Sukoon is preceded by Fatha and followed by a letter stopped upon.",
        howToPronounce:
            "Gently extend the 'aw' or 'ay' sound for 2, 4, or 6 counts when pausing on the word.",
        lightColor: MaddLeenRule.lightColor,
        darkColor: MaddLeenRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "خَ<rule class=\"madda_permissible\">وۡ</rule>فٍ",
            transliteration: "Khawf",
            surahAyahRef: "Surah Quraysh 106:4",
            surahNumber: 106,
            ayahNumber: 4,
            wordIndex: 3,
          ),
          TajweedExampleModel(
            arabicText: "ٱلْبَ<rule class=\"madda_permissible\">يۡ</rule>تِ",
            transliteration: "Al-Bayt",
            surahAyahRef: "Surah Quraysh 106:3",
            surahNumber: 106,
            ayahNumber: 3,
            wordIndex: 4,
          ),
        ],
      ),

      // 12. Madd Wajib Muttasil
      TajweedRuleModel(
        id: "12",
        ruleKey: MaddWajibMuttasilRule.key,
        name: "Madd Wajib Muttasil",
        arabicName: "مَدّ وَاجِب مُتَّصِل",
        description:
            "Obligatory connected elongation stretched for 4 or 5 counts. Occurs when a Madd letter and Hamzah (ء) appear in the same word.",
        howToPronounce:
            "Elongate the vowel sound steadily for 4 to 5 counts before pronouncing the Hamzah.",
        lightColor: MaddWajibMuttasilRule.lightColor,
        darkColor: MaddWajibMuttasilRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText:
                "ٱلسَّمَ<rule class=\"madda_obligatory_mottasel\">آ</rule>ءِ",
            transliteration: "As-Samaa'",
            surahAyahRef: "Surah Al-Baqarah 2:19",
            surahNumber: 2,
            ayahNumber: 19,
            wordIndex: 3,
          ),
          TajweedExampleModel(
            arabicText:
                "جَ<rule class=\"madda_obligatory_mottasel\">آ</rule>ءَ",
            transliteration: "Jaa'a",
            surahAyahRef: "Surah An-Nasr 110:1",
            surahNumber: 110,
            ayahNumber: 1,
            wordIndex: 1,
          ),
        ],
      ),

      // 13. Madd Ja'iz Munfasil
      TajweedRuleModel(
        id: "13",
        ruleKey: MaddJaizMunfasilRule.key,
        name: "Madd Ja'iz Munfasil",
        arabicName: "مَدّ جَائِز مُنْفَصِل",
        description:
            "Permissible separate elongation stretched for 4 or 5 counts. Occurs when a Madd letter ends a word and Hamzah starts the next word.",
        howToPronounce:
            "Stretches for 4 to 5 counts when continuing recitation smoothly into the next word.",
        lightColor: MaddJaizMunfasilRule.lightColor,
        darkColor: MaddJaizMunfasilRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText:
                "يَ<rule class=\"madda_obligatory_monfasel\">آ</rule> أَيُّهَا",
            transliteration: "Yaa ayyuha",
            surahAyahRef: "Surah Al-Baqarah 2:21",
            surahNumber: 2,
            ayahNumber: 21,
            wordIndex: 0,
          ),
          TajweedExampleModel(
            arabicText:
                "فِ<rule class=\"madda_obligatory_monfasel\">ي</rule> أَحْسَنِ",
            transliteration: "Fee ahsan",
            surahAyahRef: "Surah At-Tin 95:4",
            surahNumber: 95,
            ayahNumber: 4,
            wordIndex: 3,
          ),
        ],
      ),

      // 14. Hamzat al-Wasl
      TajweedRuleModel(
        id: "14",
        ruleKey: HamWaslRule.key,
        name: "Hamzat al-Wasl",
        arabicName: "هَمْزَةُ الْوَصْلِ",
        description:
            "Connecting Hamzah pronounced only when beginning recitation with the word, but dropped/silent when connecting from the preceding word.",
        howToPronounce:
            "Pronounce as 'A', 'I', or 'U' if starting the sentence here. Skip completely if continuing from previous word.",
        lightColor: HamWaslRule.lightColor,
        darkColor: HamWaslRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "<rule class=\"ham_wasl\">ٱ</rule>هْدِنَا",
            transliteration: "Ihdina (when starting)",
            surahAyahRef: "Surah Al-Fatihah 1:6",
            surahNumber: 1,
            ayahNumber: 6,
            wordIndex: 0,
          ),
          TajweedExampleModel(
            arabicText: "<rule class=\"ham_wasl\">ٱ</rule>لْحَمْدُ",
            transliteration: "Al-Hamdu (when starting)",
            surahAyahRef: "Surah Al-Fatihah 1:2",
            surahNumber: 1,
            ayahNumber: 2,
            wordIndex: 0,
          ),
        ],
      ),

      // 15. Lam Shamsiyyah
      TajweedRuleModel(
        id: "15",
        ruleKey: LaamShamsiyahRule.key,
        name: "Lam Shamsiyyah",
        arabicName: "لاَّم شَمْسِيَّة",
        description:
            "The Lam in the definite article 'Al' (ال) becomes silent when followed by any of the 14 Sun letters, and the Sun letter gets a Shaddah.",
        howToPronounce:
            "Bypass the sound of the Lam completely and stress the following Sun letter.",
        lightColor: LaamShamsiyahRule.lightColor,
        darkColor: LaamShamsiyahRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText:
                "<rule class=\"ham_wasl\">ٱ</rule><rule class=\"laam_shamsiyah\">ل</rule>شَّمْسُ",
            transliteration: "Ash-Shamsu",
            surahAyahRef: "Surah Ash-Shams 91:1",
            surahNumber: 91,
            ayahNumber: 1,
            wordIndex: 0,
          ),
          TajweedExampleModel(
            arabicText:
                "<rule class=\"ham_wasl\">ٱ</rule><rule class=\"laam_shamsiyah\">ل</rule>رَّحْمَٰنِ",
            transliteration: "Ar-Rahmaan",
            surahAyahRef: "Surah Al-Fatihah 1:1",
            surahNumber: 1,
            ayahNumber: 1,
            wordIndex: 2,
          ),
        ],
      ),

      // 16. Silent Letter
      TajweedRuleModel(
        id: "16",
        ruleKey: SlntRule.key,
        name: "Silent Letter",
        arabicName: "حَرْفُ زَائِد",
        description:
            "A letter present in the written Uthmani script that is omitted during pronunciation in recitation.",
        howToPronounce:
            "Do not pronounce this letter under any circumstance; skip over it.",
        lightColor: SlntRule.lightColor,
        darkColor: SlntRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "قَالُ<rule class=\"slnt\">و۟</rule>",
            transliteration: "Qaaloo",
            surahAyahRef: "Surah Al-Baqarah 2:11",
            surahNumber: 2,
            ayahNumber: 11,
            wordIndex: 1,
          ),
          TajweedExampleModel(
            arabicText: "آمَنُ<rule class=\"slnt\">و۟</rule>",
            transliteration: "Aamanoo",
            surahAyahRef: "Surah Al-Baqarah 2:9",
            surahNumber: 2,
            ayahNumber: 9,
            wordIndex: 1,
          ),
        ],
      ),

      // 17. Idgham Mutajanisayn
      TajweedRuleModel(
        id: "17",
        ruleKey: IdghamMutajanisaynRule.key,
        name: "Idgham Mutajanisayn",
        arabicName: "إِدْغَام مُتَجَانِسَيْن",
        description:
            "Merging of two letters that share the exact same point of articulation (Makhraj) but differ in characteristics (Sifat).",
        howToPronounce:
            "Skip the first letter completely and merge directly into the second letter with emphasis.",
        lightColor: IdghamMutajanisaynRule.lightColor,
        darkColor: IdghamMutajanisaynRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText:
                "قَ<rule class=\"idgham_mutajanisayn\">د تَّ</rule>بَيَّنَ",
            transliteration: "Qat-tabayyana",
            surahAyahRef: "Surah Al-Baqarah 2:256",
            surahNumber: 2,
            ayahNumber: 256,
            wordIndex: 1,
          ),
          TajweedExampleModel(
            arabicText:
                "أَثْقَلَ<rule class=\"idgham_mutajanisayn\">ت دَّ</rule>عَوَا",
            transliteration: "Athqalat-da'awaa",
            surahAyahRef: "Surah Al-A'raf 7:189",
            surahNumber: 7,
            ayahNumber: 189,
            wordIndex: 13,
          ),
        ],
      ),

      // 18. Idgham Mutaqaribayn
      TajweedRuleModel(
        id: "18",
        ruleKey: IdghamMutaqaribaynRule.key,
        name: "Idgham Mutaqaribayn",
        arabicName: "إِدْغَام مُتَقَارِبَيْن",
        description:
            "Merging of two consecutive letters that have close articulation points and characteristics (such as Qaf into Kaf, or Lam into Ra).",
        howToPronounce:
            "Merge the first letter smoothly into the second letter.",
        lightColor: IdghamMutaqaribaynRule.lightColor,
        darkColor: IdghamMutaqaribaynRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText:
                "أَلَمْ نَخْلُ<rule class=\"idgham_mutaqaribayn\">قكُّ</rule>م",
            transliteration: "Alam nakhlukkum",
            surahAyahRef: "Surah Al-Mursalat 77:20",
            surahNumber: 77,
            ayahNumber: 20,
            wordIndex: 1,
          ),
          TajweedExampleModel(
            arabicText:
                "وَقُ<rule class=\"idgham_mutaqaribayn\">ل رَّ</rule>بِّ",
            transliteration: "Waqur-rabbi",
            surahAyahRef: "Surah Taha 20:114",
            surahNumber: 20,
            ayahNumber: 114,
            wordIndex: 1,
          ),
        ],
      ),

      // 19. Alif Maqsurah
      TajweedRuleModel(
        id: "19",
        ruleKey: CustomAlefMaksoraRule.key,
        name: "Alif Maqsurah",
        arabicName: "أَلِف مَقْصُورَة",
        description:
            "A dotless Ya (ى) appearing at the end of a word, pronounced as a short natural Alif (Madd Tabi'i).",
        howToPronounce:
            "Pronounce as a natural open 'aa' sound for 2 counts.",
        lightColor: CustomAlefMaksoraRule.lightColor,
        darkColor: CustomAlefMaksoraRule.darkColor,
        examples: [
          TajweedExampleModel(
            arabicText: "مُوسَ<rule class=\"custom-alef-maksora\">ىٰ</rule>",
            transliteration: "Musa",
            surahAyahRef: "Surah Al-Baqarah 2:51",
            surahNumber: 2,
            ayahNumber: 51,
            wordIndex: 2,
          ),
          TajweedExampleModel(
            arabicText: "عِيسَ<rule class=\"custom-alef-maksora\">ىٰ</rule>",
            transliteration: "Eesa",
            surahAyahRef: "Surah Al-Baqarah 2:87",
            surahNumber: 2,
            ayahNumber: 87,
            wordIndex: 2,
          ),
        ],
      ),
    ];
  }
}
