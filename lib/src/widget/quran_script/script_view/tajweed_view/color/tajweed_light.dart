import 'package:flutter/material.dart';

// --- Color Constants Definition ---

// Light Theme Colors
const Color lightMaddaNecessary = Color(0xFFa9045c);
const Color lightIdghamGhunnah = Color(0xFF169200);
const Color lightIkhafaShafawi = Color(0xFFd500b7);
const Color lightIdghamWoGhunnah = Color(0xFF169200); // Same as w/ ghunnah
const Color lightSlnt = Color(0xFFaaaaaa);
const Color lightIdghamMutajanisayn = Color(0xFFa1a1a1);
const Color lightGhunnah = Color(0xFFff7e1e);
const Color lightIdghamMutaqaribayn = Color(0xFFa1a1a1); // Same as mutaj.
const Color lightHamWasl = Color(0xFFaaaaaa);
const Color lightQalaqah = Color(0xFF009ee6);
const Color lightMaddaObligatoryMonfasel = Color(0xFFf2007f);
const Color lightMaddaNormal = Color(0xFF537fff);
const Color lightIkhafa = Color(0xFF9400a8);
const Color lightIdghamShafawi = Color(0xFF58b800);
const Color lightLaamShamsiyah = Color(0xFFaaaaaa);
const Color lightMaddaPermissible = Color(0xFFf38e02);
const Color lightMaddaObligatoryMottasel = Color(
  0xFFf2007f,
); // Same as monfasel
const Color lightIqlab = Color(0xFF26bffd);
const Color lightCustomAlefMaksora = Color(
  0xFF6a0dad,
); // Assigning a distinct purple

// --- Maps for Rule Classes to Colors ---

final Map<String, Color> lightThemeTajweedColors = {
  'ham_wasl': lightHamWasl,
  'custom-alef-maksora': lightCustomAlefMaksora, // Added
  'madda_obligatory_monfasel': lightMaddaObligatoryMonfasel,
  'madda_obligatory_mottasel': lightMaddaObligatoryMottasel,
  'ikhafa_shafawi': lightIkhafaShafawi,
  'idgham_mutaqaribayn': lightIdghamMutaqaribayn,
  'ikhafa': lightIkhafa,
  'slnt': lightSlnt,
  'madda_normal': lightMaddaNormal,
  'iqlab': lightIqlab,
  'laam_shamsiyah': lightLaamShamsiyah,
  'idgham_wo_ghunnah': lightIdghamWoGhunnah,
  'idgham_ghunnah': lightIdghamGhunnah,
  'madda_necessary': lightMaddaNecessary,
  'qalaqah': lightQalaqah,
  'idgham_mutajanisayn': lightIdghamMutajanisayn,
  'madda_permissible': lightMaddaPermissible,
  'ghunnah': lightGhunnah,
  'idgham_shafawi': lightIdghamShafawi,
};
