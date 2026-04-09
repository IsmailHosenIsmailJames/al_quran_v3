import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:shimmer/shimmer.dart";

class QuranPageShimmer extends StatelessWidget {
  const QuranPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.read<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          children: [
            // History section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(5),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            // History items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeState.primaryShade100,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Gap(10),

            // Quick Access Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(5),
                  Container(
                    width: 120,
                    height: 20,
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 120,
                    decoration: BoxDecoration(
                      color: themeState.primaryShade100,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  );
                },
              ),
            ),

            const Gap(10),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: themeState.primaryShade100,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            // Tab Bar
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: themeState.primaryShade100,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            const Gap(10),

            // List Items
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: themeState.primaryShade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: themeState.primaryShade100,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const Gap(5),
                              Container(
                                width: 150,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: themeState.primaryShade100,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: themeState.primaryShade100,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
