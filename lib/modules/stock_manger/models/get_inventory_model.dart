// To parse this JSON data, do
//
//     final getInventoryModel = getInventoryModelFromJson(jsonString);

import 'dart:convert';

GetInventoryModel getInventoryModelFromJson(String str) => GetInventoryModel.fromJson(json.decode(str));

String getInventoryModelToJson(GetInventoryModel data) => json.encode(data.toJson());

class GetInventoryModel {
  String? status;
  String? msg;
  List<InventoryDatum>? data;

  GetInventoryModel({
    this.status,
    this.msg,
    this.data,
  });

  factory GetInventoryModel.fromJson(Map<String, dynamic> json) => GetInventoryModel(
        status: json["status"],
        msg: json["msg"],
        data:
            json["data"] == null ? [] : List<InventoryDatum>.from(json["data"]!.map((x) => InventoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class InventoryDatum {
  int? materialId;
  int? availableQty;
  MatDetails? matDetails;

  InventoryDatum({
    this.materialId,
    this.availableQty,
    this.matDetails,
  });

  factory InventoryDatum.fromJson(Map<String, dynamic> json) => InventoryDatum(
        materialId: json["material_id"],
        availableQty: json["available_qty"],
        matDetails: json["mat_details"] == null ? null : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "material_id": materialId,
        "available_qty": availableQty,
        "mat_details": matDetails?.toJson(),
      };
}

class MatDetails {
  int? id;
  String? umo;
  String? material;
  int? gNo;

  MatDetails({
    this.id,
    this.umo,
    this.material,
    this.gNo,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        id: json["id"],
        umo: json["umo"],
        material: json["material"],
        gNo: json["g_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "umo": umo,
        "material": material,
        "g_no": gNo,
      };
}
