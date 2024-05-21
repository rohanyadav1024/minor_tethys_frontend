// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/common.dart';

import '../../../resources/app_colors.dart';
import '../../../utils/widgets/app_text.dart';

class StockMngrDashboard extends StatelessWidget {
  const StockMngrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage(AppImages.bgImage),
            opacity: 0.5,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  headerRow(headerText: 'Dashboard', onRefresh: c.onInit),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            children: [
                              dashboardCard(
                                text1: 'Pending Material Requests',
                                text2: c.materialReqList.length.toString(),
                              ),
                              dashboardCard(
                                text1: 'Pending Return Requests',
                                text2: c.returnsList.length.toString(),
                              ),
                              dashboardCard(
                                text1: 'Unverified Orders',
                                text2: c.ordersList.length.toString(),
                              ),
                              dashboardCard(
                                text1: 'Unverified Consignments',
                                text2: c.consignmentsList.length.toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              c.invntryTableMaker();
                              Get.toNamed(AppRoutes.smInventory);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bordeColor2,
                              minimumSize: Size(120, 70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.inventory),
                                  AppText(
                                    text: '   Show Inventory',
                                    color: AppColors.white,
                                    size: 20.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.archives);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bordeColor2,
                              minimumSize: Size(120, 70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.archive),
                                  AppText(
                                    text: '  Show Archives',
                                    color: AppColors.white,
                                    size: 20.sp,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  c.isloading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
