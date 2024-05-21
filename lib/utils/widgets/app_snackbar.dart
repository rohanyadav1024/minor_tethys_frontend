import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/utils/widgets/app_text.dart';

SnackBar appSnackbar({String? msg, Color? color}) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    content: Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      height: 64.h,
      width: 400.h,
      decoration: BoxDecoration(
        color: color ?? AppColors.snackBarColorFailure,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppText(
        text: msg ?? "",
        size: 15.h,
        color: AppColors.white,
      ),
    ),
  );
}
