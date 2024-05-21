import 'package:flutter/material.dart';
import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/owner/models/accept_emp_req_model.dart';
import 'package:tethys/modules/owner/models/deny_emp_req_model.dart';
import 'package:tethys/modules/owner/models/get_emp_req_model.dart';
import 'package:tethys/modules/owner/owner_repo/owner_repo.dart';

class OwnerRepoImpl extends OwnerRepo {
  ApiService apiService = ApiService();

  @override
  Future<GetEmpReqModel> getEmpReq() async {
    return getEmpReqModelFromJson(
      await apiService.get(Endpoints.getEmpRequests),
    );
  }

  @override
  Future<AcceptEmpReqModel> acceptEmpReq(data) async {
    return acceptEmpReqModelFromJson(
      await apiService.post(Endpoints.acceptEmpReq, data),
    );
  }

  @override
  Future<DenyEmpReqModel> denyEmpReq(Map data) async {
    return denyEmpReqModelFromJson(
      await apiService.delete(Endpoints.denyEmpReq, data),
    );
  }
}
