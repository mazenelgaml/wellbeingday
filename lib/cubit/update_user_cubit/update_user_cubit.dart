import 'package:dio/dio.dart';
import 'package:doctor/cubit/reset_password_cubit/reset_password_state.dart';
import 'package:doctor/cubit/update_user_cubit/update_user_state.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/make_email/new_password.dart';
import 'package:doctor/models/update_user_profile_model.dart';
import 'package:doctor/screens/client_change_password.dart';
import 'package:doctor/screens/client_profile_details.dart';
import 'package:doctor/screens/client_profile_screen.dart';
import 'package:doctor/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/forget_password_model.dart';
import '../add_image_to_profile/add_image_to_profile_cubit.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());

  Future<void> updateUser(BuildContext context, String firstName,String lastName,
      String email,String phone,
  String homeAddress,String region,String nationality
      ,String gender,String userId) async {
    emit(UpdateUserLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.patch(
        "/beneficiaries/update/$userId",
        data:{
          "firstName":firstName,
          "lastName":lastName,
          "email":email,
          "phone":phone,
          "homeAddress":homeAddress,
          "region":region,
          "nationality":nationality,
          "gender":gender

        },
      );
      if (response.statusCode == 200) {
        final forgetPasswordModel = UpdateUserProfileModel.fromJson(response.data);
        emit(UpdateUserSuccess("profile updated successfully"));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("profile updated successfully")),
        );

       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                  BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                  BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                ],
                child: ClientProfileScreen()
            ),
          ),
             (route) => false,
        );

      } else {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(UpdateUserFailure(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }
  }

}