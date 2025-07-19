import "dart:math";

/// Calculates the Levenshtein distance between two strings.
/// The Levenshtein distance is the minimum number of single-character edits
/// (insertions, deletions or substitutions) required to change one word into the other.
int _levenshteinDistance(String s1, String s2) {
  final int len1 = s1.length;
  final int len2 = s2.length;

  // Create a 2D array to store the distances
  // dp[i][j] will be the Levenshtein distance between s1[0...i-1] and s2[0...j-1]
  final List<List<int>> dp = List.generate(
    len1 + 1,
    (i) => List.filled(len2 + 1, 0, growable: false),
    growable: false,
  );

  // Initialize the first row and column
  // If s1 is empty, the distance is the length of s2 (all insertions)
  for (int i = 0; i <= len1; i++) {
    dp[i][0] = i;
  }
  // If s2 is empty, the distance is the length of s1 (all insertions)
  for (int j = 0; j <= len2; j++) {
    dp[0][j] = j;
  }

  // Fill the DP table
  for (int i = 1; i <= len1; i++) {
    for (int j = 1; j <= len2; j++) {
      final cost = (s1[i - 1] == s2[j - 1]) ? 0 : 1;

      // The cost is the minimum of:
      // 1. Deletion: dp[i-1][j] + 1 (delete character from s1)
      // 2. Insertion: dp[i][j-1] + 1 (insert character into s1 to match s2)
      // 3. Substitution: dp[i-1][j-1] + cost (substitute character)
      dp[i][j] = min(
        dp[i - 1][j] + 1,
        min(dp[i][j - 1] + 1, dp[i - 1][j - 1] + cost),
      );
    }
  }

  // The bottom-right cell contains the Levenshtein distance
  return dp[len1][len2];
}

/// Calculates the similarity between two strings as a percentage,
/// based on the Levenshtein distance.
///
/// Returns a value between 0.0 (no match) and 100.0 (perfect match).
/// Handles cases where one or both strings are empty.
double _calculateSimilarityPercentage(String s1, String s2) {
  if (s1 == s2) {
    return 100.0; // Perfect match (includes both empty strings)
  }
  if (s1.isEmpty || s2.isEmpty) {
    return 0.0; // One string is empty, the other is not, no meaningful match
  }

  final int maxLength = max(s1.length, s2.length);
  final int distance = _levenshteinDistance(s1, s2);

  // Normalize the distance to a similarity percentage
  // (maxLength - distance) gives us how "close" they are
  // Divide by maxLength to get a ratio, then multiply by 100
  return ((maxLength - distance) / maxLength) * 100.0;
}

/// Searches for the best approximate match of [pattern] within [text]
/// and returns the highest similarity percentage found.
///
/// This function works by comparing the pattern against all possible
/// substrings of the text, using Levenshtein distance to determine similarity.
///
/// [pattern]: The string you are searching for (string 1).
/// [text]: The string you are searching within (string 2).
///
/// Returns a double representing the highest match percentage (0.0 to 100.0).
double searchPatternInText(String pattern, String text) {
  // Edge case: If the pattern is empty
  if (pattern.isEmpty) {
    // An empty pattern matches an empty text perfectly (100%),
    // but typically provides 0% match if searching in a non-empty text,
    // as there's no content to compare against.
    return text.isEmpty ? 100.0 : 0.0;
  }

  // Edge case: If the text to search within is empty
  if (text.isEmpty) {
    return 0.0; // Cannot find a non-empty pattern in an empty text.
  }

  double maxMatchPercentage = 0.0;

  // Iterate through all possible substrings of the 'text'
  // A substring can be from length 1 up to text.length
  for (int i = 0; i < text.length; i++) {
    for (int j = i + 1; j <= text.length; j++) {
      String currentSubText = text.substring(i, j);

      // Calculate similarity between the pattern and the current substring of text
      double currentMatch = _calculateSimilarityPercentage(
        pattern,
        currentSubText,
      );

      // Update maxMatchPercentage if a better match is found
      if (currentMatch > maxMatchPercentage) {
        maxMatchPercentage = currentMatch;
      }

      // Optimization: If a perfect match (100%) is found, no need to search further.
      if (maxMatchPercentage == 100.0) {
        return 100.0;
      }
    }
  }

  return maxMatchPercentage;
}
