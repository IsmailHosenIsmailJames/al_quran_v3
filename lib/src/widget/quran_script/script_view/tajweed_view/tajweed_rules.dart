import "package:flutter/material.dart";

import "color/tajweed_dark.dart";
import "color/tajweed_light.dart";

/// A utility class to access all Tajweed rule definitions.
class TajweedRules {
  /// A list of all Tajweed rule definition classes.
  /// You can iterate over this list to get all rule details.
  static const List<Type> all = [
    GhunnahRule,
    IdghamShafawiRule,
    IqlabRule,
    IkhafaShafawiRule,
    QalqalahRule,
    IdghamGhunnahRule,
    IdghamWoGhunnahRule,
    IkhafaRule,
    MaddTabiiRule,
    MaddLazimRule,
    MaddLeenRule,
    MaddWajibMuttasilRule,
    MaddJaizMunfasilRule,
    HamWaslRule,
    LaamShamsiyahRule,
    SlntRule,
    IdghamMutajanisaynRule,
    IdghamMutaqaribaynRule,
    CustomAlefMaksoraRule,
  ];
}

// 1. Ghunnah
class GhunnahRule {
  static const Color lightColor = lightGhunnah;
  static const Color darkColor = darkGhunnah;
  static const String key = "ghunnah";
  static const String description = """
  <b>Ghunnah (Nasalization)</b>
  <p>A nasal sound produced from the nose, held for approximately 2 counts. It applies to the letters <b>Noon (ن)</b> and <b>Meem (م)</b> when they have a Shaddah (Example: <b>نّ</b>, <b>مّ</b>).</p>
  <p><b>How to pronounce:</b> Press onto the letter and hold the nasal sound for a noticeable duration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>إِنَّ</span> (Inna), <span style='font-family:QPC_Hafs'>ثُمَّ</span> (Thumma)</p>
  """;
}

// 2. Idgham Shafawi
class IdghamShafawiRule {
  static const Color lightColor = lightIdghamShafawi;
  static const Color darkColor = darkIdghamShafawi;
  static const String key = "idgham_shafawi";
  static const String description = """
  <b>Idgham Shafawi (Lip-to-Lip Merging)</b>
  <p>This rule applies to <b>Meem Sakinah (مْ)</b> followed by another <b>Meem (م)</b>. The two Meems are merged into one with a Ghunnah.</p>
  <p><b>How to pronounce:</b> Merge the first Meem into the second and hold the nasal sound.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>لَكُم مَّا</span> (Lakum-ma)</p>
  """;
}

// 3. Iqlab
class IqlabRule {
  static const Color lightColor = lightIqlab;
  static const Color darkColor = darkIqlab;
  static const String key = "iqlab";
  static const String description = """
  <b>Iqlab (Transformation)</b>
  <p>Occurs when <b>Noon Sakinah (نْ)</b> or <b>Tanween (ـًـــٍـــٌ)</b> is followed by the letter <b>Ba (ب)</b>. The 'N' sound turns into a hidden <b>Meem (م)</b> with Ghunnah.</p>
  <p><b>How to pronounce:</b> Change the 'N' sound to an 'M' sound and hold with nasalization.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>مِن بَعْدِ</span> (Mim-ba'd)</p>
  """;
}

// 4. Ikhafa Shafawi
class IkhafaShafawiRule {
  static const Color lightColor = lightIkhafaShafawi;
  static const Color darkColor = darkIkhafaShafawi;
  static const String key = "ikhafa_shafawi";
  static const String description = """
  <b>Ikhfa' Shafawi (Lip-to-Lip Hiding)</b>
  <p>This rule applies to <b>Meem Sakinah (مْ)</b> followed by the letter <b>Ba (ب)</b>. The Meem is concealed slightly with a Ghunnah.</p>
  <p><b>How to pronounce:</b> Pronounce the Meem softly with a light nasal sound, keeping the lips in light contact or with a tiny gap before the Ba.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>تَرْمِيهِم بِحِجَارَةٍ</span> (Tarmeehim-bi-hijarah)</p>
  """;
}

// 5. Qalqalah
class QalqalahRule {
  static const Color lightColor = lightQalaqah;
  static const Color darkColor = darkQalaqah;
  static const String key = "qalaqah";
  static const String description = """
  <b>Qalqalah (Echoing / Bouncing)</b>
  <p>A bouncing or echoing sound made on the letters <b>ق ط ب ج د</b> (Mnemonic: 'Qutb Jad') when they have a Sukoon (ـْ).</p>
  <p><b>How to pronounce:</b> Make a quick bounce on the letter without adding a vowel sound, like a strong vibration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>يَدْعُونَ</span>, <span style='font-family:QPC_Hafs'>خَلَقْنَا</span></p>
  """;
}

