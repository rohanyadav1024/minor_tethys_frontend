// To parse this JSON data, do
//
//     final getPmInventoryModel = getPmInventoryModelFromJson(jsonString);

import 'dart:convert';

GetPmInventoryModel getPmInventoryModelFromJson(String str) => GetPmInventoryModel.fromJson(json.decode(str));

String getPmInventoryModelToJson(GetPmInventoryModel data) => json.encode(data.toJson());

class GetPmInventoryModel {
  String? status;
  String? msg;
  List<PmInventoryDatum>? data;

  GetPmInventoryModel({
    this.status,
    this.msg,
    this.data,
  });

  factory GetPmInventoryModel.fromJson(Map<String, dynamic> json) => GetPmInventoryModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<PmInventoryDatum>.from(json["data"]!.map((x) => PmInventoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PmInventoryDatum {
  int? materialId;
  int? availableQty;
  MatDetails? matDetails;

  PmInventoryDatum({
    this.materialId,
    this.availableQty,
    this.matDetails,
  });

  factory PmInventoryDatum.fromJson(Map<String, dynamic> json) => PmInventoryDatum(
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
  String? material;
  int? gNo;
  int? id;
  String? umo;

  MatDetails({
    this.material,
    this.gNo,
    this.id,
    this.umo,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        material: json["material"],
        gNo: json["g_no"],
        id: json["id"],
        umo: json["umo"],
      );

  Map<String, dynamic> toJson() => {
        "material": material,
        "g_no": gNo,
        "id": id,
        "umo": umo,
      };
}
