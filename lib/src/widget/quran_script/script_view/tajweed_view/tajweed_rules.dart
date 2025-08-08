import 'package:flutter/material.dart';

import 'color/tajweed_dark.dart';
import 'color/tajweed_light.dart';

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
  <p>A nasal sound held for approximately two counts. It is applied to the letters <b>نّ (Noon with Shaddah)</b> and <b>مّ (Meem with Shaddah)</b>.</p>
  <p><b>How to pronounce:</b> Direct the sound through your nose for a noticeable duration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>إِنَّ</span>, <span style='font-family:QPC_Hafs'>ثُمَّ</span></p>
  """;
}

// 2. Idgham Shafawi
class IdghamShafawiRule {
  static const Color lightColor = lightIdghamShafawi;
  static const Color darkColor = darkIdghamShafawi;
  static const String key = "idgham_shafawi";
  static const String description = """
  <b>Idgham Shafawi (Lip-to-Lip Merging)</b>
  <p>This rule applies to <b>Meem Sakinah (مْ)</b>. When a Meem Sakinah is followed by another <b>Meem (م)</b>, the two Meems are merged and pronounced with a Ghunnah (nasalization).</p>
  <p><b>How to pronounce:</b> Merge the first Meem into the second and hold the sound with nasalization.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>لَكُم مَّا</span></p>
  """;
}

// 3. Iqlab
class IqlabRule {
  static const Color lightColor = lightIqlab;
  static const Color darkColor = darkIqlab;
  static const String key = "iqlab";
  static const String description = """
  <b>Iqlab (Flipping)</b>
  <p>This rule applies to <b>Noon Sakinah (نْ)</b> or <b>Tanween (ـًـــٍـــٌ)</b>. When either is followed by the letter <b>ب (Ba)</b>, the Noon sound is flipped into a light <b>Meem (م)</b> sound with a Ghunnah.</p>
  <p><b>How to pronounce:</b> Change the 'n' sound to an 'm' sound and hold with nasalization.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>مِن بَعْدِ</span></p>
  """;
}

// 4. Ikhafa Shafawi
class IkhafaShafawiRule {
  static const Color lightColor = lightIkhafaShafawi;
  static const Color darkColor = darkIkhafaShafawi;
  static const String key = "ikhafa_shafawi";
  static const String description = """
  <b>Ikhfa' Shafawi (Lip-to-Lip Hiding)</b>
  <p>This rule applies to <b>Meem Sakinah (مْ)</b>. When it is followed by the letter <b>ب (Ba)</b>, the Meem is pronounced lightly with a Ghunnah, keeping the lips gently together.</p>
  <p><b>How to pronounce:</b> Pronounce the Meem softly with a light nasal sound before pronouncing the Ba.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>تَرْمِيهِم بِحِجَارَةٍ</span></p>
  """;
}

// 5. Qalqalah
class QalqalahRule {
  static const Color lightColor = lightQalaqah;
  static const Color darkColor = darkQalaqah;
  static const String key = "qalaqah";
  static const String description = """
  <b>Qalqalah (Echo / Bouncing)</b>
  <p>A bouncing or echoing sound made on certain letters when they have a Sukoon (ـْ). The letters are <b>ق ط ب ج د</b> (mnemonic: قُطْبُ جَدٍّ).</p>
  <p><b>How to pronounce:</b> Create a slight vibration or bounce on the letter without adding a vowel.</p>
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
  <p>Applies to <b>Noon Sakinah (نْ)</b> or <b>Tanween</b> followed by one of the letters <b>ي ن م و</b> (mnemonic: يَنْمُو). The Noon sound is merged into the following letter and pronounced with Ghunnah.</p>
  <p><b>How to pronounce:</b> Skip the 'n' sound and merge it into the next letter while holding a nasal sound.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>مَن يَقُولُ</span></p>
  """;
}

// 7. Idgham without Ghunnah
class IdghamWoGhunnahRule {
  static const Color lightColor = lightIdghamWoGhunnah;
  static const Color darkColor = darkIdghamWoGhunnah;
  static const String key = "idgham_wo_ghunnah";
  static const String description = """
  <b>Idgham without Ghunnah (Merging without Nasalization)</b>
  <p>Applies to <b>Noon Sakinah (نْ)</b> or <b>Tanween</b> followed by the letters <b>ل (Lam)</b> or <b>ر (Ra)</b>. The Noon sound is completely merged into the following letter without any nasalization.</p>
  <p><b>How to pronounce:</b> The 'n' sound is silent, and the next letter is stressed.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>مِن لَدُنْهُ</span>, <span style='font-family:QPC_Hafs'>غَفُورٌ رَحِيمٌ</span></p>
  """;
}

// 8. Ikhafa
class IkhafaRule {
  static const Color lightColor = lightIkhafa;
  static const Color darkColor = darkIkhafa;
  static const String key = "ikhafa";
  static const String description = """
  <b>Ikhfa' (Hiding)</b>
  <p>Applies to <b>Noon Sakinah (نْ)</b> or <b>Tanween</b> followed by one of the 15 remaining letters of the alphabet. The Noon sound is hidden or partially pronounced with a light Ghunnah, preparing the mouth for the next letter.</p>
  <p><b>How to pronounce:</b> Lightly touch the articulation point of the Noon, creating a subtle nasal sound before moving to the next letter.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>الإِنسَانُ</span></p>
  """;
}

// 9. Madd Tabi'i (Normal)
class MaddTabiiRule {
  static const Color lightColor = lightMaddaNormal;
  static const Color darkColor = darkMaddaNormal;
  static const String key = "madda_normal";
  static const String description = """
  <b>Madd Tabi'i (Normal Stretch)</b>
  <p>The natural stretch of a vowel sound for two counts. It occurs when a Fatha is followed by an Alif (ـَا), a Kasra by a Ya' Sakinah (ـِي), or a Dammah by a Waw Sakinah (ـُو).</p>
  <p><b>How to pronounce:</b> Elongate the vowel sound for a short duration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>قَالَ</span>, <span style='font-family:QPC_Hafs'>قِيلَ</span>, <span style='font-family:QPC_Hafs'>يَقُولُ</span></p>
  """;
}

// 10. Madd Lazim (Necessary)
class MaddLazimRule {
  static const Color lightColor = lightMaddaNecessary;
  static const Color darkColor = darkMaddaNecessary;
  static const String key = "madda_necessary";
  static const String description = """
  <b>Madd Lazim (Necessary Stretch)</b>
  <p>The longest stretch, held for six counts. It occurs when a Madd letter is followed by a letter with a permanent Sukoon (or a Shaddah, which contains a sukoon).</p>
  <p><b>How to pronounce:</b> Elongate the vowel sound for a full six counts.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>الضَّالِّينَ</span>, <span style='font-family:QPC_Hafs'>الْحَاقَّةُ</span></p>
  """;
}

// 11. Madd Leen (Permissible)
class MaddLeenRule {
  static const Color lightColor = lightMaddaPermissible;
  static const Color darkColor = darkMaddaPermissible;
  static const String key = "madda_permissible";
  static const String description = """
  <b>Madd Leen (Easy Stretch)</b>
  <p>Occurs when a Waw Sakinah (وْ) or Ya Sakinah (يْ) is preceded by a Fatha and followed by a letter that is being stopped upon (temporary sukoon). It can be stretched for 2, 4, or 6 counts.</p>
  <p><b>How to pronounce:</b> Elongate the 'aw' or 'ay' sound when stopping at the end of an ayah.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>خَوْفٌ</span> (when stopping), <span style='font-family:QPC_Hafs'>الْبَيْتِ</span> (when stopping).</p>
  """;
}

// 12. Madd Wajib Muttasil (Obligatory Connected)
class MaddWajibMuttasilRule {
  static const Color lightColor = lightMaddaObligatoryMottasel;
  static const Color darkColor = darkMaddaObligatoryMottasel;
  static const String key = "madda_obligatory_mottasel";
  static const String description = """
  <b>Madd Wajib Muttasil (Obligatory Connected Stretch)</b>
  <p>A stretch of 4 or 5 counts. It occurs when a Madd letter is followed by a Hamzah (ء) within the same word.</p>
  <p><b>How to pronounce:</b> Elongate the vowel for a medium-long duration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>جَاءَ</span>, <span style='font-family:QPC_Hafs'>السَّمَاءِ</span></p>
  """;
}

// 13. Madd Ja'iz Munfasil (Permissible Separate)
class MaddJaizMunfasilRule {
  static const Color lightColor = lightMaddaObligatoryMonfasel;
  static const Color darkColor = darkMaddaObligatoryMonfasel;
  static const String key = "madda_obligatory_monfasel";
  static const String description = """
  <b>Madd Ja'iz Munfasil (Permissible Separate Stretch)</b>
  <p>A stretch of 4 or 5 counts. It occurs when a Madd letter appears at the end of a word, and the next word begins with a Hamzah (ء).</p>
  <p><b>How to pronounce:</b> Elongate the vowel for a medium-long duration.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>يَا أَيُّهَا</span></p>
  """;
}

// 14. Hamzat al-Wasl
class HamWaslRule {
  static const Color lightColor = lightHamWasl;
  static const Color darkColor = darkHamWasl;
  static const String key = "ham_wasl";
  static const String description = """
  <b>Hamzat al-Wasl (Connecting Hamzah)</b>
  <p>A type of Hamzah that is pronounced only when starting a word. If it is preceded by another word, it is skipped (connected).</p>
  <p><b>How to pronounce:</b> Pronounce it as a regular 'a', 'i', or 'u' at the beginning of recitation. In the middle of a phrase, drop the Hamzah sound and connect to the previous word.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>ٱهْدِنَا</span> (pronounced 'Ihdina' when starting).</p>
  """;
}

// 15. Lam Shamsiyyah
class LaamShamsiyahRule {
  static const Color lightColor = lightLaamShamsiyah;
  static const Color darkColor = darkLaamShamsiyah;
  static const String key = "laam_shamsiyah";
  static const String description = """
  <b>Lam Shamsiyyah (Sun Letter Lam)</b>
  <p>The 'L' sound in the definite article 'ال' is silent when the following letter is a "sun letter" (e.g., ت, ث, د, ذ, ر, ز, س, ش, ص, ض, ط, ظ, ل, ن). The sun letter is then doubled (pronounced with a Shaddah).</p>
  <p><b>How to pronounce:</b> Skip the 'L' sound and stress the next letter.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>الشَّمْسُ</span> (pronounced 'ash-shamsu').</p>
  """;
}

// 16. Silent Letter
class SlntRule {
  static const Color lightColor = lightSlnt;
  static const Color darkColor = darkSlnt;
  static const String key = "slnt";
  static const String description = """
  <b>Silent Letter</b>
  <p>A letter that is written in the script but not pronounced. This often includes certain Alifs or Waws that serve as placeholders or have historical significance but are silent in recitation.</p>
  <p><b>How to pronounce:</b> Do not pronounce this letter.</p>
  <p><b>Example:</b> The Alif in <span style='font-family:QPC_Hafs'>قَالُوا۟</span>.</p>
  """;
}

// 17. Idgham Mutajanisayn
class IdghamMutajanisaynRule {
  static const Color lightColor = lightIdghamMutajanisayn;
  static const Color darkColor = darkIdghamMutajanisayn;
  static const String key = "idgham_mutajanisayn";
  static const String description = """
  <b>Idgham Mutajanisayn (Merging of Homogeneous Letters)</b>
  <p>The merging of two letters that share the same articulation point but have different attributes. The first letter is merged into the second.</p>
  <p><b>Common pairs:</b> ت/د, ط/ت, ذ/ظ.</p>
  <p><b>How to pronounce:</b> The first letter is not pronounced; the second letter is stressed.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>قَد تَبَيَّنَ</span> (pronounced 'qat-tabayyana').</p>
  """;
}

// 18. Idgham Mutaqaribayn
class IdghamMutaqaribaynRule {
  static const Color lightColor = lightIdghamMutaqaribayn;
  static const Color darkColor = darkIdghamMutaqaribayn;
  static const String key = "idgham_mutaqaribayn";
  static const String description = """
  <b>Idgham Mutaqaribayn (Merging of Similar Letters)</b>
  <p>The merging of two letters that have very close articulation points and attributes.</p>
  <p><b>Common pairs:</b> ق/ك, ل/ر.</p>
  <p><b>How to pronounce:</b> The first letter is merged into the second, which is then stressed.</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>أَلَمْ نَخْلُقكُّم</span> (pronounced 'nakhlukkum').</p>
  """;
}

// 19. Custom Alef Maksora
class CustomAlefMaksoraRule {
  static const Color lightColor = lightCustomAlefMaksora;
  static const Color darkColor = darkCustomAlefMaksora;
  static const String key = "custom-alef-maksora";
  static const String description = """
  <b>Alif Maqsurah (Shortened Alif)</b>
  <p>This is the letter <b>ى</b> which looks like a Ya without dots. It is pronounced as a short 'a' sound, just like a regular Alif.</p>
  <p><b>How to pronounce:</b> Pronounce as a normal Alif (an 'a' sound).</p>
  <p><b>Example:</b> <span style='font-family:QPC_Hafs'>عَلَىٰ</span></p>
  """;
}
