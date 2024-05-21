// To parse this JSON data, do
//
//     final getConsignmentListModel = getConsignmentListModelFromJson(jsonString);

import 'dart:convert';

GetConsignmentListModel getConsignmentListModelFromJson(String str) =>
    GetConsignmentListModel.fromJson(json.decode(str));

String getConsignmentListModelToJson(GetConsignmentListModel data) => json.encode(data.toJson());

class GetConsignmentListModel {
  String? status;
  String? msg;
  List<ConsignmentDatum>? data;

  GetConsignmentListModel({
    this.status,
    this.msg,
    this.data,
  });

  factory GetConsignmentListModel.fromJson(Map<String, dynamic> json) => GetConsignmentListModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<ConsignmentDatum>.from(json["data"]!.map((x) => ConsignmentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ConsignmentDatum {
  int? disId;
  String? buyer;
  String? invoice;
  int? invValue;
  dynamic recvTime;
  bool? checkout;
  DisBy? disBy;
  DriverDetails? driverDetails;
  Vehicle? vehicle;
  List<Consignment>? consignments;

  ConsignmentDatum({
    this.disId,
    this.buyer,
    this.invoice,
    this.invValue,
    this.recvTime,
    this.checkout,
    this.disBy,
    this.driverDetails,
    this.vehicle,
    this.consignments,
  });

  factory ConsignmentDatum.fromJson(Map<String, dynamic> json) => ConsignmentDatum(
        disId: json["dis_id"],
        buyer: json["buyer"],
        invoice: json["invoice"],
        invValue: json["inv_value"],
        recvTime: json["recv_time"],
        checkout: json["checkout"],
        disBy: json["dis_by"] == null ? null : DisBy.fromJson(json["dis_by"]),
        driverDetails: json["driver_details"] == null ? null : DriverDetails.fromJson(json["driver_details"]),
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
        "driver_details": driverDetails?.toJson(),
        "vehicle": vehicle?.toJson(),
        "consignments": consignments == null ? [] : List<dynamic>.from(consignments!.map((x) => x.toJson())),
      };
}

class Consignment {
  int? consignmentId;
  Product? product;
  int? qty;
  int? checkedQty;

  Consignment({
    this.consignmentId,
    this.product,
    this.qty,
    this.checkedQty,
  });

  factory Consignment.fromJson(Map<String, dynamic> json) => Consignment(
        consignmentId: json["consignment_id"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        qty: json["qty"],
        checkedQty: json["checked_qty"],
      );

  Map<String, dynamic> toJson() => {
        "consignment_id": consignmentId,
        "product": product?.toJson(),
        "qty": qty,
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

class DriverDetails {
  String? name;
  String? licenseNo;
  String? phone;
  int? drvId;

  DriverDetails({
    this.name,
    this.licenseNo,
    this.phone,
    this.drvId,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
        name: json["name"],
        licenseNo: json["license_no"],
        phone: json["phone"],
        drvId: json["drv_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "license_no": licenseNo,
        "phone": phone,
        "drv_id": drvId,
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
