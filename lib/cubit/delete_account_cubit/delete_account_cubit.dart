
import 'package:dio/dio.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/end_points.dart';
import '../../models/forget_password_model.dart';
import 'delete_account_state.dart';

class  DeleteAccountCubit extends Cubit< DeleteAccountState> {
  DeleteAccountCubit() : super( DeleteAccountInitial());

  Future<void> deleteAccount(BuildContext context, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    emit(DeleteAccountLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl,
        validateStatus: (status) {
          return status != null && status < 500;
        },));
      final response = await dio.delete(
        "/beneficiaries/delete/$userId",
      );
      if (response.statusCode == 200) {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(DeleteAccountSuccess(forgetPasswordModel.message??""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(forgetPasswordModel.message??"")),
        );

        prefs.remove('userId');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ),
        );;

      } else {
        final forgetPasswordModel = ForgetPasswordModel.fromJson(response.data);
        emit(DeleteAccountFailure(forgetPasswordModel.message??""));
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