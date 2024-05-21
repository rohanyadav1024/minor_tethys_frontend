// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';

class ProdMngrHome extends StatelessWidget {
  ProdMngrHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(builder: (c) {
      c.topPadding = MediaQuery.paddingOf(context).top;
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: c.child,
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.bordeColor2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Obx(() {
                return GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8.w,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.all(12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: Icons.dashboard,
                      text: 'Dashboard',
                    ),
                    GButton(
                      icon: Icons.rate_review_rounded,
                      text: 'Requisition/Return',
                    ),
                    GButton(
                      icon: CupertinoIcons.cube_box,
                      text: 'Production Handover',
                    ),
                  ],
                  selectedIndex: c.indx.value,
                  onTabChange: (index) {
                    c.onTabChange(index);
                  },
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}
