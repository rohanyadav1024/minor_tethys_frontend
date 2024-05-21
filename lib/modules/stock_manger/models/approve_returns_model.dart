// To parse this JSON data, do
//
//     final approveReturnsModel = approveReturnsModelFromJson(jsonString);

import 'dart:convert';

ApproveReturnsModel approveReturnsModelFromJson(String str) => ApproveReturnsModel.fromJson(json.decode(str));

String approveReturnsModelToJson(ApproveReturnsModel data) => json.encode(data.toJson());

class ApproveReturnsModel {
  String? status;
  String? msg;
  Data? data;

  ApproveReturnsModel({
    this.status,
    this.msg,
    this.data,
  });

  factory ApproveReturnsModel.fromJson(Map<String, dynamic> json) => ApproveReturnsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  int? slotId;
  bool? approved;

  Data({
    this.slotId,
    this.approved,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slotId: json["slot_id"],
        approved: json["approved"],
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "approved": approved,
      };
}
