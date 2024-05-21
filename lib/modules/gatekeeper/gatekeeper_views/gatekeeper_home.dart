// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_vm.dart';
import 'package:tethys/resources/app_colors.dart';

class GateKeeperHome extends StatelessWidget {
  GateKeeperHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatekeeperVM>(builder: (c) {
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Container(
              child: c.child,
            ),
          ),
          bottomNavigationBar: Container(
            // alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.boxShadow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Obx(() {
              return GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                mainAxisAlignment: MainAxisAlignment.center,
                tabMargin: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  GButton(
                    icon: Icons.dashboard,
                    text: 'Orders',
                  ),
                  GButton(
                    icon: Icons.rate_review_rounded,
                    text: 'Consignment',
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
      );
    });
  }
}
