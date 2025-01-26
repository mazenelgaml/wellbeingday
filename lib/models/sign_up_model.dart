

import '../api/end_points.dart';

class SignUpModel {
  final String message;
  final String error;



  SignUpModel({required this.message, required this.error});
  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpModel(
        error: jsonData[ApiKey.error],
        message: jsonData[ApiKey.message]
    );
  }
}