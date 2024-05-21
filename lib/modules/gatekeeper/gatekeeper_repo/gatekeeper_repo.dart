import 'package:tethys/modules/gatekeeper/models/gatekeeper _model.dart';
import 'package:tethys/modules/gatekeeper/models/verify_orders_model.dart';

abstract class GateKeepRepo {
  Future<OrdersList> getOrders();
  Future<VerifyOrdersModel> verifyOrders(Map data);
}
