import 'dart:convert';

RequestItemsModel requestItemsModelFromJson(String str) =>
    RequestItemsModel.fromJson(json.decode(str));

String requestItemsModelToJson(RequestItemsModel data) =>
    json.encode(data.toJson());

class RequestItemsModel {
  String? status;
  String? msg;
  Data? data;

  RequestItemsModel({
    this.status,
    this.msg,
    this.data,
  });

  factory RequestItemsModel.fromJson(Map<String, dynamic> json) =>
      RequestItemsModel(
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
  DateTime? reqTime;
  String? remarks;
  bool? issueStatus;
  ReqBy? reqBy;
  List<Requisition>? requisitions;

  Data({
    this.slotId,
    this.reqTime,
    this.remarks,
    this.issueStatus,
    this.reqBy,
    this.requisitions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slotId: json["slot_id"],
        reqTime:
            json["req_time"] == null ? null : DateTime.parse(json["req_time"]),
        remarks: json["remarks"],
        issueStatus: json["issue_status"],
        reqBy: json["req_by"] == null ? null : ReqBy.fromJson(json["req_by"]),
        requisitions: json["requisitions"] == null
            ? []
            : List<Requisition>.from(
                json["requisitions"]!.map((x) => Requisition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "req_time": reqTime?.toIso8601String(),
        "remarks": remarks,
        "issue_status": issueStatus,
        "req_by": reqBy?.toJson(),
        "requisitions": requisitions == null
            ? []
            : List<dynamic>.from(requisitions!.map((x) => x.toJson())),
      };
}

class ReqBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  ReqBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory ReqBy.fromJson(Map<String, dynamic> json) => ReqBy(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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

class Requisition {
  int? reqId;
  int? qtyReq;
  MatDetails? matDetails;

  Requisition({
    this.reqId,
    this.qtyReq,
    this.matDetails,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) => Requisition(
        reqId: json["req_id"],
        qtyReq: json["qty_req"],
        matDetails: json["mat_details"] == null
            ? null
            : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "qty_req": qtyReq,
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
