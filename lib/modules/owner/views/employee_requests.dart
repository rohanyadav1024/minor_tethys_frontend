// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/owner/owner_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class EmployeeRequests extends StatelessWidget {
  const EmployeeRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerVM>(builder: (c) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            headerRow(
              headerText: 'Employee Requests',
              onRefresh: () {
                c.fetchEmpReq();
              },
            ),
            SizedBox(height: 24),
            Builder(
              builder: (context) {
                double containerHeight = MediaQuery.of(context).size.height - c.topPadding! - 48 - 24 - 64;
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    height: containerHeight,
                    child: ListView.builder(
                      itemCount: c.empReqList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: GestureDetector(
                            onTap: () {
                              c.toggleExpansionForEmpReq(index);
                            },
                            child: Slidable(
                              enabled: c.isExpandedForEmpReq[index] ? false : true,
                              endActionPane: ActionPane(
                                extentRatio: 0.3,
                                motion: StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (ctx) async {
                                      await c.denyRequest(id: c.empReqList[index].reqId!, context: context);
                                    },
                                    icon: Icons.delete,
                                    backgroundColor: AppColors.errorColor,
                                    borderRadius: BorderRadius.circular(10),
                                    spacing: 0,
                                    padding: EdgeInsets.zero,
                                  )
                                ],
                              ),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                height: c.isExpandedForEmpReq[index] ? 400 : 96,
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
                                              text: c.empReqList[index].employee!.name ?? 'Name',
                                              color: AppColors.txtColor,
                                              size: 20,
                                              fontFamily: AppFonts.interRegular,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            SizedBox(height: 8),
                                            AppText(
                                              text: 'Request Id : ${c.empReqList[index].reqId}',
                                              color: AppColors.txtColor,
                                              size: 16,
                                              fontFamily: AppFonts.interRegular,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            c.acceptRequest(
                                              id: c.empReqList[index].reqId!,
                                              context: context,
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
                                    c.isExpandedForEmpReq[index]
                                        ? Container(
                                            height: 300,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 16),
                                                AppText(
                                                  text: 'Email Id : ${c.empReqList[index].employee!.email}',
                                                  color: AppColors.txtColor,
                                                  size: 16,
                                                  fontFamily: AppFonts.interRegular,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                SizedBox(height: 16),
                                                AppText(
                                                  text: 'Phone : ${c.empReqList[index].employee!.phone}',
                                                  color: AppColors.txtColor,
                                                  size: 16,
                                                  fontFamily: AppFonts.interRegular,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                SizedBox(height: 16),
                                                AppText(
                                                  text:
                                                      'Role : ${c.empReqList[index].employee!.role == 1 ? 'Stock Manager' : c.empReqList[index].employee!.role == 2 ? 'Production Manager' : 'Gate Manager'}',
                                                  color: AppColors.txtColor,
                                                  size: 16,
                                                  fontFamily: AppFonts.interRegular,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                SizedBox(height: 16),
                                                AppText(
                                                  text:
                                                      'Date of Request : ${c.empReqList[index].employee!.createdAt.toString().substring(0, 10)}',
                                                  color: AppColors.txtColor,
                                                  size: 16,
                                                  fontFamily: AppFonts.interRegular,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }
}
