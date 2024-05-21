// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/models/get_handovers_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_material_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_pm_Inventory_model.dart';
import 'package:tethys/modules/prod_manager/models/get_products_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_returns_model.dart';
import 'package:tethys/modules/prod_manager/models/get_requests_list_model.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_repo/prod_mngr_repo_impl.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/prod_mngr_dashboard.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/production_handover.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/requisition_return.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ProdMngrVM extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxInt indx = 0.obs;
  String selectedOption = 'Request Material';
  ProdMngrRepoImpl pmri = ProdMngrRepoImpl();
  Widget? child = ProdMngrDashboard();
  bool isRequests = true;
  List<TableRow> tableRows = [];
  double? topPadding;
  TextEditingController itemNameCtrl = TextEditingController();
  TextEditingController itemQtyCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();
  TextEditingController handoverTitleCtrl = TextEditingController();
  // TextEditingController handoverReqIdCtrl = TextEditingController();

  List<ReqListDatum> pendingRequisitionsList = [];
  List<ReturnsDatum> returnsList = [];
  List<HandoverDatum> handoversList = [];
  List<PmInventoryDatum> inventoryList = [];

  List<String> rawMatNameList = [];
  List<String> prodNameList = [];
  List<MaterialInfo> materials = [];
  List<ProductsInfo> products = [];

  List<Map> sendApiList = [];
  List<TableRow> invntryTableRows = [];
  List<Requisition> currentReqMaterials = [];
  var currentReqSlotId;
  List<Map<String?, dynamic>> returnedMaterialsList = [];
  List<Map<String?, dynamic>> consumedMaterialsList = [];

  List<bool> isExpanded = [];
  List<bool> isExpanded2 = [];
  List<bool> isExpandedForHandovers = [];

  late RequisitionListModel requisitions;

  @override
  void onInit() async {
    super.onInit();
    await fetchMaterialList();
    await fetchProductList();
    await fetchPmInventory();
    await fetchRequisitionList();
    await fetchReturns();
    await fetchHandovers();
  }

  Future<void> fetchMaterialList() async {
    materials.clear();
    await pmri.getItemsList().then(
      (res) {
        if (res.status == "200") {
          res.data!.forEach((element) {
            rawMatNameList.add(
              element.material!.toLowerCase(),
            );
          });
          materials = res.data!;
        }
      },
    ).onError((error, stackTrace) {
      debugPrint('Error in fetchMaterialList()');
    });
  }

  Future<void> fetchProductList() async {
    products.clear();
    await pmri.getProductList().then(
      (res) {
        if (res.status == '200') {
          res.data!.forEach(
            (element) {
              prodNameList.add(
                element.product!.toLowerCase(),
              );
            },
          );
          products = res.data!;
        }
      },
    ).onError((error, stackTrace) {
      debugPrint('Error in fetchProductsList()');
    });
  }

  Future<void> fetchPmInventory() async {
    inventoryList.clear();
    await pmri.getPmInventroy().then((res) {
      if (res.status == '200') {
        res.data!.forEach((element) {
          inventoryList.add(element);
        });
      }
    }).onError((error, stackTrace) => null);
    update();
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

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = ProdMngrDashboard();
        break;
      case 1:
        child = RequisitionReturnView();
        break;
      case 2:
        child = ProductionHandover();
        break;
    }

    update();
  }

  void toggleViews(bool value) {
    isRequests = value;
    update();
  }

  void addRow() {
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

    materials!.forEach(
      (element) {
        if (itemNameCtrl.text == element.material!.toLowerCase()) {
          sendApiList.add({
            'id': element.id,
            'qty': itemQtyCtrl.text,
          });
        }
      },
    );
    update();

    debugPrint(sendApiList.toString());

    itemNameCtrl.clear();
    itemQtyCtrl.clear();
    update();
  }

  Future<void> sendRequest(BuildContext context) async {
    if (itemNameCtrl.text.isNotEmpty && itemQtyCtrl.text.isNotEmpty) {
      addRow();
    }
    var data = {};

    data['items'] = sendApiList;
    data['req_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = remarkCtrl.text;

    debugPrint(data.toString());

    await pmri.requestItems(data).then(
      (res) async {
        debugPrint('success');
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Request sent succesfully',
            color: AppColors.snackBarColorSuccess,
          ));
          await fetchRequisitionList();
          update();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Request Not sent',
            color: AppColors.snackBarColorFailure,
          ));
        }
      },
    );
    remarkCtrl.clear();
    tableRows.clear();
  }

  void toggleExpansion(int index) {
    if (isRequests == true) {
      isExpanded[index] = !isExpanded[index];
    } else {
      isExpanded2[index] = !isExpanded2[index];
    }
    update(); // Trigger a UI update
  }

  Future<void> fetchRequisitionList() async {
    pendingRequisitionsList.clear();
    var data = {};
    data['emp_id'] = await SecuredStorage.readStringValue(Keys.id);
    // debugPrint(data.toString());

    await pmri.getRequisitionList(data).then(
      (res) {
        if (res.status == '200') {
          // RequisitionsList = res.data!;
          res.data!.forEach(
            (element) {
              pendingRequisitionsList.add(element);
            },
          );
          update();
          isExpanded = List.generate(pendingRequisitionsList.length, (index) => false);
        } else {
          debugPrint(res.msg);
        }
      },
    ).onError((error, stackTrace) => null);
  }

  Future<void> returnMaterial(BuildContext context) async {
    var data = {};
    data['items'] = returnedMaterialsList;
    data['req_slot_id'] = currentReqSlotId;
    data['req_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = remarkCtrl.text;
    debugPrint(data.toString());
    await pmri.returnMaterial(data).then(
      (res) async {
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Return Meterial Successfull',
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
    ).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something went wrong',
        color: AppColors.snackBarColorFailure,
      ));
    });
    tableRows.clear();
    await fetchRequisitionList();
    await fetchPmInventory();
    update();
  }

  Future<void> fetchReturns() async {
    returnsList.clear();

    var data = {};

    data['emp_id'] = await SecuredStorage.readIntValue(Keys.id);

    await pmri.fetchReturns(data).then(
      (res) {
        if (res.status == '200') {
          // debugPrint('res.data: ${res.data.toString()}');
          res.data!.forEach(
            (element) {
              returnsList.add(element);
            },
          );
        }
      },
    ).onError(
      (error, stackTrace) {
        debugPrint('Error in fetchReturns()');
      },
    );
    isExpanded2 = List.generate(returnsList.length, (index) => false);
    update();
    // debugPrint('returnList: ${returnsList.toString()}');
  }

  List<TableRow> returnsTableMaker(List<MaterialsReturn> returnsList2) {
    List<TableRow> retMaterialTableRows = [];
    returnsList2.forEach(
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

  List<TableRow> requestTableMaker(List<Requisition> requestList) {
    List<TableRow> reqMaterialTableRows = [];
    requestList.forEach(
      (element) {
        reqMaterialTableRows.add(
          TableRow(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.matDetails!.material.toString(),
                  color: AppColors.txtColor,
                  size: 14,
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
                  text: element.qtyConsumed.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
          ]),
        );
      },
    );
    return reqMaterialTableRows;
  }

  void toggleExpansionForHandovers(int index) {
    isExpandedForHandovers[index] = !isExpandedForHandovers[index];
    update();
  }

  void addRowForHandover() {
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

    products!.forEach(
      (element) {
        if (element.product!.toLowerCase() == itemNameCtrl.text) {
          sendApiList.add(
            {
              'prod_id': element.id,
              'qty': itemQtyCtrl.text,
            },
          );
        }
      },
    );
    update();

    debugPrint(sendApiList.toString());

    itemNameCtrl.clear();
    itemQtyCtrl.clear();
    update();
  }

  Future<void> sendHandover(BuildContext context) async {
    if (itemNameCtrl.text.isNotEmpty && itemQtyCtrl.text.isNotEmpty) {
      addRowForHandover();
    }

    var data = {};

    // data['req_slot_id'] = handoverReqIdCtrl.text;
    data['prods'] = sendApiList;
    data['hand_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = handoverTitleCtrl.text;

    debugPrint(data.toString());
    await pmri.postHandover(data).then((res) {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Handover Sent Succesfully',
          color: AppColors.snackBarColorSuccess,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Something wrong occured',
          color: AppColors.snackBarColorFailure,
        ));
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something wrong occured',
        color: AppColors.snackBarColorFailure,
      ));
    });
    await fetchHandovers();
    update();
  }

  Future<void> fetchHandovers() async {
    handoversList.clear();

    var data = {};
    data['emp_id'] = await SecuredStorage.readIntValue(Keys.id);
    await pmri.getHandoversList(data).then(
      (res) {
        if (res.status == '200') {
          res.data!.forEach((element) {
            handoversList.add(element);
          });
        }
      },
    ).onError((error, stackTrace) {
      debugPrint('Error in fetchHandovers()');
    });
    isExpandedForHandovers = List.generate(handoversList.length, (index) => false);
    update();
  }

  List<TableRow> handoverSlotTableMaker(List<Handover> handedoverProducts) {
    List<TableRow> handoverSlotTableRows = [];
    handedoverProducts.forEach(
      (element) {
        handoverSlotTableRows.add(
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: AppText(
                  text: element.product!.product!,
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
            ],
          ),
        );
      },
    );
    return handoverSlotTableRows;
  }

  void returnMaterialsButton(List<Requisition> a, var b) {
    returnedMaterialsList.clear();
    currentReqMaterials = a;
    currentReqSlotId = b;
    Get.toNamed(AppRoutes.returnMaterials);
  }

  Future<void> markComplete({
    required BuildContext context,
    required int slotId,
  }) async {
    var data = {};
    data['slot_id'] = slotId;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await pmri.markComplete(data).then((res) {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Slot Id $slotId marked as completed',
          color: AppColors.snackBarColorSuccess,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: res.msg,
          color: AppColors.snackBarColorFailure,
        ));
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something went wrong',
        color: AppColors.snackBarColorFailure,
      ));
    });
    await fetchRequisitionList();
    update();
  }

  void updateConsumptionsButton(List<Requisition> a, var b) {
    consumedMaterialsList.clear();
    currentReqMaterials = a;
    update();
    currentReqSlotId = b;
    Get.toNamed(AppRoutes.updateConsumptions);
  }

  Future<void> updateConsumptionsApi({required BuildContext context}) async {
    var data = {};

    data['items'] = consumedMaterialsList;
    data['upd_by'] = await SecuredStorage.readIntValue(Keys.id);

    pmri.updateConsumptions(data).then((res) {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Inventory Updated',
          color: AppColors.snackBarColorSuccess,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: res.msg,
          color: AppColors.snackBarColorFailure,
        ));
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something went wrong',
        color: AppColors.snackBarColorFailure,
      ));
    });
    await fetchRequisitionList();
    await fetchPmInventory();
    update();
  }
}
