import 'dart:convert';

PostHandoverModel postHandoverModelFromJson(String str) => PostHandoverModel.fromJson(json.decode(str));

String postHandoverModelToJson(PostHandoverModel data) => json.encode(data.toJson());

class PostHandoverModel {
  String? status;
  String? msg;
  Data? data;

  PostHandoverModel({
    this.status,
    this.msg,
    this.data,
  });

  factory PostHandoverModel.fromJson(Map<String, dynamic> json) => PostHandoverModel(
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
  int? batchId;
  int? reqSlotId;
  DateTime? mfg;
  String? remarks;
  bool? isRecieved;
  HandoverBy? handoverBy;
  List<Handover>? handovers;

  Data({
    this.batchId,
    this.reqSlotId,
    this.mfg,
    this.remarks,
    this.isRecieved,
    this.handoverBy,
    this.handovers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        batchId: json["batch_id"],
        reqSlotId: json["req_slot_id"],
        mfg: json["mfg"] == null ? null : DateTime.parse(json["mfg"]),
        remarks: json["remarks"],
        isRecieved: json["is_recieved"],
        handoverBy: json["handover_by"] == null ? null : HandoverBy.fromJson(json["handover_by"]),
        handovers:
            json["handovers"] == null ? [] : List<Handover>.from(json["handovers"]!.map((x) => Handover.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "req_slot_id": reqSlotId,
        "mfg": mfg?.toIso8601String(),
        "remarks": remarks,
        "is_recieved": isRecieved,
        "handover_by": handoverBy?.toJson(),
        "handovers": handovers == null ? [] : List<dynamic>.from(handovers!.map((x) => x.toJson())),
      };
}

class HandoverBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  HandoverBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory HandoverBy.fromJson(Map<String, dynamic> json) => HandoverBy(
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

class Handover {
  int? handoverId;
  String? productName;
  int? qtyReq;

  Handover({
    this.handoverId,
    this.productName,
    this.qtyReq,
  });

  factory Handover.fromJson(Map<String, dynamic> json) => Handover(
        handoverId: json["handover_id"],
        productName: json["product_name"],
        qtyReq: json["qty_req"],
      );

  Map<String, dynamic> toJson() => {
        "handover_id": handoverId,
        "product_name": productName,
        "qty_req": qtyReq,
      };
}
