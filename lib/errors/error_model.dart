// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  String? code;
  String? message;
  dynamic data;

  ResponseModel({
    this.code,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    code: json["code"],
    message: json["message"],
    data: json["data"],
  );


  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data,
  };
}
