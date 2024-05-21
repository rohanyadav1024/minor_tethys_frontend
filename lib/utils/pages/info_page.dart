// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfoPageVM>(builder: (c) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.bgGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerRow(headerText: 'Info', onRefresh: c.onInit),
                  SizedBox(height: 16),
                  AppText(
                    text: 'Token: ${c.token}',
                    fontFamily: AppFonts.interRegular,
                    color: AppColors.txtColor,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    text: 'Database ID: ${c.id}',
                    fontFamily: AppFonts.interRegular,
                    color: AppColors.txtColor,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    text: 'Name: ${c.name}',
                    fontFamily: AppFonts.interRegular,
                    color: AppColors.txtColor,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    text: 'Email: ${c.email}',
                    fontFamily: AppFonts.interRegular,
                    color: AppColors.txtColor,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    text: 'Phone: ${c.phone}',
                    fontFamily: AppFonts.interRegular,
                    color: AppColors.txtColor,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    text: 'Role: ${c.roleName}',
                    fontFamily: AppFonts.interRegular,
                    color: AppColors.txtColor,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class InfoPageVM extends GetxController {
  String? token = '';
  String? id = '';
  String? name = '';
  String? email = '';
  String? phone = '';
  int? role;
  String? roleName = '';

  @override
  void onInit() async {
    super.onInit();
    token = await SecuredStorage.readStringValue(Keys.token);
    id = await SecuredStorage.readStringValue(Keys.id);
    name = await SecuredStorage.readStringValue(Keys.name);
    email = await SecuredStorage.readStringValue(Keys.email);
    phone = await SecuredStorage.readStringValue(Keys.phone);
    role = int.tryParse(await SecuredStorage.readStringValue(Keys.role) ?? '');
    switch (role) {
      case 0:
        roleName = 'Owner';
        break;
      case 1:
        roleName = 'Stock Manager';
        break;
      case 2:
        roleName = 'Production Manager';
        break;
      case 3:
        roleName = 'Gate Manager';
        break;
    }
    update();
  }
}
