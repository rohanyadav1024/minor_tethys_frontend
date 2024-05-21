// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/archive/archive_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class RequestsContainer extends StatelessWidget {
  const RequestsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchiveVM>(builder: (c) {
      double containerHeight = MediaQuery.of(context).size.height - c.topPadding! - 48 - 16 - 64 - 16;
      return Container(
        height: containerHeight,
        child: ListView.builder(
          itemCount: c.archivedReqList.length + 1,
          itemBuilder: (context, index) {
            if (index == c.archivedReqList.length) {
              return Center(
                child: TextButton(
                  onPressed: () {
                    c.fetchArchRequests(context: context);
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
              List<TableRow> tableRowsHere = c.ArchRequestsTableMaker(c.archivedReqList[index].requisitions!);

              return Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    c.toggleExpansionForArchRequests(index);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    height: c.isExpandedForArchRequests[index] ? 400 : 96,
                    padding: EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: c.isExpandedForArchRequests[index] ? AppColors.lightBlue : AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: c.archivedReqList[index].remarks ?? 'Remarks',
                          color: const Color.fromRGBO(62, 86, 126, 1),
                          size: MediaQuery.of(context).size.width > 300 ? 20 : 20.h,
                          fontFamily: AppFonts.interRegular,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 8.h),
                        AppText(
                          text: 'Requested by: ${c.archivedReqList[index].reqBy!.name ?? ''}',
                          color: AppColors.txtColor,
                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                          fontFamily: AppFonts.interRegular,
                          fontWeight: FontWeight.w400,
                          maxLines: 2,
                        ),
                        c.isExpandedForArchRequests[index]
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.h),
                                    AppText(
                                      text: 'Issued by: ${c.archivedReqList[index].issuedBy!.name ?? ''}',
                                      color: AppColors.txtColor,
                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 8.h),
                                    AppText(
                                      text:
                                          'Date of request: ${c.archivedReqList[index].reqTime.toString().substring(0, 10) ?? ''}',
                                      color: AppColors.txtColor,
                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 8),
                                    AppText(
                                      text:
                                          'Date of completion: ${c.archivedReqList[index].compTime.toString().substring(0, 10) ?? ''}',
                                      color: AppColors.txtColor,
                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 2,
                                    ),
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
                                          3: FixedColumnWidth(100)
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
                                                  'Qty\nConsumed',
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
