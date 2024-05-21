// To parse this JSON data, do
//
//     final updateConsumptionModel = updateConsumptionModelFromJson(jsonString);

import 'dart:convert';

UpdateConsumptionModel updateConsumptionModelFromJson(String str) => UpdateConsumptionModel.fromJson(json.decode(str));

String updateConsumptionModelToJson(UpdateConsumptionModel data) => json.encode(data.toJson());

class UpdateConsumptionModel {
  String? status;
  String? msg;

  UpdateConsumptionModel({
    this.status,
    this.msg,
  });

  factory UpdateConsumptionModel.fromJson(Map<String, dynamic> json) => UpdateConsumptionModel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
