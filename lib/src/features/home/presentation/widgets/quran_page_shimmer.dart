import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:shimmer/shimmer.dart";

/// Shimmer placeholder matching the modernized Quran Page layout.
class QuranPageShimmer extends StatelessWidget {
  const QuranPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade900 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Hero card shimmer
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                const Gap(14),

                // 2. Quick actions bar shimmer (4 tiles)
                Row(
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Container(
                        height: 75,
                        margin: EdgeInsets.only(right: index == 3 ? 0 : 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(14),

                // 3. Tab Bar shimmer
                Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const Gap(16),

                // 4. Search bar shimmer
                Container(
                  height: 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                const Gap(12),

                // 5. List items shimmer (4 items)
                ...List.generate(
                  4,
                  (index) => Container(
                    height: 72,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
