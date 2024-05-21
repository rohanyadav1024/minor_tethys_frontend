// To parse this JSON data, do
//
//     final getReturnsModel = getReturnsModelFromJson(jsonString);

import 'dart:convert';

GetReturnsModel getReturnsModelFromJson(String str) => GetReturnsModel.fromJson(json.decode(str));

String getReturnsModelToJson(GetReturnsModel data) => json.encode(data.toJson());

class GetReturnsModel {
  String? status;
  String? msg;
  List<ReturnsDatum>? data;

  GetReturnsModel({
    this.status,
    this.msg,
    this.data,
  });

  factory GetReturnsModel.fromJson(Map<String, dynamic> json) => GetReturnsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<ReturnsDatum>.from(json["data"]!.map((x) => ReturnsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReturnsDatum {
  int? slotId;
  DateTime? retTime;
  String? remarks;
  bool? approved;
  List<MaterialsReturn>? materialsReturn;

  ReturnsDatum({
    this.slotId,
    this.retTime,
    this.remarks,
    this.approved,
    this.materialsReturn,
  });

  factory ReturnsDatum.fromJson(Map<String, dynamic> json) => ReturnsDatum(
        slotId: json["slot_id"],
        retTime: json["ret_time"] == null ? null : DateTime.parse(json["ret_time"]),
        remarks: json["remarks"],
        approved: json["approved"],
        materialsReturn: json["materials_return"] == null
            ? []
            : List<MaterialsReturn>.from(json["materials_return"]!.map((x) => MaterialsReturn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "ret_time": retTime?.toIso8601String(),
        "remarks": remarks,
        "approved": approved,
        "materials_return": materialsReturn == null ? [] : List<dynamic>.from(materialsReturn!.map((x) => x.toJson())),
      };
}

class MaterialsReturn {
  int? retId;
  int? qtyRet;
  MatDetails? matDetails;

  MaterialsReturn({
    this.retId,
    this.qtyRet,
    this.matDetails,
  });

  factory MaterialsReturn.fromJson(Map<String, dynamic> json) => MaterialsReturn(
        retId: json["ret_id"],
        qtyRet: json["qty_ret"],
        matDetails: json["mat_details"] == null ? null : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "ret_id": retId,
        "qty_ret": qtyRet,
        "mat_details": matDetails?.toJson(),
      };
}

class MatDetails {
  String? material;
  int? gNo;
  int? id;
  Umo? umo;

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
        umo: umoValues.map[json["umo"]],
      );

  Map<String, dynamic> toJson() => {
        "material": material,
        "g_no": gNo,
        "id": id,
        "umo": umoValues.reverse[umo],
      };
}

enum Umo { KGS, NOS }

final umoValues = EnumValues({"kgs": Umo.KGS, "nos": Umo.NOS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
