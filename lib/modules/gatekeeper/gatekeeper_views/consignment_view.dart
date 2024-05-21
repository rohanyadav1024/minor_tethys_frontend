// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ConsignmentView extends StatelessWidget {
  const ConsignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AppText(
              text: 'Nothing to show here',
              size: 32,
              color: AppColors.fluoroscentBlue,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.interBold,
            ),
          )
        ],
      ),
    );
  }
}
