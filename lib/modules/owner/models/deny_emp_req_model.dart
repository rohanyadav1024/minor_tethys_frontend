// To parse this JSON data, do
//
//     final deleteReqResponse = denyEmpReqModelFromJson(jsonString);

// import 'dart:convert';

import 'dart:convert';

DenyEmpReqModel denyEmpReqModelFromJson(String str) => DenyEmpReqModel.fromJson(json.decode(str));

String denyEmpReqModelToJson(DenyEmpReqModel data) => json.encode(data.toJson());

class DenyEmpReqModel {
  String? status;
  String? message;

  DenyEmpReqModel({
    this.status,
    this.message,
  });

  factory DenyEmpReqModel.fromJson(Map<String, dynamic> json) => DenyEmpReqModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
