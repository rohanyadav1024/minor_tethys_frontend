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

abstract class StockMngrRepo {
  Future<GetInventoryModel> getInventory();
  Future<GetItemsListModel> getItemsList();
  Future<GetProductsList> getProductList();
  Future<MaterialRequestModel> getrequests();
  Future<IssueRequesitionsModel> issueRequest(Map data);
  Future<DenyRequestModel> denyRequest(Map data);
  Future<GetReturnsListModel> fetchReturns();
  Future<ApproveReturnsModel> approveReturn(Map data);
  Future<DenyReturnsModel> denyReturns(Map data);
  Future<OrdersListForSMngr> getOrders();
  Future<SendOrderModel> sendOrder(Map data);
  Future<GetConsignmentListModel> getConsignments();
  Future<SendConsignmentsModel> sendConsignment(Map data);
  Future<GetHandoversListModel> getHandovers();
  Future<ApproveHandoversModel> approveHandover(Map data);
}
