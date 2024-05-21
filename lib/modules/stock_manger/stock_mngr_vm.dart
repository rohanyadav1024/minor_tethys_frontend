// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/models/get_material_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_products_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_consignments_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_handovers_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_inventory_model.dart';
import 'package:tethys/modules/stock_manger/models/get_orders_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_returns_list_model.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_views/handover.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_views/request_and_returns.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_views/order_consgnmnt.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'stock_mngr_views/stock_mngr_dashboard.dart';

class StockMngrVM extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  StockMngrRepoImpl smri = StockMngrRepoImpl();
  String selectedOptionForOC = 'Order';
  double? topPadding;
  RxInt indx = 0.obs;
  Widget? child = StockMngrDashboard();
  bool isApproved = false;
  bool isRequests = true;
  bool isOrders = true;
  bool isloading = true;
  List<bool> isExpanded = [];
  List<bool> isExpanded2 = [];
  List<bool> isExpandedForOrders = [];
  List<bool> isExpandedForConsignments = [];
  List<bool> isExpandedForHandovers = [];

  List<TableRow> tableRows = [];
  List<TableRow> invntryTableRows = [];

  List<String> itemNameList = [];
  List<String> prodNameList = [];
  List<MaterialInfo>? materials = [];
  List<ProductsInfo>? products = [];

  List<Map> sendApiList = [];
  List<Requisition> currentRequesitions = [];
  List<Map<String?, dynamic>> issuedQtyList = [];

  OrdersDatum ordersObj = OrdersDatum();

  List<InventoryDatum> inventoryList = [];
  List<MaterialReqDatum> materialReqList = [];
  List<ReturnsDatum> returnsList = [];
  List<OrdersDatum> ordersList = [];
  List<ConsignmentDatum> consignmentsList = [];
  List<SMHandoversDatum> handoversList = [];
  //create Order Controllers
  TextEditingController suppNameCtrl = TextEditingController();
  TextEditingController totalAmtCtrl = TextEditingController();
  TextEditingController invoiceCtrl = TextEditingController();
  TextEditingController vehicleCtrl = TextEditingController();
  TextEditingController remarksCtrl = TextEditingController();
  //create consignment Controller
  TextEditingController buyerCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController cInvoiceCtrl = TextEditingController();
  TextEditingController cVehNoCtrl = TextEditingController();
  TextEditingController transportCtrl = TextEditingController();
  TextEditingController drivNameCtrl = TextEditingController();
  TextEditingController drivPhoneCtrl = TextEditingController();
  TextEditingController drivLicCtrl = TextEditingController();
  TextEditingController cRemarkCtrl = TextEditingController();

  TextEditingController itemNameCtrl = TextEditingController();
  TextEditingController itemQtyCtrl = TextEditingController();

  // TextEditingController expDateCtrl = TextEditingController();
  // TextEditingController pur = TextEditingController();

  @override
  void onInit() async {
    isloading = true;
    update();
    super.onInit();
    await Future.wait([
      getRequests(),
      fetchMaterialList(),
      fetchProductList(),
      fetchReturns(),
      fetchOrders(),
      fetchConsignments(),
      fetchInventory(),
      fetchHandovers(),
    ]);
    isloading = false;
    update();
  }

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = StockMngrDashboard();
        break;
      case 1:
        child = MaterialRequestView();
        break;
      case 2:
        child = OrderConsgnmnt();
        break;
      case 3:
        child = SMHandovers();
        break;
    }
    update();
  }

  Future<void> fetchInventory() async {
    inventoryList.clear();
    await smri.getInventory().then((res) {
      if (res.status == '200') {
        res.data!.forEach((element) {
          inventoryList.add(element);
        });
        update();
      }
    }).onError((error, stackTrace) => null);
  }

  void invntryTableMaker() {
    invntryTableRows.clear();
    var count = 1;
    inventoryList.forEach((element) {
      invntryTableRows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                textAlign: TextAlign.center,
                text: count.toString(),
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                textAlign: TextAlign.center,
                text: element.materialId.toString(),
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: element.matDetails!.material!,
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: '${element.availableQty} ${element.matDetails!.umo}',
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
          ],
        ),
      );
      ++count;
    });
    update();
  }

  Future<void> fetchMaterialList() async {
    await smri.getItemsList().then(
      (res) {
        if (res.status == "200") {
          res.data!.forEach((element) {
            itemNameList.add(
              element.material!.toLowerCase(),
            );
          });
          materials = res.data;
        }
      },
    );
  }

  Future<void> fetchProductList() async {
    await smri.getProductList().then(
      (res) {
        if (res.status == '200') {
          res.data!.forEach(
            (element) {
              prodNameList.add(
                element.product!.toLowerCase(),
              );
            },
          );
          products = res.data;
        }
      },
    ).onError((error, stackTrace) {
      debugPrint('Error in fetchProductsList()');
    });
    debugPrint(prodNameList.toString());
  }

  void toggleViews(bool value) {
    isRequests = value;
    update();
  }

  void toggleViewsforOC(bool value) {
    isOrders = value;
    update();
  }

  Future<void> getRequests() async {
    materialReqList.clear();
    await smri.getrequests().then((res) {
      if (res.status == '200') {
        // materialReqList = res.data!;
        res.data!.forEach(
          (element) {
            if (element.issueStatus == false) {
              materialReqList.add(element);
            }
          },
        );
        debugPrint(materialReqList.toString());
        isExpanded = List.generate(materialReqList.length, (index) => false);
      }
      update();
    });
  }

  // Future<void> approveRequest({required int slotId, required BuildContext context}) async {
  //   var data = {};
  //   data['slot_id'] = slotId;
  //   data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);
  //   await smri.issueRequest(data).then((res) async {
  //     if (res.status == '200') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
  //       );
  //       await getRequests();
  //       await fetchInventory();
  //       update();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
  //       );
  //     }
  //   }).onError((error, stackTrace) => null);
  // }

  Future<void> issueRequesitions(BuildContext context) async {
    var data = {};

    data['issue_materials'] = issuedQtyList;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.issueRequest(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: res.msg,
          color: AppColors.snackBarColorSuccess,
        ));
        await getRequests();
        update();
        Get.back();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: res.msg,
          color: AppColors.snackBarColorFailure,
        ));
      }
    }).onError((error, stackTrace) => null);
  }

  Future<void> denyRequest({required int slotId, required BuildContext context}) async {
    var data = {};

    data['slot_id'] = slotId;

    debugPrint(data.toString());

    await smri.denyRequest(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
        );
        await getRequests();
        update();
        await fetchInventory();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
        );
      }
    }).onError((error, stackTrace) => null);
  }

  List<TableRow> requestTableMaker(List<Requisition> requestList) {
    List<TableRow> reqMaterialTableRows = [];
    bool isAvailable = false;
    requestList.forEach(
      (element) {
        int qtyRemaining = element.qtyReq! - element.qtyIssued!;
        for (int i = 0; i < inventoryList.length; i++) {
          if (element.matDetails!.id == inventoryList[i].materialId && qtyRemaining < inventoryList[i].availableQty!) {
            isAvailable = true;
          }
        }
        reqMaterialTableRows.add(
          TableRow(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.matDetails!.material.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyIssued.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: qtyRemaining.toString(),
                  color: isAvailable ? AppColors.snackBarColorSuccess : AppColors.snackBarColorFailure,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
          ]),
        );
      },
    );
    return reqMaterialTableRows;
  }

  void toggleExpansion(int index) {
    if (isRequests == true) {
      isExpanded[index] = !isExpanded[index];
    } else {
      isExpanded2[index] = !isExpanded2[index];
    }
    update(); // Trigger a UI update
  }

  Future<void> fetchReturns() async {
    returnsList.clear();
    await smri.fetchReturns().then((res) {
      res.data!.forEach(
        (element) {
          if (element.approved == false) {
            returnsList.add(element);
          }
        },
      );
    }).onError((error, stackTrace) => null);
    isExpanded2 = List.generate(returnsList.length, (index) => false);
    update();
  }

  Future<void> approveReturns({required int slotId, required BuildContext context}) async {
    var data = {};

    data['slot_id'] = slotId;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.approveReturn(data).then(
      (res) async {
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: res.msg,
            color: AppColors.snackBarColorSuccess,
          ));
          await fetchReturns();
          update();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: res.msg,
            color: AppColors.snackBarColorFailure,
          ));
        }
      },
    ).onError((error, stackTrace) => null);
  }

  Future<void> denyReturns({required int slotId, required BuildContext context}) async {
    var data = {};

    data['slot_id'] = slotId;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.denyReturns(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
        );
        await fetchReturns();
        await fetchInventory();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
        );
      }
    }).onError((error, stackTrace) => null);
  }

  List<TableRow> returnsTableMaker(List<MaterialsReturn> returnsList) {
    List<TableRow> retMaterialTableRows = [];
    returnsList.forEach(
      (element) {
        retMaterialTableRows.add(
          TableRow(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.matDetails!.material.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyRet.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                )),
          ]),
        );
      },
    );
    return retMaterialTableRows;
  }

  Future<void> fetchOrders() async {
    await smri.getOrders().then((res) {
      ordersList.clear();

      if (res.status == '200') {
        res.data!.forEach(
          (element) {
            if (element.recieved == false) {
              ordersList.add(element);
            }
          },
        );
      }
    }).onError((error, stackTrace) => null);

    isExpandedForOrders = List.generate(ordersList.length, (index) => false);
    debugPrint(isExpandedForOrders.toString());
  }

  List<TableRow> ordersTableMaker(List<OrderDetails> ordersListFromUi) {
    List<TableRow> ordersListForTableMaker = [];
    ordersListFromUi.forEach(
      (element) {
        ordersListForTableMaker.add(
          TableRow(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.matDetails!.material.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                )),
          ]),
        );
      },
    );
    return ordersListForTableMaker;
  }

  void toggleExpansionForOrders(int index) {
    isExpandedForOrders[index] = !isExpandedForOrders[index];
    update(); // Trigger a UI update
  }

  void addRow() async {
    tableRows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemNameCtrl.text,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                itemQtyCtrl.text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
    update();

    selectedOptionForOC == 'Order'
        ? materials!.forEach(
            (element) {
              if (itemNameCtrl.text == element.material!.toLowerCase()) {
                sendApiList.add({
                  'm_id': element.id,
                  'ord_qty': itemQtyCtrl.text,
                });
              }
            },
          )
        : products!.forEach(
            (element) {
              if (itemNameCtrl.text == element.product!.toLowerCase()) {
                sendApiList.add({
                  'prod_id': element.id,
                  'qty': itemQtyCtrl.text,
                });
              }
            },
          );
    update();

    // debugPrint(sendApiList.toString());

    itemNameCtrl.clear();
    itemQtyCtrl.clear();
    update();
  }

  Future<void> sendOrder(BuildContext context) async {
    if (itemNameCtrl.text.isNotEmpty && itemQtyCtrl.text.isNotEmpty) {
      addRow();
    }

    var data = {};

    data['supp_name'] = suppNameCtrl.text;
    data['t_amount'] = totalAmtCtrl.text;
    data['invoice'] = invoiceCtrl.text;
    data['vehicle'] = vehicleCtrl.text;
    data['remarks'] = remarksCtrl.text;
    data['exp_date'] = DateTime.now().toString();
    data['pur_by'] = await SecuredStorage.readStringValue(Keys.id);
    data['orders'] = sendApiList;

    await smri.sendOrder(data).then(
      (res) {
        if (res.status == '200') {
          ScaffoldMessenger.of(context)
              .showSnackBar(appSnackbar(msg: 'Succesfully Uploaded Purchases', color: AppColors.snackBarColorSuccess));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure));
        }
      },
    );

    await fetchOrders();
    update();
  }

  void issueMaterialsButton(List<Requisition> a) {
    issuedQtyList.clear();
    currentRequesitions = a;
    Get.toNamed(AppRoutes.issueMaterials);
  }

  Future<void> fetchConsignments() async {
    await smri.getConsignments().then(
      (res) {
        if (res.status == '200') {
          consignmentsList = res.data!;
        } else {
          debugPrint('fetchConsignment msg: ${res.msg}');
        }
      },
    ).onError(
      (error, stackTrace) {
        debugPrint('Error in fetchConsignment()');
      },
    );

    isExpandedForConsignments = List.generate(consignmentsList.length, (index) => false);
    debugPrint(isExpandedForConsignments.toString());
  }

  Future<void> sendConsignment(BuildContext context) async {
    if (itemNameCtrl.text.isNotEmpty && itemQtyCtrl.text.isNotEmpty) {
      addRow();
    }

    var data = {};

    data['buyer'] = buyerCtrl.text;
    data['invoice_value'] = amountCtrl.text;
    data['invoice'] = cInvoiceCtrl.text;
    data['veh_no'] = cVehNoCtrl.text;
    data['transport_name'] = transportCtrl.text;
    data['driv_name'] = drivNameCtrl.text;
    data['driv_phone'] = drivPhoneCtrl.text;
    data['driv_license'] = drivLicCtrl.text;
    data['remarks'] = cRemarkCtrl.text;
    data['dis_by'] = await SecuredStorage.readStringValue(Keys.id);
    data['consigns'] = sendApiList;

    await smri.sendConsignment(data).then(
      (res) {
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(
              appSnackbar(msg: 'Succesfully Uploaded Consignment', color: AppColors.snackBarColorSuccess));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure));
        }
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(appSnackbar(msg: 'Some Error', color: AppColors.snackBarColorFailure));
      },
    );

    await fetchConsignments();
    update();
  }

  void toggleExpansionForConsignments(int index) {
    isExpandedForConsignments[index] = !isExpandedForConsignments[index];
    update(); // Trigger a UI update
  }

  List<TableRow> consignmentsTableMaker(List<Consignment> consignmentsListFromUi) {
    List<TableRow> consignmentsListForTableMaker = [];
    consignmentsListFromUi.forEach(
      (element) {
        consignmentsListForTableMaker.add(
          TableRow(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: element.product!.product!,
                    color: AppColors.txtColor,
                    size: 16,
                    fontFamily: AppFonts.interRegular,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qty.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
            ],
          ),
        );
      },
    );
    return consignmentsListForTableMaker;
  }

  Future<void> fetchHandovers() async {
    await smri.getHandovers().then((res) {
      if (res.status == '200') {
        handoversList = res.data!;
      } else {
        debugPrint('fetchHandovers msg: ${res.msg}');
      }
    }).onError((error, stackTrace) {
      debugPrint('Error in fetchHandovers()');
    });

    isExpandedForHandovers = List.generate(handoversList.length, (index) => false);
    debugPrint(isExpandedForHandovers.toString());
  }

  void toggleExpansionForHandovers(int index) {
    isExpandedForHandovers[index] = !isExpandedForHandovers[index];
    update(); // Trigger a UI update
  }

  List<TableRow> handoversTableMaker(List<Handover> handoverssListFromUi) {
    List<TableRow> handoversListForTableMaker = [];
    handoverssListFromUi.forEach(
      (element) {
        handoversListForTableMaker.add(
          TableRow(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: element.product!.product!,
                    color: AppColors.txtColor,
                    size: 16,
                    fontFamily: AppFonts.interRegular,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
            ],
          ),
        );
      },
    );
    return handoversListForTableMaker;
  }

  Future<void> approveHandover({required int batchId, required BuildContext context}) async {
    var data = {};

    data['batch_id'] = batchId;
    data['recieved_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.approveHandover(data).then(
      (res) async {
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: res.msg,
            color: AppColors.snackBarColorSuccess,
          ));
          await fetchHandovers();
          update();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: res.msg,
            color: AppColors.snackBarColorFailure,
          ));
        }
      },
    ).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something went Wrong',
        color: AppColors.snackBarColorFailure,
      ));
    });
  }
}
