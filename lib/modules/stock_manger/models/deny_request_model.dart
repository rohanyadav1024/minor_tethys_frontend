// To parse this JSON data, do
//
//     final denyRequestModel = denyRequestModelFromJson(jsonString);

import 'dart:convert';

DenyRequestModel denyRequestModelFromJson(String str) => DenyRequestModel.fromJson(json.decode(str));

String denyRequestModelToJson(DenyRequestModel data) => json.encode(data.toJson());

class DenyRequestModel {
  String? status;
  String? msg;

  DenyRequestModel({
    this.status,
    this.msg,
  });

  factory DenyRequestModel.fromJson(Map<String, dynamic> json) => DenyRequestModel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
