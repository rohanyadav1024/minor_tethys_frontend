// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/archive/archive_models/returns_archived_model.dart';
import 'package:tethys/modules/archive/archive_repo/archive_repo_impl.dart';
import 'package:tethys/modules/archive/archive_models/requests_archived_model.dart';
import 'package:tethys/modules/archive/archive_views/requests_container.dart';
import 'package:tethys/modules/archive/archive_views/returns_container.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ArchiveVM extends GetxController {
  ArchiveRepoImpl ari = ArchiveRepoImpl();

  var empid = SecuredStorage.readIntValue(Keys.id);
  int PageCounter = -1;
  double? topPadding;
  bool? isloading = true;
  String selectedOption = 'Requests';
  Widget? lVContainer = RequestsContainer();
  BuildContext? context;

  List<bool> isExpandedForArchRequests = [];
  List<bool> isExpandedForArchReturns = [];

  List<ReqArchDatum> archivedReqList = [];
  List<RetArchDatum> archivedRetList = [];

  @override
  void onInit() async {
    super.onInit();
    isloading = true;
    update();
    await Future.delayed(Duration(seconds: 1));
    await Future.wait([
      fetchArchRequests(context: context!),
    ]);
    isloading = false;
    update();
  }

  void onSelectedOptionChange() async {
    switch (selectedOption) {
      case "Requests":
        archivedReqList.clear();
        await fetchArchRequests(context: context!);
        lVContainer = RequestsContainer();
        break;
      case 'Returns':
        archivedRetList.clear();
        await fetchArchReturns(context: context!);
        lVContainer = ReturnsContainer();
        break;
      default:
        lVContainer = Container();
    }
    update();
  }

  Future<void> fetchArchRequests({required BuildContext context}) async {
    ++PageCounter;
    var data = {};

    data['emp_id'] = await empid;
    data['limit'] = 10;
    data['offset'] = PageCounter;

    await ari.getArchivedRequest(data).then((res) {
      if (res.status == '200' && res.data!.isNotEmpty) {
        res.data!.forEach(
          (element) {
            archivedReqList.add(element);
          },
        );
        update();
      } else if (res.status == '200' && res.data!.isEmpty) {
        --PageCounter;
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: 'No more records found', color: AppColors.snackBarColorFailure),
        );
      } else {
        debugPrint('fetchArchRequests msg: ${res.msg}');
      }
    }).onError((error, stackTrace) {
      debugPrint('Error in fetchArchRequests()');
    });

    isExpandedForArchRequests = List.generate(archivedReqList.length, (index) => false);
    debugPrint(isExpandedForArchRequests.toString());
  }

  void toggleExpansionForArchRequests(int index) {
    isExpandedForArchRequests[index] = !isExpandedForArchRequests[index];
    update(); // Trigger a UI update
  }

  List<TableRow> ArchRequestsTableMaker(List<Requisition> RequestsitionListFromUi) {
    List<TableRow> RequisitionListForTableMaker = [];
    RequestsitionListFromUi.forEach(
      (element) {
        RequisitionListForTableMaker.add(
          TableRow(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: element.matDetails!.material!,
                    color: AppColors.txtColor,
                    size: 14,
                    fontFamily: AppFonts.interRegular,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 14,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyIssued.toString(),
                  color: AppColors.txtColor,
                  size: 14,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyConsumed.toString(),
                  color: AppColors.txtColor,
                  size: 14,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
            ],
          ),
        );
      },
    );
    return RequisitionListForTableMaker;
  }

  Future<void> fetchArchReturns({required BuildContext context}) async {
    ++PageCounter;
    var data = {};

    data['emp_id'] = await empid;
    data['limit'] = 10;
    data['offset'] = PageCounter;

    await ari.getArchivedReturn(data).then((res) {
      if (res.status == '200' && res.data!.isNotEmpty) {
        res.data!.forEach(
          (element) {
            archivedRetList.add(element);
          },
        );
        update();
      } else if (res.status == '200' && res.data!.isEmpty) {
        --PageCounter;
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: 'No more records found', color: AppColors.snackBarColorFailure),
        );
      } else {
        debugPrint('fetchArchReturns msg: ${res.msg}');
      }
    }).onError((error, stackTrace) {
      debugPrint('Error in fetchArchReturns()');
    });

    isExpandedForArchReturns = List.generate(archivedRetList.length, (index) => false);
    debugPrint(isExpandedForArchReturns.toString());
  }

  void toggleExpansionForArchReturns(int index) {
    isExpandedForArchReturns[index] = !isExpandedForArchReturns[index];
    update(); // Trigger a UI update
  }

  List<TableRow> ArchReturnsTableMaker(List<Return> ReturnsListFromUi) {
    List<TableRow> ReturnsListForTableMaker = [];
    ReturnsListFromUi.forEach(
      (element) {
        ReturnsListForTableMaker.add(
          TableRow(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: element.matDetails!.material!,
                    color: AppColors.txtColor,
                    size: 14,
                    fontFamily: AppFonts.interRegular,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 14,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyIssued.toString(),
                  color: AppColors.txtColor,
                  size: 14,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyRet.toString(),
                  color: AppColors.txtColor,
                  size: 14,
                  fontFamily: AppFonts.interRegular,
                ),
              ),
            ],
          ),
        );
      },
    );
    return ReturnsListForTableMaker;
  }
}
