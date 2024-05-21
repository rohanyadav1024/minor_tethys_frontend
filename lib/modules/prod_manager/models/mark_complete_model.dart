// To parse this JSON data, do
//
//     final markCompleteModel = markCompleteModelFromJson(jsonString);

import 'dart:convert';

MarkCompleteModel markCompleteModelFromJson(String str) => MarkCompleteModel.fromJson(json.decode(str));

String markCompleteModelToJson(MarkCompleteModel data) => json.encode(data.toJson());

class MarkCompleteModel {
  String? status;
  String? msg;

  MarkCompleteModel({
    this.status,
    this.msg,
  });

  factory MarkCompleteModel.fromJson(Map<String, dynamic> json) => MarkCompleteModel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
