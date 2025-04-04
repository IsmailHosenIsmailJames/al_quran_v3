import 'dart:math';

import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:al_quran_v3/src/theme/values/values.dart';
import 'package:flutter/material.dart';

SizedBox getIndexNumberWidget(
  BuildContext context,

  int index, {
  Color? textColor,
  double? height,
  double? width,
}) {
  return SizedBox(
    height: height ?? 35,
    width: width ?? 35,
    child: Stack(
      children: [
        Transform.rotate(
          angle: 45 * pi / 180,

          child: Container(
            height: height ?? 35,
            width: width ?? 35,
            alignment: Alignment.center,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(roundedRadius - 3),
              border: Border.all(color: AppColors.primaryColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: FittedBox(
              child: Text(
                index.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
