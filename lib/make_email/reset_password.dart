
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/forget_password_cubit/forget_password_cubit.dart';
import '../cubit/forget_password_cubit/forget_password_state.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  int _currentPage = 0;
  final int totalPages = 2;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 25, 5),
          child: ListView(
            children: [
              Image.asset("assets/images/lock.png"),
              Text(
                "resetPassword".tr(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF19649E)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),



              // Page content based on _currentPage

                // Email page
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "email".tr(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 20, color: Color(0xff19649E)),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: "email".tr(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "emailValidator".tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<ForgetPasswordCubit>(context)
                              .resetPasswordByEmail(context,emailController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(700, 50), backgroundColor: const Color(0xff19649E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "send".tr(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),


            ],
          ),
        ),
      ),
    );
  }
}
