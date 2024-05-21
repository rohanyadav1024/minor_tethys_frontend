// ignore_for_file: annotate_overrides

import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/prod_manager/models/get_handovers_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_material_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_pm_Inventory_model.dart';
import 'package:tethys/modules/prod_manager/models/get_products_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_returns_model.dart';
import 'package:tethys/modules/prod_manager/models/mark_complete_model.dart';
import 'package:tethys/modules/prod_manager/models/post_handover_model.dart';
import 'package:tethys/modules/prod_manager/models/request_items_model.dart';
import 'package:tethys/modules/prod_manager/models/get_requests_list_model.dart';
import 'package:tethys/modules/prod_manager/models/return_material_model.dart';
import 'package:tethys/modules/prod_manager/models/update_consumptions_model.dart';
import 'prod_mngr_repo.dart';

class ProdMngrRepoImpl extends ProdMngrRepo {
  ApiService apiService = ApiService();

  Future<GetPmInventoryModel> getPmInventroy() async {
    return getPmInventoryModelFromJson(
      await apiService.get(Endpoints.getPmInventory),
    );
  }

  Future<GetItemsListModel> getItemsList() async {
    return getItemsListModelFromJson(
      await apiService.get(Endpoints.getItemsList),
    );
  }

  Future<GetProductsList> getProductList() async {
    return getProductsListFromJson(
      await apiService.get(Endpoints.getProductsList),
    );
  }

  Future<RequestItemsModel> requestItems(Map data) async {
    return requestItemsModelFromJson(
      await apiService.post(Endpoints.sendRequestforItems, data),
    );
  }

  Future<RequisitionListModel> getRequisitionList(Map data) async {
    return requisitionListModelFromJson(
      await apiService.post(Endpoints.getReqListForPmngr, data),
    );
  }

  Future<ReturnMaterialModel> returnMaterial(Map data) async {
    return returnMaterialModelFromJson(
      await apiService.post(Endpoints.returnMaterial, data),
    );
  }

  Future<GetReturnsModel> fetchReturns(Map data) async {
    return getReturnsModelFromJson(
      await apiService.post(Endpoints.getReturnsForPmngr, data),
    );
  }

  Future<PostHandoverModel> postHandover(Map data) async {
    return postHandoverModelFromJson(
      await apiService.post(Endpoints.postHandover, data),
    );
  }

  Future<GetHandoversListModel> getHandoversList(Map data) async {
    return getHandoversListModelFromJson(
      await apiService.post(Endpoints.getHandoversForPmngr, data),
    );
  }

  Future<MarkCompleteModel> markComplete(Map data) async {
    return markCompleteModelFromJson(
      await apiService.post(Endpoints.markComplete, data),
    );
  }

  Future<UpdateConsumptionModel> updateConsumptions(Map data) async {
    return updateConsumptionModelFromJson(
      await apiService.post(Endpoints.updateConsumption, data),
    );
  }
}
