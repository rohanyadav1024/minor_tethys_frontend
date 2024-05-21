// To parse this JSON data, do
//
//     final approveHandoversModel = approveHandoversModelFromJson(jsonString);

import 'dart:convert';

ApproveHandoversModel approveHandoversModelFromJson(String str) => ApproveHandoversModel.fromJson(json.decode(str));

String approveHandoversModelToJson(ApproveHandoversModel data) => json.encode(data.toJson());

class ApproveHandoversModel {
  String? status;
  String? msg;
  Data? data;

  ApproveHandoversModel({
    this.status,
    this.msg,
    this.data,
  });

  factory ApproveHandoversModel.fromJson(Map<String, dynamic> json) => ApproveHandoversModel(
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
  DateTime? mfg;
  String? remarks;
  bool? isRecieved;
  DateTime? recievedTime;
  RecievedBy? recievedBy;
  List<Handover>? handovers;

  Data({
    this.batchId,
    this.mfg,
    this.remarks,
    this.isRecieved,
    this.recievedTime,
    this.recievedBy,
    this.handovers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        batchId: json["batch_id"],
        mfg: json["mfg"] == null ? null : DateTime.parse(json["mfg"]),
        remarks: json["remarks"],
        isRecieved: json["is_recieved"],
        recievedTime: json["recieved_time"] == null ? null : DateTime.parse(json["recieved_time"]),
        recievedBy: json["recieved_by"] == null ? null : RecievedBy.fromJson(json["recieved_by"]),
        handovers:
            json["handovers"] == null ? [] : List<Handover>.from(json["handovers"]!.map((x) => Handover.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "mfg": mfg?.toIso8601String(),
        "remarks": remarks,
        "is_recieved": isRecieved,
        "recieved_time": recievedTime?.toIso8601String(),
        "recieved_by": recievedBy?.toJson(),
        "handovers": handovers == null ? [] : List<dynamic>.from(handovers!.map((x) => x.toJson())),
      };
}

class Handover {
  int? handoverId;
  Product? product;
  int? qtyReq;

  Handover({
    this.handoverId,
    this.product,
    this.qtyReq,
  });

  factory Handover.fromJson(Map<String, dynamic> json) => Handover(
        handoverId: json["handover_id"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        qtyReq: json["qty_req"],
      );

  Map<String, dynamic> toJson() => {
        "handover_id": handoverId,
        "product": product?.toJson(),
        "qty_req": qtyReq,
      };
}

class Product {
  String? product;
  int? id;

  Product({
    this.product,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: json["product"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "id": id,
      };
}

class RecievedBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  RecievedBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory RecievedBy.fromJson(Map<String, dynamic> json) => RecievedBy(
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
