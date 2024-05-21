// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_text.dart';

Future<void> logout() async {
  SecuredStorage.clearSecureStorage();
  Get.offNamed(AppRoutes.loginView);
}

Future<void> info() async {
  Get.toNamed(AppRoutes.infoPage);
}

Widget dashboardCard({text1, String? text2}) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue.withOpacity(0.5),
            Colors.lightBlue.withOpacity(1.0),
            Colors.blue.withOpacity(1.0),
            Colors.indigo.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: text1,
                color: AppColors.white,
                size: 16.h,
              ),
              AppText(
                text: text2 ?? 0.toString(),
                color: AppColors.white,
                size: 48.h,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget headerRow({required String headerText, required Function onRefresh}) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: AppText(
          text: headerText,
          textAlign: TextAlign.center,
          size: 24,
          fontWeight: FontWeight.w700,
          fontFamily: AppFonts.interBold,
          color: AppColors.txtColor,
        ),
      ),
      Expanded(
        flex: 0,
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'refresh',
                child: Row(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: AppColors.txtColor,
                    ),
                    SizedBox(width: 4),
                    AppText(
                      text: 'Refresh',
                      color: AppColors.txtColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'info',
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: AppColors.txtColor,
                    ),
                    SizedBox(width: 4),
                    AppText(
                      text: 'Info',
                      color: AppColors.txtColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.txtColor,
                    ),
                    SizedBox(width: 4),
                    AppText(
                      text: 'Logout',
                      color: AppColors.txtColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ];
          },
          onSelected: (value) {
            if (value == 'info') {
              info();
            } else if (value == 'logout') {
              logout();
            } else if (value == 'refresh') {
              onRefresh();
            }
          },
          icon: Icon(
            Icons.more_vert,
            color: AppColors.txtColor,
            size: 24,
          ),
        ),
      )
    ],
  );
}
