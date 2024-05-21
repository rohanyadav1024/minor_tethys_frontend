// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatekeeperVM>(builder: (c) {
      return Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                headerRow(headerText: 'Upcoming Orders', onRefresh: c.fetchOrdersList),
                SizedBox(height: 24),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 728.h,
                    child: ListView.builder(
                      itemCount: c.orderList.length,
                      itemBuilder: (context, index) {
                        List<TableRow> tableRowsHere = c.orderTableMaker(c.orderList[index].orders!);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              c.toggleExpansion(index);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: c.isExpanded[index] ? 400 : 96,
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue, // Change color when expanded
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            text: c.orderList[index].remarks ?? 'Remark',
                                            color: AppColors.txtColor,
                                            size: 20,
                                            fontFamily: AppFonts.interRegular,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AppText(
                                                text: 'Slot Id : ${c.orderList[index].purId}'.toString(),
                                                color: AppColors.txtColor,
                                                size: 16,
                                                fontFamily: AppFonts.interRegular,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              SizedBox(width: 32),
                                              AppText(
                                                text: "Date : ${c.orderList[index].purTime.toString().substring(0, 9)}",
                                                color: AppColors.txtColor,
                                                size: 16,
                                                fontFamily: AppFonts.interRegular,
                                                fontWeight: FontWeight.w400,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          c.approveOrder(
                                              purId: c.orderList[index].purId!,
                                              orders: c.orderList[index].orders!,
                                              context: context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(16),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            backgroundColor: AppColors.btnColor),
                                        child: Icon(Icons.check),
                                      ),
                                    ],
                                  ),
                                  c.isExpanded[index]
                                      ? Padding(
                                          padding: const EdgeInsets.only(top: 16),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Table(
                                                  border: TableBorder.all(
                                                    width: 1.0,
                                                    color: AppColors.darkblue,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  columnWidths: {
                                                    0: FlexColumnWidth(3),
                                                    1: FlexColumnWidth(1),
                                                  },
                                                  children: [
                                                    TableRow(
                                                      children: [
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
                                                            'Qty',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: AppColors.txtColor,
                                                              fontFamily: AppFonts.interRegular,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    ...tableRowsHere,
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: AppColors.txtColor,
          //   onPressed: () {
          // newRequestDialog(context);
          //   },
          //   child: Icon(Icons.add),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      );
    });
  }
}
