// To parse this JSON data, do
//
//     final updateUserProfileModel = updateUserProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateUserProfileModel updateUserProfileModelFromJson(String str) => UpdateUserProfileModel.fromJson(json.decode(str));

String updateUserProfileModelToJson(UpdateUserProfileModel data) => json.encode(data.toJson());

class UpdateUserProfileModel {
  UpdatedBeneficiary? updatedBeneficiary;

  UpdateUserProfileModel({
    this.updatedBeneficiary,
  });

  factory UpdateUserProfileModel.fromJson(Map<String, dynamic> json) => UpdateUserProfileModel(
    updatedBeneficiary: json["updatedBeneficiary"] == null ? null : UpdatedBeneficiary.fromJson(json["updatedBeneficiary"]),
  );

  Map<String, dynamic> toJson() => {
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
  };
}
