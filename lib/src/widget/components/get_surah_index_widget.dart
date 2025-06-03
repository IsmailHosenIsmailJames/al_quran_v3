import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

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
        SvgPicture.string(
          """<svg class="w-10 h-10 rounded-full flex items-center justify-center" fill="#b1901f" viewBox="0 0 24 24"><path class="opacity-15" d="M21.77,8.948a1.238,1.238,0,0,1-.7-1.7,3.239,3.239,0,0,0-4.315-4.316,1.239,1.239,0,0,1-1.7-.7,3.239,3.239,0,0,0-6.1,0,1.238,1.238,0,0,1-1.7.7A3.239,3.239,0,0,0,2.934,7.249a1.237,1.237,0,0,1-.7,1.7,3.24,3.24,0,0,0,0,6.1,1.238,1.238,0,0,1,.705,1.7A3.238,3.238,0,0,0,7.25,21.066a1.238,1.238,0,0,1,1.7.7,3.239,3.239,0,0,0,6.1,0,1.238,1.238,0,0,1,1.7-.7,3.239,3.239,0,0,0,4.316-4.315,1.239,1.239,0,0,1,.7-1.7,3.239,3.239,0,0,0,0-6.1Z"></path><text x="50%" y="53%" text-anchor="middle" stroke="#b1901f" stroke-width="0.5px" dy=".3em" class="text" style="font-size: 7px;">2</text></svg>""",
          height: height ?? 35,
          width: width ?? 35,
          colorFilter: ColorFilter.mode(
            AppColors.primaryShade300,
            BlendMode.srcIn,
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
