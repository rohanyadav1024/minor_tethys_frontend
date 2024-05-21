// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:tethys/resources/app_colors.dart';

class AppButton extends StatelessWidget {
  final OutlinedBorder? shape;
  final VoidCallback onPressed;
  final Widget? child;

  const AppButton({
    Key? key,
    this.shape,
    this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.bgColor),
              borderRadius: BorderRadius.circular(16)),
          child: child,
        ));
  }
}
