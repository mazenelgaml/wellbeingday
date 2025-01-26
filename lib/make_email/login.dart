import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/screens/homescreen.dart'; // Import HomeScreen
import 'package:doctor/make_email/reset_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/forget_password_cubit/forget_password_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserProfileCubit(),
                  child: const HomeScreen(),
                ),
              ),
            );
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "welcomeBack".tr(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/img.png',
                            height: 150,
                          ),
                          const Text(
                            'Wellbeing Day',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'THERAPY. RELAX. MAGAZINE',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildTextField(
                      context,
                      label: "email".tr(),
                      icon: Icons.email_outlined,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    buildTextField(
                      context,
                      label: "password".tr(),
                      icon: Icons.visibility_off_outlined,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (_) => ForgetPasswordCubit(),
                                child: ResetPassword(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "forgetPassword".tr(),
                          style: const TextStyle(color: Color(0xff19649E)),
                        ),
                      ),
                    ),
                    buildTextField(
                      context,
                      label: "role".tr(),
                      icon: Icons.person,
                      controller: roleController,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final role = roleController.text.trim();
                        context.read<LoginCubit>().login(email, password, role);
                      },
                      style: ElevatedButton.styleFrom(
                       backgroundColor: const Color(0xff19649E),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "signIn".tr(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        TextButton(
                          onPressed: () {
                            // Handle create account
                          },
                          child: Text(
                            "notHaveAccount".tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        Text(
                          "createAccount".tr(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff19649E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(BuildContext context,
      {required String label,
      required IconData icon,
      bool isPassword = false,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      // textAlign: TextAlign.right,
    );
  }
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password, String role) async {
    try {
      emit(LoginLoading());

      final url = 'https://scopey.onrender.com/api/auth/login';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        var userId = data['user']['id'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userId);

        emit(LoginSuccess(message: 'تم تسجيل الدخول بنجاح'));
      } else {
        emit(LoginError(
            error: 'البريد الإلكتروني أو كلمة المرور أو الدور غير صحيح.'));
      }
    } catch (e) {
      emit(LoginError(error: 'حدث خطأ أثناء تسجيل الدخول.'));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess({required this.message});
}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}
