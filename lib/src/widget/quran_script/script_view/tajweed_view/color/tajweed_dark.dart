import "package:flutter/material.dart";

// Dark Theme Colors (Adjusted for contrast)
const Color darkMaddaNecessary = Color(0xFFe65aa7);
const Color darkIdghamGhunnah = Color(0xFF57d342);
const Color darkIkhafaShafawi = Color(0xFFf050d7);
const Color darkIdghamWoGhunnah = Color(0xFF57d342); // Same as w/ ghunnah
const Color darkSlnt = Color(0xFFcccccc);
const Color darkIdghamMutajanisayn = Color(0xFFd0d0d0);
const Color darkGhunnah = Color(0xFFff9a50);
const Color darkIdghamMutaqaribayn = Color(0xFFd0d0d0); // Same as mutaj.
const Color darkHamWasl = Color(0xFFcccccc);
const Color darkQalaqah = Color(0xFF4dc5ff);
const Color darkMaddaObligatoryMonfasel = Color(0xFFfa5aa7);
const Color darkMaddaNormal = Color(0xFF80a0ff);
const Color darkIkhafa = Color(0xFFca50e0);
const Color darkIdghamShafawi = Color(0xFF85e030);
const Color darkLaamShamsiyah = Color(0xFFcccccc);
const Color darkMaddaPermissible = Color(0xFFffb040);
const Color darkMaddaObligatoryMottasel = Color(0xFFfa5aa7); // Same as monfasel
const Color darkIqlab = Color(0xFF60d0ff);
const Color darkCustomAlefMaksora = Color(
  0xFFb070f0,
); // Lighter purple for dark theme

final Map<String, Color> darkThemeTajweedColors = {
  "ham_wasl": darkHamWasl,
  "custom-alef-maksora": darkCustomAlefMaksora, // Added
  "madda_obligatory_monfasel": darkMaddaObligatoryMonfasel,
  "madda_obligatory_mottasel": darkMaddaObligatoryMottasel,
  "ikhafa_shafawi": darkIkhafaShafawi,
  "idgham_mutaqaribayn": darkIdghamMutaqaribayn,
  "ikhafa": darkIkhafa,
  "slnt": darkSlnt,
  "madda_normal": darkMaddaNormal,
  "iqlab": darkIqlab,
  "laam_shamsiyah": darkLaamShamsiyah,
  "idgham_wo_ghunnah": darkIdghamWoGhunnah,
  "idgham_ghunnah": darkIdghamGhunnah,
  "madda_necessary": darkMaddaNecessary,
  "qalaqah": darkQalaqah,
  "idgham_mutajanisayn": darkIdghamMutajanisayn,
  "madda_permissible": darkMaddaPermissible,
  "ghunnah": darkGhunnah,
  "idgham_shafawi": darkIdghamShafawi,
};
