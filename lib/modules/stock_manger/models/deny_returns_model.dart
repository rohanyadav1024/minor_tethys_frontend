// To parse this JSON data, do
//
//     final denyReturnsModel = denyReturnsModelFromJson(jsonString);

import 'dart:convert';

DenyReturnsModel denyReturnsModelFromJson(String str) => DenyReturnsModel.fromJson(json.decode(str));

String denyReturnsModelToJson(DenyReturnsModel data) => json.encode(data.toJson());

class DenyReturnsModel {
  String? status;
  String? msg;
  Data? data;

  DenyReturnsModel({
    this.status,
    this.msg,
    this.data,
  });

  factory DenyReturnsModel.fromJson(Map<String, dynamic> json) => DenyReturnsModel(
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

  Data({
    this.slotId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slotId: json["slot_id"],
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
      };
}
