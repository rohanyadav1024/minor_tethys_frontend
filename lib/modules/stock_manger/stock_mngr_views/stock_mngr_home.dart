// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../resources/app_colors.dart';
import '../stock_mngr_vm.dart';

class StockMngrHome extends StatelessWidget {
  StockMngrHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      c.topPadding = MediaQuery.paddingOf(context).top;
      debugPrint('topPadding: ${c.topPadding}');
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
            body: Container(
              child: c.child,
            ),
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
                      text: 'Requests & returns',
                    ),
                    GButton(
                      icon: Icons.fire_truck,
                      text: 'Order & Consignment',
                    ),
                    GButton(
                      icon: CupertinoIcons.cube_box,
                      text: 'Handovers',
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
