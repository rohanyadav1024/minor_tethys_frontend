import 'package:tethys/modules/owner/models/accept_emp_req_model.dart';
import 'package:tethys/modules/owner/models/deny_emp_req_model.dart';
import 'package:tethys/modules/owner/models/get_emp_req_model.dart';

abstract class OwnerRepo {
  Future<GetEmpReqModel> getEmpReq();
  Future<AcceptEmpReqModel> acceptEmpReq(data);
  Future<DenyEmpReqModel> denyEmpReq(Map data);
}
