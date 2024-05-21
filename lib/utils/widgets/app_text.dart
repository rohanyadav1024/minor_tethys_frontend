import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  const AppText({
    required this.text,
    this.color,
    this.size,
    this.fontFamily,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          color: color ?? AppColors.black,
          fontSize: size ?? 15.0.h,
          fontFamily: fontFamily ?? AppFonts.interRegular,
          fontWeight: fontWeight ?? FontWeight.w700),
    );
  }
}
