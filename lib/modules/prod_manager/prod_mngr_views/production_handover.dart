// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'package:tethys/utils/widgets/app_text_form_fied.dart';

class ProductionHandover extends StatelessWidget {
  const ProductionHandover({super.key});

  void createHandoverDialog(BuildContext context) {
    Get.dialog(
      GetBuilder<ProdMngrVM>(builder: (c) {
        return AlertDialog(
          title: AppText(
            text: 'Handover',
            textAlign: TextAlign.center,
            size: 24,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.interBold,
            color: AppColors.txtColor,
          ),
          backgroundColor: AppColors.white,
          content: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(maxHeight: 800.h),
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextFormField(
                      labelText: 'Title',
                      controller: c.handoverTitleCtrl,
                    ),
                    // AppTextFormField(
                    //   labelText: 'Slot Id',
                    //   controller: c.handoverReqIdCtrl,
                    // ),
                    SizedBox(height: 8),
                    c.tableRows.isNotEmpty
                        ? Table(
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
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Autocomplete<String>(
                            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                              textEditingController.clear();
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: InputDecoration(hintText: 'Item Name', contentPadding: EdgeInsets.all(8)),
                              );
                            },
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return c.prodNameList;
                              }
                              return c.prodNameList.where(
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
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: 'Qty',
                                focusColor: Colors.transparent,
                              ),
                              controller: c.itemQtyCtrl,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              if (c.itemNameCtrl.text.isNotEmpty && c.itemQtyCtrl.text.isNotEmpty) {
                                c.addRowForHandover();
                              }
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                c.itemNameCtrl.clear();
                c.itemQtyCtrl.clear();
                // c.handoverReqIdCtrl.clear();
                c.handoverTitleCtrl.clear();
                c.tableRows.clear();
                c.sendApiList.clear();
                c.update();
                Get.back();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                c.sendHandover(context);
              },
              child: Text('Submit'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(
      builder: (c) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              headerRow(headerText: 'Production Handover', onRefresh: () {}),
              SizedBox(height: 24),
              Builder(
                builder: (context) {
                  double containerHeight = MediaQuery.of(context).size.height - 64 - 72 - c.topPadding!;
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: containerHeight,
                      child: ListView.builder(
                        itemCount: c.handoversList.length,
                        itemBuilder: (context, index) {
                          List<TableRow> tableRowsHere = c.handoverSlotTableMaker(c.handoversList[index].handovers!);
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
                                  color: AppColors.lightBlue, // Change color when expanded
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    AppText(
                                      text: c.handoversList[index].remarks ?? 'Title',
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
                                          text: 'Batch Id : ${c.handoversList[index].batchId}',
                                          color: AppColors.txtColor,
                                          size: 16,
                                          fontFamily: AppFonts.interRegular,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(width: 32),
                                        AppText(
                                          text: "Date : ${c.handoversList[index].mfg.toString().substring(0, 10)}",
                                          color: AppColors.txtColor,
                                          size: 16,
                                          fontFamily: AppFonts.interRegular,
                                          fontWeight: FontWeight.w400,
                                        )
                                      ],
                                    ),
                                    c.isExpandedForHandovers[index]
                                        ? Container(
                                            height: 300,
                                            child: Padding(
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
                                                                'Product Name',
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
                                                                'Quantity',
                                                                textAlign: TextAlign.center,
                                                                maxLines: 2,
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
                    ),
                  );
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.txtColor,
            onPressed: () {
              c.tableRows.clear();
              c.sendApiList.clear();
              createHandoverDialog(context);
            },
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
