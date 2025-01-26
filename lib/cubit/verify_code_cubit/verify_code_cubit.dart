
import 'package:dio/dio.dart';
import 'package:doctor/cubit/verify_code_cubit/verify_code_state.dart';
import 'package:doctor/make_email/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/end_points.dart';
import '../../models/forget_password_model.dart';
import '../reset_password_cubit/reset_password_cubit.dart';

class  VerifyCodeCubit extends Cubit< VerifyCodeState> {
  VerifyCodeCubit() : super( VerifyCodeInitial());

  Future<void> verifyCodeByEmail(BuildContext context, String email,int code) async {
    emit(VerifyCodeLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.post(
        "/resetPassword/verify-code",
        data: {
          "email": email.trim(),
          "code":code
        },
      );
      if (response.statusCode == 200) {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(VerifyCodeSuccess(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (_) => ResetPasswordCubit(),
                child: NewPasswordPage(email:email)
            ),
          ),
        );

      } else {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(VerifyCodeFailure(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }
  }}