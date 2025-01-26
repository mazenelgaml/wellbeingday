// To parse this JSON data, do
//
//     final addImageModel = addImageModelFromJson(jsonString);

import 'dart:convert';

AddImageModel addImageModelFromJson(String str) => AddImageModel.fromJson(json.decode(str));

String addImageModelToJson(AddImageModel data) => json.encode(data.toJson());

class AddImageModel {
  String? message;
  UpdatedBeneficiary? updatedBeneficiary;

  AddImageModel({
    this.message,
    this.updatedBeneficiary,
  });

  factory AddImageModel.fromJson(Map<String, dynamic> json) => AddImageModel(
    message: json["message"],
    updatedBeneficiary: json["updatedBeneficiary"] == null ? null : UpdatedBeneficiary.fromJson(json["updatedBeneficiary"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "updatedBeneficiary": updatedBeneficiary?.toJson(),
  };
}

class UpdatedBeneficiary {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? profession;
  String? homeAddress;
  int? age;
  String? region;
  String? nationality;
  String? gender;
  String? role;
  DateTime? createdAt;
  int? v;
  String? imageUrl;

  UpdatedBeneficiary({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.profession,
    this.homeAddress,
    this.age,
    this.region,
    this.nationality,
    this.gender,
    this.role,
    this.createdAt,
    this.v,
    this.imageUrl,
  });

  factory UpdatedBeneficiary.fromJson(Map<String, dynamic> json) => UpdatedBeneficiary(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    profession: json["profession"],
    homeAddress: json["homeAddress"],
    age: json["age"],
    region: json["region"],
    nationality: json["nationality"],
    gender: json["gender"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "profession": profession,
    "homeAddress": homeAddress,
    "age": age,
    "region": region,
    "nationality": nationality,
    "gender": gender,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "imageUrl": imageUrl,
  };
}
