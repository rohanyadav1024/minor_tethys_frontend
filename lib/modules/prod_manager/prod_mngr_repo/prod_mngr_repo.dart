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

abstract class ProdMngrRepo {
  Future<GetPmInventoryModel> getPmInventroy();
  Future<GetItemsListModel> getItemsList();
  Future<GetProductsList> getProductList();
  Future<RequestItemsModel> requestItems(Map data);
  Future<RequisitionListModel> getRequisitionList(Map data);
  Future<ReturnMaterialModel> returnMaterial(Map data);
  Future<GetReturnsModel> fetchReturns(Map data);
  Future<PostHandoverModel> postHandover(Map data);
  Future<GetHandoversListModel> getHandoversList(Map data);
  Future<MarkCompleteModel> markComplete(Map data);
  Future<UpdateConsumptionModel> updateConsumptions(Map data);
}
