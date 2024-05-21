// To parse this JSON data, do
//
//     final returnsArchivedModel = returnsArchivedModelFromJson(jsonString);

import 'dart:convert';

ReturnsArchivedModel returnsArchivedModelFromJson(String str) => ReturnsArchivedModel.fromJson(json.decode(str));

String returnsArchivedModelToJson(ReturnsArchivedModel data) => json.encode(data.toJson());

class ReturnsArchivedModel {
  String? status;
  String? msg;
  List<RetArchDatum>? data;

  ReturnsArchivedModel({
    this.status,
    this.msg,
    this.data,
  });

  factory ReturnsArchivedModel.fromJson(Map<String, dynamic> json) => ReturnsArchivedModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<RetArchDatum>.from(json["data"]!.map((x) => RetArchDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RetArchDatum {
  int? retSlotId;
  int? reqSlotId;
  DateTime? retTime;
  String? remarks;
  bool? approved;
  RetBy? retBy;
  List<Return>? returns;

  RetArchDatum({
    this.retSlotId,
    this.reqSlotId,
    this.retTime,
    this.remarks,
    this.approved,
    this.retBy,
    this.returns,
  });

  factory RetArchDatum.fromJson(Map<String, dynamic> json) => RetArchDatum(
        retSlotId: json["ret_slot_id"],
        reqSlotId: json["req_slot_id"],
        retTime: json["ret_time"] == null ? null : DateTime.parse(json["ret_time"]),
        remarks: json["remarks"],
        approved: json["approved"],
        retBy: json["ret_by"] == null ? null : RetBy.fromJson(json["ret_by"]),
        returns: json["returns"] == null ? [] : List<Return>.from(json["returns"]!.map((x) => Return.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ret_slot_id": retSlotId,
        "req_slot_id": reqSlotId,
        "ret_time": retTime?.toIso8601String(),
        "remarks": remarks,
        "approved": approved,
        "ret_by": retBy?.toJson(),
        "returns": returns == null ? [] : List<dynamic>.from(returns!.map((x) => x.toJson())),
      };
}

class RetBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  RetBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory RetBy.fromJson(Map<String, dynamic> json) => RetBy(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "phone": phone,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
      };
}

class Return {
  int? retId;
  int? qtyReq;
  int? qtyIssued;
  int? qtyConsumed;
  int? qtyRet;
  MatDetails? matDetails;

  Return({
    this.retId,
    this.qtyReq,
    this.qtyIssued,
    this.qtyConsumed,
    this.qtyRet,
    this.matDetails,
  });

  factory Return.fromJson(Map<String, dynamic> json) => Return(
        retId: json["ret_id"],
        qtyReq: json["qty_req"],
        qtyIssued: json["qty_issued"],
        qtyConsumed: json["qty_consumed"],
        qtyRet: json["qty_ret"],
        matDetails: json["mat_details"] == null ? null : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "ret_id": retId,
        "qty_req": qtyReq,
        "qty_issued": qtyIssued,
        "qty_consumed": qtyConsumed,
        "qty_ret": qtyRet,
        "mat_details": matDetails?.toJson(),
      };
}

class MatDetails {
  int? id;
  String? umo;
  int? gNo;
  String? material;

  MatDetails({
    this.id,
    this.umo,
    this.gNo,
    this.material,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        id: json["id"],
        umo: json["umo"],
        gNo: json["g_no"],
        material: json["material"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "umo": umo,
        "g_no": gNo,
        "material": material,
      };
}
