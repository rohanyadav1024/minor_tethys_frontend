// ignore_for_file: prefer_const_constructors, annotate_overrides, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/gatekeeper/models/gatekeeper _model.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_views/consignment_view.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_views/order_view.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_repo/gatekeeper_repoimpl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class GatekeeperVM extends GetxController {
  RxInt indx = 0.obs;
  Widget? child = OrderView();
  GateKeepRepoImpl gkri = GateKeepRepoImpl();
  List<Datum> orderList = [];
  List<bool> isExpanded = [];
  List<TextEditingController> controllersList = [];
  List<Map<String, String>> qtyReceivedById = [];

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = OrderView();
        break;
      case 1:
        child = ConsignmentView();
        break;
    }

    update();
  }

  Future<void> fetchOrdersList() async {
    orderList.clear();
    await gkri.getOrders().then(
      (res) {
        if (res.status == "200") {
          res.data!.forEach((ord) {
            if (ord.recieved == false) {
              orderList.add(ord);
            }
          });
          isExpanded = List.generate(orderList.length, (index) => false);
          update();
        }
      },
    );

    print(orderList);
  }

  void toggleExpansion(int index) {
    isExpanded[index] = !isExpanded[index];
    update(); // Trigger a UI update
  }

  List<TableRow> orderTableMaker(List<Order> materialList) {
    List<TableRow> reqMaterialTableRows = [];
    qtyReceivedById.clear();

    materialList.forEach(
      (element) {
        reqMaterialTableRows.add(
          TableRow(
            children: [
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
                ),
              ),
            ],
          ),
        );
      },
    );
    return reqMaterialTableRows;
  }

  Future<void> approveOrder({
    required int purId,
    required List<Order> orders,
    required BuildContext context,
  }) async {
    qtyReceivedById.clear();
    orders.forEach((element) {
      qtyReceivedById.add({
        'order_id': element.orderId.toString(),
        'qty_recieved': element.qtyReq.toString(),
      });
    });
    debugPrint(qtyReceivedById.toString());

    var data = {};

    data['pur_id'] = purId;
    data['recieved_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['orders'] = qtyReceivedById;

    gkri.verifyOrders(data).then(
      (res) async {
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
          );
          await fetchOrdersList();
          update();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
          );
        }
      },
    ).onError((error, stackTrace) => null);
  }
}