// 6. Idgham with Ghunnah
class IdghamGhunnahRule {
  static const Color lightColor = lightIdghamGhunnah;
  static const Color darkColor = darkIdghamGhunnah;
  static const String key = "idgham_ghunnah";
  static const String description = """
  <b>Idgham with Ghunnah (Merging with Nasalization)</b>
  <p>Applies to <b>Noon Sakinah (نْ)</b> or <b>Tanween</b> followed by <b>ي ن م و</b>. The Noon sound is merged into the next letter with a Ghunnah (2 counts).</p>
  <p><b>How to pronounce:</b> Skip the 'N' and direct the sound into the nose while pronouncing the next letter.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>مَن يَقُولُ</span> (May-yaqool)</p>
  """;
}

// 7. Idgham without Ghunnah
class IdghamWoGhunnahRule {
  static const Color lightColor = lightIdghamWoGhunnah;
  static const Color darkColor = darkIdghamWoGhunnah;
  static const String key = "idgham_wo_ghunnah";
  static const String description = """
  <b>Idgham without Ghunnah (Merging without Nasalization)</b>
  <p>Applies to <b>Noon Sakinah (نْ)</b> or <b>Tanween</b> followed by <b>ل (Lam)</b> or <b>ر (Ra)</b>. The Noon sound is completely merged into the next letter.</p>
  <p><b>How to pronounce:</b> Skip the 'N' completely and stress the next letter. No nasal sound.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>مِن لَدُنْهُ</span> (Mil-ladunhu)</p>
  """;
}

// 8. Ikhafa
class IkhafaRule {
  static const Color lightColor = lightIkhafa;
  static const Color darkColor = darkIkhafa;
  static const String key = "ikhafa";
  static const String description = """
  <b>Ikhfa' (Hiding)</b>
  <p>Applies to <b>Noon Sakinah (نْ)</b> or <b>Tanween</b> followed by one of the 15 Ikhfa letters. The Noon sound is hidden with a Ghunnah.</p>
  <p><b>How to pronounce:</b> Create a sound between Izhar (clarity) and Idgham (merging), holding a nasal sound. Prepare your mouth for the next letter.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>الإِنسَانُ</span> (Al-Insaan)</p>
  """;
}

// 9. Madd Tabi'i (Normal)
class MaddTabiiRule {
  static const Color lightColor = lightMaddaNormal;
  static const Color darkColor = darkMaddaNormal;
  static const String key = "madda_normal";
  static const String description = """
  <b>Madd Tabi'i (Natural Madd)</b>
  <p>The natural stretch of a vowel sound for <b>2 counts</b>. Occurs with Alif (after Fatha), Ya (after Kasra), or Waw (after Dammah).</p>
  <p><b>How to pronounce:</b> Elongate the vowel naturally, not too short and not too long.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>قَالَ</span> (Qaala)</p>
  """;
}

// 10. Madd Lazim (Necessary)
class MaddLazimRule {
  static const Color lightColor = lightMaddaNecessary;
  static const Color darkColor = darkMaddaNecessary;
  static const String key = "madda_necessary";
  static const String description = """
  <b>Madd Lazim (Compulsory Madd)</b>
  <p>The longest stretch, held for <b>6 counts</b> (full length). Occurs when a Madd letter is followed by a permanent Sukoon or Shaddah.</p>
  <p><b>How to pronounce:</b> Elongate the vowel sound significantly (approx. 3x normal length).</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>الضَّالِّينَ</span> (Ad-Daalleen)</p>
  """;
}

// 11. Madd Leen (Permissible)
class MaddLeenRule {
  static const Color lightColor = lightMaddaPermissible;
  static const Color darkColor = darkMaddaPermissible;
  static const String key = "madda_permissible";
  static const String description = """
  <b>Madd Leen (Soft Madd)</b>
  <p>Occurs when Waw or Ya with Sukoon are preceded by a Fatha, and followed by a stopped letter. Stretched for 2, 4, or 6 counts when stopping.</p>
  <p><b>How to pronounce:</b> Elongate the 'aw' or 'ay' sound smoothly when stopping.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>خَوْفٌ</span> (Khawf), <span style='font-family:QPC_Hafs'>الْبَيْتِ</span> (Bayt)</p>
  """;
}

