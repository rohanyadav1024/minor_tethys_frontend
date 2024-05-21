// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text_form_fied.dart';

import '../../../resources/app_colors.dart';
import '../../../utils/widgets/app_text.dart';

class OrderConsgnmnt extends StatelessWidget {
  const OrderConsgnmnt({super.key});

  void newOrderDialog(BuildContext ctx) {
    Get.dialog(
      GetBuilder<StockMngrVM>(builder: (c) {
        return AlertDialog(
          title: AppText(
            text: 'New Order',
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
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.bordeColor2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.bordeColor2),
                        ),
                      ),
                      value: c.selectedOptionForOC,
                      items: ['Order', 'Consignment'].map(
                        (item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        c.sendApiList.clear();
                        c.tableRows.clear();
                        c.itemNameCtrl.clear();
                        c.itemQtyCtrl.clear();
                        c.selectedOptionForOC = value!;
                        c.update();
                      },
                    ),
                    SizedBox(height: 8),
                    c.selectedOptionForOC == 'Order'
                        ? Column(
                            //create Order
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextFormField(
                                labelText: 'Supplier Name',
                                controller: c.suppNameCtrl,
                                textCapitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Invoice No.',
                                controller: c.invoiceCtrl,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Vehicle No.',
                                controller: c.vehicleCtrl,
                                textCapitalization: TextCapitalization.characters,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Total Amount',
                                controller: c.totalAmtCtrl,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Remarks',
                                controller: c.remarksCtrl,
                              ),
                              SizedBox(height: 14),
                            ],
                          )
                        : Column(
                            //create Consignment

                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextFormField(
                                labelText: 'Buyer',
                                controller: c.buyerCtrl,
                                textCapitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Amount',
                                controller: c.amountCtrl,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Invoice',
                                controller: c.cInvoiceCtrl,
                                textCapitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Vehicle No.',
                                controller: c.cVehNoCtrl,
                                textCapitalization: TextCapitalization.characters,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Transport Name',
                                controller: c.transportCtrl,
                                textCapitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Driver Name',
                                controller: c.drivNameCtrl,
                                textCapitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Driver Phone',
                                controller: c.drivPhoneCtrl,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Driver License',
                                controller: c.drivLicCtrl,
                                textCapitalization: TextCapitalization.characters,
                              ),
                              SizedBox(height: 8),
                              AppTextFormField(
                                labelText: 'Remark',
                                controller: c.cRemarkCtrl,
                                textCapitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
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
                                        fontSize: 14,
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
                    c.selectedOptionForOC == 'Order'
                        ? Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Autocomplete<String>(
                                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                    textEditingController.clear();
                                    return TextField(
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(hintText: 'Item Name'),
                                    );
                                  },
                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == '') {
                                      return c.itemNameList;
                                    }
                                    return c.itemNameList.where(
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
                                    c.addRow();
                                  },
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Autocomplete<String>(
                                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                    textEditingController.clear();
                                    return TextField(
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(hintText: 'Item Name'),
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
                                    c.addRow();
                                  },
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                c.selectedOptionForOC == 'Order' ? c.sendOrder(ctx) : c.sendConsignment(ctx);
              },
              child: Text('Submit'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        );
      }),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              headerRow(
                  headerText: 'Orders and Consignments',
                  onRefresh: () async {
                    await c.fetchOrders();
                    await c.fetchConsignments();
                  }),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      c.toggleViewsforOC(true);
                    },
                    child: Text('Orders'),
                    style: ElevatedButton.styleFrom(
                      elevation: c.isRequests ? 2 : 0,
                      backgroundColor: c.isOrders ? Colors.amber.shade400 : Colors.amber.shade400.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      c.toggleViewsforOC(false);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: c.isRequests ? 0 : 2,
                      backgroundColor: c.isOrders ? Colors.amber.shade400.withOpacity(0.6) : Colors.amber.shade400,
                    ),
                    child: Text('Consignments'),
                  )
                ],
              ),
              SizedBox(height: 14),
              Builder(
                builder: (context) {
                  double containerHeight = MediaQuery.of(context).size.height - 64 - 152 - c.topPadding!;
                  return c.isOrders
                      /*Orders view*/ ? Container(
                          height: containerHeight,
                          child: ListView.builder(
                            itemCount: c.ordersList.length,
                            itemBuilder: (context, index) {
                              List<TableRow> tableRowsHere = c.ordersTableMaker(c.ordersList[index].orders!);
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    c.toggleExpansionForOrders(index);
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    height: c.isExpandedForOrders[index] ? 400 : 96,
                                    padding: EdgeInsets.all(14.0),
                                    decoration: BoxDecoration(
                                      color: c.isExpandedForOrders[index] ? AppColors.lightBlue : AppColors.lightBlue,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: c.ordersList[index].remarks ?? 'Remarks',
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
                                              text: 'Name: ${c.ordersList[index].purBy!.name ?? ''}',
                                              color: AppColors.txtColor,
                                              size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                              fontFamily: AppFonts.interRegular,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 2,
                                            ),
                                            // SizedBox(width: 32.w),
                                            // AppText(
                                            //   text: 'Date: ${c.ordersList[index].purTime.toString().substring(0, 10)}',
                                            //   color: AppColors.txtColor,
                                            //   size: MediaQuery.of(context).size.width > 400 ? 14 : 14.w,
                                            //   fontFamily: AppFonts.interRegular,
                                            //   fontWeight: FontWeight.w400,
                                            // )
                                          ],
                                        ),
                                        c.isExpandedForOrders[index]
                                            ? SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 8),
                                                    AppText(
                                                      text: 'Invoice: ${c.ordersList[index].invoice ?? ''}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 8),
                                                    AppText(
                                                      text: 'Vehicle No.: ${c.ordersList[index].vehicle ?? ''}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w400,
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
                      /*Consignment view*/ : Container(
                          height: containerHeight,
                          child: ListView.builder(
                            itemCount: c.consignmentsList.length,
                            itemBuilder: (context, index) {
                              List<TableRow> tableRowsHere =
                                  c.consignmentsTableMaker(c.consignmentsList[index].consignments!);
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    c.toggleExpansionForConsignments(index);
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    height: c.isExpandedForConsignments[index] ? 400 : 96,
                                    padding: EdgeInsets.all(14.0),
                                    decoration: BoxDecoration(
                                      color: c.isExpandedForConsignments[index]
                                          ? AppColors.lightBlue
                                          : AppColors.lightBlue,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: 'Remarks',
                                          color: const Color.fromRGBO(62, 86, 126, 1),
                                          size: MediaQuery.of(context).size.width > 300 ? 20 : 20.h,
                                          fontFamily: AppFonts.interRegular,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(height: 8.h),
                                        AppText(
                                          text: 'Name: ${c.consignmentsList[index].disBy!.name ?? ''}',
                                          color: AppColors.txtColor,
                                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                          fontFamily: AppFonts.interRegular,
                                          fontWeight: FontWeight.w400,
                                          maxLines: 2,
                                        ),
                                        c.isExpandedForConsignments[index]
                                            ? SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 8),
                                                    AppText(
                                                      text: 'Buyer: ${c.consignmentsList[index].buyer ?? ''}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        AppText(
                                                          text:
                                                              'Invoice No.: ${c.consignmentsList[index].invoice ?? ''}',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        SizedBox(width: 24),
                                                        AppText(
                                                          text:
                                                              'Total Amount: ${c.consignmentsList[index].invValue ?? ''}',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    AppText(
                                                      text:
                                                          'Driver Name: ${c.consignmentsList[index].driverDetails!.name ?? ''}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        AppText(
                                                          text:
                                                              'D. Phone : ${c.consignmentsList[index].driverDetails!.phone ?? ''}',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        SizedBox(width: 24),
                                                        AppText(
                                                          text:
                                                              'D. Lic.: ${c.consignmentsList[index].driverDetails!.licenseNo ?? ''}',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        AppText(
                                                          text:
                                                              'Vehicle no. : ${c.consignmentsList[index].vehicle!.vehNo ?? ''}',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        SizedBox(width: 24),
                                                        AppText(
                                                          text:
                                                              'Vehicle Name: ${c.consignmentsList[index].vehicle!.name ?? ''}',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 14 : 14.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
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
                },
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.txtColor,
            onPressed: () {
              c.itemNameCtrl.clear();
              c.itemNameCtrl.clear();
              c.tableRows.clear();
              c.sendApiList.clear();
              newOrderDialog(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      );
    });
  }
}
