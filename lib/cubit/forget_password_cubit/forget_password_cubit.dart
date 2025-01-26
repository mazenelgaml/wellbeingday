import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/end_points.dart';
import '../../make_email/verify_email.dart';
import '../../models/forget_password_model.dart';
import '../verify_code_cubit/verify_code_cubit.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> resetPasswordByEmail(BuildContext context, String email) async {
    emit(ForgetPasswordLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.post(
        "/resetPassword/forget-password",
        data: {"email": email.trim()},
      );
      if (response.statusCode == 200) {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(ForgetPasswordSuccess(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => VerifyCodeCubit(),
              child: VerifyScreenEmail(email:email)
            ),
          ),
        );

      } else {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(ForgetPasswordFailure(forgetPasswordModel.message??""));
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
