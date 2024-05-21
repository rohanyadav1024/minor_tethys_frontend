// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';

class PmInventory extends StatelessWidget {
  const PmInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(builder: (c) {
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  headerRow(
                      headerText: 'Production Manager Inventory',
                      onRefresh: () async {
                        await c.fetchPmInventory();
                        c.invntryTableMaker();
                      }),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 800.h,
                      child: SingleChildScrollView(
                        child: Table(
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                            width: 1.0,
                            color: AppColors.darkblue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(4),
                            3: FlexColumnWidth(2),
                          },
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sr. No.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Item Id',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Item Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Available Qty',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...c.invntryTableRows,
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
