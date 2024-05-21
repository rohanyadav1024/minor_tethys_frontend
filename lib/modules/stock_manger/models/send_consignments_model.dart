// To parse this JSON data, do
//
//     final sendConsignmentsModel = sendConsignmentsModelFromJson(jsonString);

import 'dart:convert';

SendConsignmentsModel sendConsignmentsModelFromJson(String str) => SendConsignmentsModel.fromJson(json.decode(str));

String sendConsignmentsModelToJson(SendConsignmentsModel data) => json.encode(data.toJson());

class SendConsignmentsModel {
  String? status;
  String? msg;
  Data? data;

  SendConsignmentsModel({
    this.status,
    this.msg,
    this.data,
  });

  factory SendConsignmentsModel.fromJson(Map<String, dynamic> json) => SendConsignmentsModel(
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
  int? disId;
  String? buyer;
  String? invoice;
  int? invValue;
  dynamic recvTime;
  bool? checkout;
  DisBy? disBy;
  DriverDetials? driverDetials;
  Vehicle? vehicle;
  List<Consignment>? consignments;

  Data({
    this.disId,
    this.buyer,
    this.invoice,
    this.invValue,
    this.recvTime,
    this.checkout,
    this.disBy,
    this.driverDetials,
    this.vehicle,
    this.consignments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        disId: json["dis_id"],
        buyer: json["buyer"],
        invoice: json["invoice"],
        invValue: json["inv_value"],
        recvTime: json["recv_time"],
        checkout: json["checkout"],
        disBy: json["dis_by"] == null ? null : DisBy.fromJson(json["dis_by"]),
        driverDetials: json["driver_detials"] == null ? null : DriverDetials.fromJson(json["driver_detials"]),
        vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        consignments: json["consignments"] == null
            ? []
            : List<Consignment>.from(json["consignments"]!.map((x) => Consignment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dis_id": disId,
        "buyer": buyer,
        "invoice": invoice,
        "inv_value": invValue,
        "recv_time": recvTime,
        "checkout": checkout,
        "dis_by": disBy?.toJson(),
        "driver_detials": driverDetials?.toJson(),
        "vehicle": vehicle?.toJson(),
        "consignments": consignments == null ? [] : List<dynamic>.from(consignments!.map((x) => x.toJson())),
      };
}

class Consignment {
  int? consignmentId;
  int? qty;
  Product? product;
  int? checkedQty;

  Consignment({
    this.consignmentId,
    this.qty,
    this.product,
    this.checkedQty,
  });

  factory Consignment.fromJson(Map<String, dynamic> json) => Consignment(
        consignmentId: json["consignment_id"],
        qty: json["qty"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        checkedQty: json["checked_qty"],
      );

  Map<String, dynamic> toJson() => {
        "consignment_id": consignmentId,
        "qty": qty,
        "product": product?.toJson(),
        "checked_qty": checkedQty,
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

class DisBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  DisBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory DisBy.fromJson(Map<String, dynamic> json) => DisBy(
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

class DriverDetials {
  String? name;
  String? licenseNo;
  int? drvId;
  String? phone;

  DriverDetials({
    this.name,
    this.licenseNo,
    this.drvId,
    this.phone,
  });

  factory DriverDetials.fromJson(Map<String, dynamic> json) => DriverDetials(
        name: json["name"],
        licenseNo: json["license_no"],
        drvId: json["drv_id"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "license_no": licenseNo,
        "drv_id": drvId,
        "phone": phone,
      };
}

class Vehicle {
  String? name;
  int? tranId;
  String? vehNo;

  Vehicle({
    this.name,
    this.tranId,
    this.vehNo,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        name: json["name"],
        tranId: json["tran_id"],
        vehNo: json["veh_no"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tran_id": tranId,
        "veh_no": vehNo,
      };
}
