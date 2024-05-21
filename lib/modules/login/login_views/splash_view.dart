// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // continueAnimation();
    Timer(
      const Duration(seconds: 2),
      () async {
        String? token = await SecuredStorage.readStringValue(Keys.token);
        if (token == null) {
          Get.offNamed(AppRoutes.loginView);
        } else {
          int? role = await SecuredStorage.readIntValue(Keys.role);
          if (role == 0) {
            Get.offNamed(AppRoutes.ownerHome);
          } else if (role == 1) {
            Get.offNamed(AppRoutes.stockMngrHome);
          } else if (role == 2) {
            Get.offNamed(AppRoutes.prodMngrHome);
          } else if (role == 3) {
            Get.offNamed(AppRoutes.gateKeepHome);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.white,
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppImages.splash))));
  }
}
