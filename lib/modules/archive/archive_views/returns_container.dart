// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/archive/archive_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ReturnsContainer extends StatelessWidget {
  const ReturnsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchiveVM>(builder: (c) {
      return Container(
        height: 716.5,
        child: ListView.builder(
          itemCount: c.archivedRetList.length + 1,
          itemBuilder: (context, index) {
            if (index == c.archivedRetList.length) {
              return Center(
                child: TextButton(
                  onPressed: () {
                    c.fetchArchReturns(context: context);
                  },
                  child: Text(
                    '!!Load More!!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            } else {
              List<TableRow> tableRowsHere = c.ArchReturnsTableMaker(c.archivedRetList[index].returns!);

              return Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    c.toggleExpansionForArchReturns(index);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    height: c.isExpandedForArchReturns[index] ? 400 : 96,
                    padding: EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: c.isExpandedForArchReturns[index] ? AppColors.lightBlue : AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Return Slot Id: ${c.archivedRetList[index].retSlotId ?? ''}',
                          color: const Color.fromRGBO(62, 86, 126, 1),
                          size: MediaQuery.of(context).size.width > 300 ? 20 : 20.h,
                          fontFamily: AppFonts.interRegular,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              text: 'Returned By: ${c.archivedRetList[index].retBy!.name ?? ''}',
                              color: AppColors.txtColor,
                              size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                              fontFamily: AppFonts.interRegular,
                              fontWeight: FontWeight.w400,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        c.isExpandedForArchReturns[index]
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        border: TableBorder.all(
                                          width: 1.0,
                                          color: AppColors.darkblue,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        columnWidths: {
                                          0: FixedColumnWidth(150),
                                          1: FixedColumnWidth(100),
                                          2: FixedColumnWidth(100),
                                          3: FixedColumnWidth(100),
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
                                                  'Qty\nRequested',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors.txtColor,
                                                    fontFamily: AppFonts.interRegular,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Qty\nIssued',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors.txtColor,
                                                    fontFamily: AppFonts.interRegular,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Qty\nReturned',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors.txtColor,
                                                    fontFamily: AppFonts.interRegular,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ...tableRowsHere,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
    });
  }
}
