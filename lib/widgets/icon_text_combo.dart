import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class IconTextReusable extends StatelessWidget {
  const IconTextReusable(
      {super.key,
      required this.imageName,
      required this.text,
      this.style,
      this.width,
      this.height,
      this.spaceBetween});
  final String imageName;
  final String text;
  final TextStyle? style;
  final double? height;
  final double? width;
  final double? spaceBetween;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/$imageName.svg',
          width: width ?? 14,
          height: height ?? 14,
        ),
        SizedBox(
          width: spaceBetween ?? 2.w,
        ),
        Text(
          text,
          style: style ?? kFontEightFiveHG,
        )
      ],
    );
  }
}
