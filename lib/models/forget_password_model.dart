// To parse this JSON data, do
//
//     final forgetPasswordModel = forgetPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordModel forgetPasswordModelFromJson(String str) => ForgetPasswordModel.fromJson(json.decode(str));

String forgetPasswordModelToJson(ForgetPasswordModel data) => json.encode(data.toJson());

class ForgetPasswordModel {
  String? message;

  ForgetPasswordModel({
    this.message,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
