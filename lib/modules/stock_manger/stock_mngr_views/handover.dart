// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class SMHandovers extends StatelessWidget {
  const SMHandovers({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(
      builder: (c) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              headerRow(
                  headerText: 'Handovers',
                  onRefresh: () async {
                    await c.fetchHandovers();
                  }),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Builder(builder: (context) {
                  double containerHeight = MediaQuery.of(context).size.height - 64 - 136 - c.topPadding!;
                  return Container(
                    height: containerHeight,
                    child: ListView.builder(
                      itemCount: c.handoversList.length,
                      itemBuilder: (context, index) {
                        List<TableRow> tableRowsHere = c.handoversTableMaker(c.handoversList[index].handovers!);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              c.toggleExpansionForHandovers(index);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: c.isExpandedForHandovers[index] ? 400 : 96,
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: c.isExpandedForHandovers[index] ? AppColors.lightBlue : AppColors.lightBlue,
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
                                            text: c.handoversList[index].remarks ?? 'Remarks',
                                            color: const Color.fromRGBO(62, 86, 126, 1),
                                            size: MediaQuery.of(context).size.width > 300 ? 20 : 20.h,
                                            fontFamily: AppFonts.interRegular,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AppText(
                                                text: 'Hand by: ${c.handoversList[index].handoverBy!.name ?? ''}',
                                                color: AppColors.txtColor,
                                                size: MediaQuery.of(context).size.width > 400 ? 14 : 14.w,
                                                fontFamily: AppFonts.interRegular,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Alert!!'),
                                                content: Text('Approve this batch?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await c.approveHandover(
                                                          batchId: c.handoversList[index].batchId!, context: context);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
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
                                  c.isExpandedForHandovers[index]
                                      ? Container(
                                          height: 300,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 16.h),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    AppText(
                                                      text: 'Batch Id: ${c.handoversList[index].batchId ?? ''}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.w,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    SizedBox(width: 24),
                                                    AppText(
                                                      text:
                                                          'Date: ${c.handoversList[index].mfg.toString().substring(0, 10)}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.w,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8),
                                                SizedBox(height: 8),
                                                Table(
                                                  border: TableBorder.all(
                                                    width: 1.0,
                                                    color: AppColors.darkblue,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  columnWidths: {
                                                    0: FlexColumnWidth(3),
                                                    1: FlexColumnWidth(1),
                                                    // 2: FlexColumnWidth(1),
                                                    // 3: FlexColumnWidth(1),
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
                                                              fontSize: 14,
                                                              fontFamily: AppFonts.interRegular,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            'Qty \nHanded',
                                                            textAlign: TextAlign.center,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              color: AppColors.txtColor,
                                                              fontFamily: AppFonts.interRegular,
                                                              fontSize: 13.sp,
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
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }
}
