// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class RequisitionReturnView extends StatelessWidget {
  const RequisitionReturnView({super.key});

  void newRequestDialog(BuildContext ctx) {
    Get.dialog(
      AlertDialog(
        title: AppText(
          text: 'New Request',
          textAlign: TextAlign.center,
          size: 24,
          fontWeight: FontWeight.w700,
          fontFamily: AppFonts.interBold,
          color: AppColors.txtColor,
        ),
        backgroundColor: AppColors.white,
        actionsAlignment: MainAxisAlignment.center,
        content: GetBuilder<ProdMngrVM>(
          builder: (c) {
            return SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (c.itemNameCtrl.text.isNotEmpty && c.itemQtyCtrl.text.isNotEmpty) {
                          c.addRow();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 16,
                          ),
                          AppText(
                            text: 'Add Item',
                            size: 16,
                            fontFamily: AppFonts.interRegular,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    primary: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // DropdownButtonFormField(
                        //   decoration: InputDecoration(
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: BorderSide(color: AppColors.bordeColor2),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: BorderSide(color: AppColors.bordeColor2),
                        //     ),
                        //   ),
                        //   value: c.selectedOption,
                        //   items: ['Request Material'].map(
                        //     (item) {
                        //       return DropdownMenuItem(
                        //         child: Text(item),
                        //         value: item,
                        //       );
                        //     },
                        //   ).toList(),
                        //   onChanged: (value) {
                        //     c.selectedOption = value!;
                        //   },
                        // ),
                        // SizedBox(height: 8),
                        TextField(
                          controller: c.remarkCtrl,
                          decoration: InputDecoration(
                            hintText: 'Title',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppColors.bordeColor2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppColors.bordeColor2),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Table(
                          border: TableBorder.all(
                            width: 1.0,
                            color: AppColors.bordeColor2,
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
                                      fontFamily: AppFonts.interRegular,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...c.tableRows,
                            TableRow(
                              children: [
                                Autocomplete<String>(
                                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                    return TextField(
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      decoration:
                                          InputDecoration(hintText: 'Item Name', contentPadding: EdgeInsets.all(8)),
                                    );
                                  },
                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == '') {
                                      return c.rawMatNameList;
                                    }
                                    return c.rawMatNameList.where(
                                      (String option) {
                                        return option.contains(
                                          textEditingValue.text.toLowerCase(),
                                        );
                                      },
                                    );
                                  },
                                  onSelected: (option) {
                                    c.itemNameCtrl.text = option;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                      isDense: true,
                                      focusColor: Colors.transparent,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    controller: c.itemQtyCtrl,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [

                        //   ],
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          GetBuilder<ProdMngrVM>(builder: (c) {
            return ElevatedButton(
              onPressed: () {
                c.itemNameCtrl.clear();
                c.itemQtyCtrl.clear();
                c.tableRows.clear();
                c.remarkCtrl.clear();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: AppText(
                text: 'Cancel',
                size: 16,
                fontFamily: AppFonts.interRegular,
                color: AppColors.white,
              ),
            );
          }),
          GetBuilder<ProdMngrVM>(builder: (c) {
            return ElevatedButton(
              onPressed: () {
                if (c.selectedOption == 'Request Material') {
                  c.sendRequest(ctx);
                } else {
                  // c.returnMaterial(ctx);
                }
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: AppText(
                text: 'Submit',
                size: 16,
                fontFamily: AppFonts.interRegular,
                color: AppColors.white,
              ),
            );
          }),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(builder: (c) {
      return Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerRow(
                headerText: c.isRequests ? 'Your Requests' : 'Your Returns',
                onRefresh: c.isRequests ? c.fetchRequisitionList : c.fetchReturns,
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      c.toggleViews(true);
                    },
                    child: Text('Requests'),
                    style: ElevatedButton.styleFrom(
                      elevation: c.isRequests ? 2 : 0,
                      backgroundColor: c.isRequests ? Colors.amber.shade400 : Colors.amber.shade400.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      c.toggleViews(false);
                    },
                    child: Text('Returns'),
                    style: ElevatedButton.styleFrom(
                      elevation: c.isRequests ? 0 : 2,
                      backgroundColor: c.isRequests ? Colors.amber.shade400.withOpacity(0.6) : Colors.amber.shade400,
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Builder(builder: (context) {
                double containerHeight = MediaQuery.of(context).size.height - 64 - 136 - c.topPadding!;
                return c.isRequests
                    ? Container(
                        height: containerHeight,
                        child: ListView.builder(
                          itemCount: c.pendingRequisitionsList.length,
                          itemBuilder: (context, index) {
                            List<TableRow> tableRowsHere =
                                c.requestTableMaker(c.pendingRequisitionsList[index].requisitions!);
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
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
                                      AppText(
                                        text: c.pendingRequisitionsList[index].remarks ?? 'Remark',
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
                                            text: 'Slot Id : ${c.pendingRequisitionsList[index].slotId}'.toString(),
                                            color: AppColors.txtColor,
                                            size: 16,
                                            fontFamily: AppFonts.interRegular,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(width: 32),
                                          AppText(
                                            text:
                                                "Date : ${c.pendingRequisitionsList[index].reqTime.toString().substring(0, 10)}",
                                            color: AppColors.txtColor,
                                            size: 16,
                                            fontFamily: AppFonts.interRegular,
                                            fontWeight: FontWeight.w400,
                                          )
                                        ],
                                      ),
                                      c.isExpanded[index]
                                          ? Container(
                                              height: 300,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 16),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              c.updateConsumptionsButton(
                                                                  c.pendingRequisitionsList[index].requisitions!,
                                                                  c.pendingRequisitionsList[index].slotId);
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors.blue.shade600,
                                                                padding: EdgeInsets.all(8)),
                                                            child: AppText(
                                                              text: 'Update \nConsumptions',
                                                              textAlign: TextAlign.center,
                                                              size: 12,
                                                              color: AppColors.white,
                                                              fontFamily: AppFonts.interRegular,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              c.returnMaterialsButton(
                                                                c.pendingRequisitionsList[index].requisitions!,
                                                                c.pendingRequisitionsList[index].slotId,
                                                              );
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors.blue.shade600,
                                                                padding: EdgeInsets.all(8)),
                                                            child: AppText(
                                                              text: 'Return \nMaterials',
                                                              textAlign: TextAlign.center,
                                                              size: 12,
                                                              color: AppColors.white,
                                                              fontFamily: AppFonts.interRegular,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              c.markComplete(
                                                                  context: context,
                                                                  slotId: c.pendingRequisitionsList[index].slotId!);
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors.blue.shade600,
                                                                padding: EdgeInsets.all(8)),
                                                            child: AppText(
                                                              text: 'Mark \nCompleted',
                                                              textAlign: TextAlign.center,
                                                              size: 12,
                                                              color: AppColors.white,
                                                              fontFamily: AppFonts.interRegular,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                                                          2: FlexColumnWidth(1),
                                                          3: FlexColumnWidth(1),
                                                          // 4: FlexColumnWidth(1),
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
                                                                    fontSize: 12,
                                                                    fontFamily: AppFonts.interRegular,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  'Qty \nRequested',
                                                                  textAlign: TextAlign.center,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                    color: AppColors.txtColor,
                                                                    fontFamily: AppFonts.interRegular,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  'Qty \nIssued',
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    color: AppColors.txtColor,
                                                                    fontFamily: AppFonts.interRegular,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  'Qty \nConsumed',
                                                                  textAlign: TextAlign.center,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                    color: AppColors.txtColor,
                                                                    fontFamily: AppFonts.interRegular,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Padding(
                                                              //   padding: const EdgeInsets.all(8.0),
                                                              //   child: Text(
                                                              //     'Qty \nRemaining',
                                                              //     textAlign: TextAlign.center,
                                                              //     style: TextStyle(
                                                              //       color: AppColors.txtColor,
                                                              //       fontFamily: AppFonts.interRegular,
                                                              //       fontSize: 14,
                                                              //       fontWeight: FontWeight.w600,
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          ...tableRowsHere,
                                                        ],
                                                      ),
                                                    ],
                                                  ),
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
                      )
                    : Container(
                        //return view
                        height: containerHeight,
                        child: ListView.builder(
                          itemCount: c.returnsList.length,
                          itemBuilder: (context, index) {
                            List<TableRow> tableRowsHere = c.returnsTableMaker(c.returnsList[index].materialsReturn!);
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  c.toggleExpansion(index);
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  height: c.isExpanded2[index] ? 400 : 96,
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: c.isExpanded2[index] ? AppColors.lightBlue : AppColors.lightBlue,
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
                                                text: c.returnsList[index].remarks ?? 'Remarks',
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
                                                    text: c.returnsList[index].slotId.toString(),
                                                    color: AppColors.txtColor,
                                                    size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                    fontFamily: AppFonts.interRegular,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  SizedBox(width: 32.w),
                                                  AppText(
                                                    text:
                                                        'Date: ${c.returnsList[index].retTime.toString().substring(0, 10)}',
                                                    color: AppColors.txtColor,
                                                    size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                    fontFamily: AppFonts.interRegular,
                                                    fontWeight: FontWeight.w400,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     c.approveReturns(
                                          //       slotId: c.returnsList[index].slotId!,
                                          //       context: context,
                                          //     );
                                          //   },
                                          //   style: ElevatedButton.styleFrom(
                                          //       padding: EdgeInsets.all(16),
                                          //       elevation: 0,
                                          //       shape: RoundedRectangleBorder(
                                          //         borderRadius: BorderRadius.circular(10),
                                          //       ),
                                          //       backgroundColor: AppColors.btnColor),
                                          //   child: Icon(Icons.check),
                                          // ),
                                        ],
                                      ),
                                      c.isExpanded2[index]
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
                      );
              }),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.txtColor,
            onPressed: () {
              c.sendApiList.clear();
              newRequestDialog(context);
            },
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      );
    });
  }
}