// 12. Madd Wajib Muttasil (Obligatory Connected)
class MaddWajibMuttasilRule {
  static const Color lightColor = lightMaddaObligatoryMottasel;
  static const Color darkColor = darkMaddaObligatoryMottasel;
  static const String key = "madda_obligatory_mottasel";
  static const String description = """
  <b>Madd Wajib Muttasil (Obligatory Connected Madd)</b>
  <p>Stretched for <b>4 or 5 counts</b>. Occurs when a Madd letter is followed by a Hamzah (ء) in the <b>same word</b>.</p>
  <p><b>How to pronounce:</b> Elongate the vowel for a medium-long duration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>السَّمَاءِ</span> (As-Samaa')</p>
  """;
}

// 13. Madd Ja'iz Munfasil (Permissible Separate)
class MaddJaizMunfasilRule {
  static const Color lightColor = lightMaddaObligatoryMonfasel;
  static const Color darkColor = darkMaddaObligatoryMonfasel;
  static const String key = "madda_obligatory_monfasel";
  static const String description = """
  <b>Madd Ja'iz Munfasil (Permissible Separate Madd)</b>
  <p>Stretched for <b>4 or 5 counts</b>. Occurs when a Madd letter is at the end of a word, and Hamzah (ء) is at the start of the next.</p>
  <p><b>How to pronounce:</b> Elongate the vowel for a medium-long duration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>يَا أَيُّهَا</span> (Yaa-Ayyuha)</p>
  """;
}

// 14. Hamzat al-Wasl
class HamWaslRule {
  static const Color lightColor = lightHamWasl;
  static const Color darkColor = darkHamWasl;
  static const String key = "ham_wasl";
  static const String description = """
  <b>Hamzat al-Wasl (Connecting Hamzah)</b>
  <p>Pronounced only when starting a word, but silent when connecting from the previous word.</p>
  <p><b>How to pronounce:</b> Pronounce as 'A', 'I', or 'U' if starting the sentence. Skip if continuing.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>ٱهْدِنَا</span> (Ihdina - if starting)</p>
  """;
}

// 15. Lam Shamsiyyah
class LaamShamsiyahRule {
  static const Color lightColor = lightLaamShamsiyah;
  static const Color darkColor = darkLaamShamsiyah;
  static const String key = "laam_shamsiyah";
  static const String description = """
  <b>Lam Shamsiyyah (Sun Letter Lam)</b>
  <p>The 'L' in 'Al' (ال) is silent when followed by a Sun Letter. The Sun Letter gets a Shaddah.</p>
  <p><b>How to pronounce:</b> Skip the 'L' and stress the next letter.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>الشَّمْسُ</span> (Ash-Shamsu)</p>
  """;
}

// 16. Silent Letter
class SlntRule {
  static const Color lightColor = lightSlnt;
  static const Color darkColor = darkSlnt;
  static const String key = "slnt";
  static const String description = """
  <b>Silent Letter</b>
  <p>A letter written in the script but not pronounced.</p>
  <p><b>How to pronounce:</b> Ignore this letter completely.</p>
  <p><b>Example:</b> The final Alif in <span style='font-family:QPC_Hafs'>قَالُوا۟</span></p>
  """;
}

// 17. Idgham Mutajanisayn
class IdghamMutajanisaynRule {
  static const Color lightColor = lightIdghamMutajanisayn;
  static const Color darkColor = darkIdghamMutajanisayn;
  static const String key = "idgham_mutajanisayn";
  static const String description = """
  <b>Idgham Mutajanisayn (Homogeneous Merging)</b>
  <p>Merging two letters with the same articulation point but different attributes.</p>
  <p><b>How to pronounce:</b> Skip the first letter and stress the second.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>قَد تَبَيَّنَ</span> (Qat-tabayyana)</p>
  """;
}

// 18. Idgham Mutaqaribayn
class IdghamMutaqaribaynRule {
  static const Color lightColor = lightIdghamMutaqaribayn;
  static const Color darkColor = darkIdghamMutaqaribayn;
  static const String key = "idgham_mutaqaribayn";
  static const String description = """
  <b>Idgham Mutaqaribayn (Similar Merging)</b>
  <p>Merging two letters with close articulation points.</p>
  <p><b>How to pronounce:</b> Skip the first letter and stress the second.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>أَلَمْ نَخْلُقكُّم</span> (Nakhlukkum)</p>
  """;
}

// 19. Custom Alef Maksora
class CustomAlefMaksoraRule {
  static const Color lightColor = lightCustomAlefMaksora;
  static const Color darkColor = darkCustomAlefMaksora;
  static const String key = "custom-alef-maksora";
  static const String description = """
  <b>Alif Maqsurah (Shortened Alif)</b>
  <p>A dotless Ya (ى) pronounced as a short Alif (Madd Tabi'i).</p>
  <p><b>How to pronounce:</b> Standard 'aa' vowel sound.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>مُوسَىٰ</span> (Musa)</p>
  """;
}
