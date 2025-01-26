import 'package:dio/dio.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/user_profile_model.dart';
import '../reset_password_cubit/reset_password_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  UserProfileModel? userData;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final nationalityController = TextEditingController();
  final addressController = TextEditingController();
  final regionController = TextEditingController();

  Future<void> getUserProfile(BuildContext context, String id) async {
    emit(UserProfileLoading());
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: EndPoint.baseUrl,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final response = await dio.get("/beneficiaries/beneficiary/$id");

      if (response.statusCode == 200) {
        final userProfileModel = UserProfileModel.fromJson(response.data);
        userData = userProfileModel;

        // Update controllers with data
        firstNameController.text = userData?.firstName ?? "";
        lastNameController.text = userData?.lastName ?? "";
        emailController.text = userData?.email ?? "";
        phoneController.text = userData?.phone ?? "";
        genderController.text = userData?.gender ?? "";
        nationalityController.text = userData?.nationality ?? "";
        addressController.text = userData?.homeAddress ?? "";
        regionController.text = userData?.region ?? "";

        emit(UserProfileSuccess("Profile loaded successfully", userProfileModel));
      } else {
        emit(UserProfileFailure("Error Fetching Data: ${response.data['message']}"));
      }
    } catch (e) {
      emit(UserProfileFailure("Error occurred while connecting to the API: $e"));
    }
  }

}
