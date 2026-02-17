import "package:flutter/services.dart";

class DynamicFontLoader {
  // Cache to keep track of loaded fonts to avoid reloading them
  static final Set<String> _loadedFonts = {};

  /// Loads a font dynamicall from assets.
  ///
  /// [pageNumber] is the page number (e.g., 1, 2, ... 604).
  /// Returns the font family name to use in TextStyle.
  static Future<String> loadFontForPage(int pageNumber) async {
    final String fontFamily = 'Page$pageNumber'; // Unique family name per page

    // If already loaded, return the family name immediately
    if (_loadedFonts.contains(fontFamily)) {
      return fontFamily;
    }

    final String fileName = 'p$pageNumber.ttf';
    final String assetPath = 'assets/V4_Glyphs_With_Tajweed/$fileName';

    try {
      final FontLoader fontLoader = FontLoader(fontFamily);
      fontLoader.addFont(rootBundle.load(assetPath));
      await fontLoader.load();

      _loadedFonts.add(fontFamily);
      return fontFamily;
    } catch (e) {
      print('Error loading font for page $pageNumber: $e');
      // Fallback font or rethrow depending on your needs
      return 'QPC_Hafs'; // Example fallback
    }
  }
}
