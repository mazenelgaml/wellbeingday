// To parse this JSON data, do
//
//     final signUpDoctorModel = signUpDoctorModelFromJson(jsonString);

import 'dart:convert';

SignUpDoctorModel signUpDoctorModelFromJson(String str) => SignUpDoctorModel.fromJson(json.decode(str));

String signUpDoctorModelToJson(SignUpDoctorModel data) => json.encode(data.toJson());

class SignUpDoctorModel {
  String? message;
  Specialistes? specialist;

  SignUpDoctorModel({
    this.message,
    this.specialist,
  });

  factory SignUpDoctorModel.fromJson(Map<String, dynamic> json) => SignUpDoctorModel(
    message: json["message"],
    specialist: json["specialist"] == null ? null : Specialistes.fromJson(json["specialist"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "specialist": specialist?.toJson(),
  };
}

class Specialistes {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? nationality;
  String? work;
  String? workAddress;
  String? homeAddress;
  String? bio;
  int? sessionPrice;
  int? yearsExperience;
  int? sessionDuration;
  Files? files;
  String? id;
  int? v;

  Specialistes({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.nationality,
    this.work,
    this.workAddress,
    this.homeAddress,
    this.bio,
    this.sessionPrice,
    this.yearsExperience,
    this.sessionDuration,
    this.files,
    this.id,
    this.v,
  });

  factory Specialistes.fromJson(Map<String, dynamic> json) => Specialistes(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    nationality: json["nationality"],
    work: json["work"],
    workAddress: json["workAddress"],
    homeAddress: json["homeAddress"],
    bio: json["bio"],
    sessionPrice: json["sessionPrice"],
    yearsExperience: json["yearsExperience"],
    sessionDuration: json["sessionDuration"],
    files: json["files"] == null ? null : Files.fromJson(json["files"]),
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "nationality": nationality,
    "work": work,
    "workAddress": workAddress,
    "homeAddress": homeAddress,
    "bio": bio,
    "sessionPrice": sessionPrice,
    "yearsExperience": yearsExperience,
    "sessionDuration": sessionDuration,
    "files": files?.toJson(),
    "_id": id,
    "__v": v,
  };
}

class Files {
  String? idOrPassport;
  String? resume;
  List<String>? certificates;
  String? ministryLicense;
  String? associationMembership;

  Files({
    this.idOrPassport,
    this.resume,
    this.certificates,
    this.ministryLicense,
    this.associationMembership,
  });

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    idOrPassport: json["idOrPassport"],
    resume: json["resume"],
    certificates: json["certificates"] == null ? [] : List<String>.from(json["certificates"]!.map((x) => x)),
    ministryLicense: json["ministryLicense"],
    associationMembership: json["associationMembership"],
  );

  Map<String, dynamic> toJson() => {
    "idOrPassport": idOrPassport,
    "resume": resume,
    "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
    "ministryLicense": ministryLicense,
    "associationMembership": associationMembership,
  };
}
