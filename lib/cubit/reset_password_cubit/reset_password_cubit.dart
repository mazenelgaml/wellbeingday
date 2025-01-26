import 'package:dio/dio.dart';
import 'package:doctor/cubit/reset_password_cubit/reset_password_state.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/make_email/new_password.dart';
import 'package:doctor/screens/client_change_password.dart';
import 'package:doctor/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/forget_password_model.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPasswordByEmail(BuildContext context, String email,String password,String whereNext) async {
    emit(ResetPasswordLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.post(
        "/resetPassword/reset-password",
        data: {
          "email": email.trim(),
          "password":password.trim()
        },
      );
      if (response.statusCode == 200) {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(ResetPasswordSuccess(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );
        whereNext=="home"?
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (_) => UserProfileCubit(),
                child: HomeScreen()
            ),
          ),
        ):Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (_) => UserProfileCubit(),
                child: ClientChangePassword()
            ),
          ),
        );

      } else {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(ResetPasswordFailure(forgetPasswordModel.message??""));
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