import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/gatekeeper/models/gatekeeper _model.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_repo/gatekeeper_repo.dart';
import 'package:tethys/modules/gatekeeper/models/verify_orders_model.dart';

class GateKeepRepoImpl extends GateKeepRepo {
  ApiService apiService = ApiService();

  @override
  Future<OrdersList> getOrders() async {
    return ordersListFromJson(
      await apiService.get(Endpoints.getOrderList),
    );
  }

  @override
  Future<VerifyOrdersModel> verifyOrders(Map data) async {
    return verifyOrdersModelFromJson(await apiService.post(Endpoints.verifyOrders, data));
  }
}
