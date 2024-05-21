// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/owner/models/get_emp_req_model.dart';
import 'package:tethys/modules/owner/owner_repo/owner_repo_impl.dart';
import 'package:tethys/modules/owner/views/employee_requests.dart';
import 'package:tethys/modules/owner/views/owner_dashboard_view.dart';
import 'package:tethys/modules/owner/views/user_list_screen.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';

class OwnerVM extends GetxController {
  OwnerRepoImpl ori = OwnerRepoImpl();
  Widget? child = const OwnerDashboard();
  RxInt indx = 0.obs;
  double? topPadding;
  bool? isloading = true;

  List<EmpReqDatum> empReqList = [];

  List<bool> isExpandedForEmpReq = [];

  @override
  void onInit() async {
    // debugPrint(await SecuredStorage.readIntValue(Keys.id).toString());
    isloading = true;
    update();
    super.onInit();
    await Future.wait([
      fetchEmpReq(),
    ]);
    isloading = false;
    update();
  }

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = OwnerDashboard();
        break;
      case 1:
        child = UserListScreen();
        break;
      case 2:
        child = EmployeeRequests();
        break;
    }

    update();
  }

  Future<void> fetchEmpReq() async {
    empReqList.clear();

    await ori.getEmpReq().then((res) {
      if (res.status == '200') {
        res.data!.forEach((element) {
          empReqList.add(element);
        });
        isExpandedForEmpReq = List.generate(empReqList.length, (index) => false);
        update();
      } else {
        debugPrint(res.status);
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  Future<void> acceptRequest({required BuildContext context, required int id}) async {
    //implement permiting request api here and pass id as 'req_id'
    var data = {};

    data['req_id'] = id;

    debugPrint(data.toString());

    await ori.acceptEmpReq(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Employee Request Accepted',
          color: AppColors.snackBarColorSuccess,
        ));
        await fetchEmpReq();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Some error occured!',
          color: AppColors.snackBarColorFailure,
        ));
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something went Wrong!',
        color: AppColors.snackBarColorFailure,
      ));
    });
  }

  Future<void> denyRequest({required BuildContext context, required int id}) async {
    //implement deleteing request api here and pass id as 'req_id'
    var data = {};

    data['req_id'] = id.toString();

    debugPrint(data.toString());

    await ori.denyEmpReq(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Employee Request Accepted',
          color: AppColors.snackBarColorSuccess,
        ));
        await fetchEmpReq();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: 'Some error occured!',
          color: AppColors.snackBarColorFailure,
        ));
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something went Wrong',
        color: AppColors.snackBarColorFailure,
      ));
    });
  }

  void toggleExpansionForEmpReq(int index) {
    isExpandedForEmpReq[index] = !isExpandedForEmpReq[index];
    update();
  }

  @override
  void dispose() {
    super.dispose();
    empReqList.clear();
  }
}
