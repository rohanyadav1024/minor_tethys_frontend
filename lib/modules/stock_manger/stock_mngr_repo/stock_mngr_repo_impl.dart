import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/prod_manager/models/get_material_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_products_list_model.dart';
import 'package:tethys/modules/stock_manger/models/approve_handovers_model.dart';
import 'package:tethys/modules/stock_manger/models/approve_returns_model.dart';
import 'package:tethys/modules/stock_manger/models/deny_request_model.dart';
import 'package:tethys/modules/stock_manger/models/deny_returns_model.dart';
import 'package:tethys/modules/stock_manger/models/get_consignments_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_handovers_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_inventory_model.dart';
import 'package:tethys/modules/stock_manger/models/get_orders_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_returns_list_model.dart';
import 'package:tethys/modules/stock_manger/models/issue_request_model.dart.dart';
import 'package:tethys/modules/stock_manger/models/send_consignments_model.dart';
import 'package:tethys/modules/stock_manger/models/send_order_model.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo.dart';

class StockMngrRepoImpl extends StockMngrRepo {
  ApiService apiService = ApiService();

  @override
  Future<GetInventoryModel> getInventory() async {
    return getInventoryModelFromJson(
      await apiService.get(Endpoints.getInventory),
    );
  }

  @override
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

  @override
  Future<MaterialRequestModel> getrequests() async {
    return materialRequestModelFromJson(
      await apiService.get(Endpoints.getReqListForSmngr),
    );
  }

  @override
  Future<IssueRequesitionsModel> issueRequest(Map data) async {
    return issueRequesitionsModelFromJson(
      await apiService.post(Endpoints.issueRequesitions, data),
    );
  }

  @override
  Future<DenyRequestModel> denyRequest(Map data) async {
    return denyRequestModelFromJson(
      await apiService.delete(Endpoints.denyRequest, data),
    );
  }

  @override
  Future<GetReturnsListModel> fetchReturns() async {
    return getReturnsListModelFromJson(
      await apiService.get(Endpoints.getReturnsList),
    );
  }

  @override
  Future<ApproveReturnsModel> approveReturn(Map data) async {
    return approveReturnsModelFromJson(
      await apiService.post(Endpoints.approveReturn, data),
    );
  }

  Future<DenyReturnsModel> denyReturns(Map data) async {
    return denyReturnsModelFromJson(
      await apiService.delete(Endpoints.denyReturns, data),
    );
  }

  @override
  Future<OrdersListForSMngr> getOrders() async {
    return ordersListFromJson(
      await apiService.get(Endpoints.getOrderList),
    );
  }

  @override
  Future<SendOrderModel> sendOrder(Map data) async {
    return sendOrderModelFromJson(
      await apiService.post(Endpoints.sendOrder, data),
    );
  }

  @override
  Future<GetConsignmentListModel> getConsignments() async {
    return getConsignmentListModelFromJson(
      await apiService.get(Endpoints.getConsignmentList),
    );
  }

  @override
  Future<SendConsignmentsModel> sendConsignment(Map data) async {
    return sendConsignmentsModelFromJson(
      await apiService.post(Endpoints.sendConsignment, data),
    );
  }

  @override
  Future<GetHandoversListModel> getHandovers() async {
    return getHandoversListModelFromJson(
      await apiService.get(Endpoints.getHandoversListForSmngr),
    );
  }

  @override
  Future<ApproveHandoversModel> approveHandover(Map data) async {
    return approveHandoversModelFromJson(
      await apiService.post(Endpoints.approveHandovers, data),
    );
  }
}
