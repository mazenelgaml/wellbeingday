import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/reset_password_cubit/reset_password_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';

class ClientChangePassword extends StatefulWidget {
  const ClientChangePassword({super.key});

  @override
  State<ClientChangePassword> createState() => _ClientChangePasswordState();
}

class _ClientChangePasswordState extends State<ClientChangePassword> {
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  late UserProfileCubit userProfileCubit;
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context); // Initialize the cubit
    _loadUserProfile();

  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";

    // Set the state once the user profile data is fetched
    userProfileCubit.getUserProfile(context, id);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // Return false to disable the back button
        return false;
      },
      child: BlocProvider(
          create: (_) => userProfileCubit,  // Use the same cubit instance
          child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return Scaffold(body: Center(child: CircularProgressIndicator(),));
              } else if (state is UserProfileFailure) {
                return Center(child: Text("Error loading profile: ${state.error}"));
              } else if (state is UserProfileSuccess) {
                // Once the profile is loaded, show the actual UI
                UserProfileModel userProfile = state.userProfile;
                return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
                  appBar: AppBar(
                    leading: BackButton(onPressed: (){Navigator.pop(context);},),
                    backgroundColor: const Color(0xff19649E),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    centerTitle: true,
                    title: Text(
                      "passwordManager".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.21, // Adjust height proportionally
                        decoration: BoxDecoration(
                          color: Color(0xff19649E),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        // child: Padding(
                        //   padding: const EdgeInsets.only(right: 16.0, top: 40),
                        //   child: Container(
                        //     width: screenWidth * 0.9,
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "settings".tr(),
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //             fontSize: screenWidth * 0.06,
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //         SizedBox(width: 120),
                        //         GestureDetector(
                        //             onTap: (){
                        //               Navigator.pop(context);
                        //             },
                        //             child: Icon(Icons.arrow_forward, color: Colors.white)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ),
                      Positioned(
                        bottom: -50,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  height: screenWidth * 0.3,
                                  width: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),

                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50), // زاوية الإطار
                                        child: userProfile.imageUrl==""||userProfile.imageUrl==null?Image.asset("assets/images/profile.jpg",fit: BoxFit.fill,):Image.network(
                                          userProfile.imageUrl ?? "", // رابط الصورة
                                          fit: BoxFit.fill, // ملء الصورة
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor:  Color(0xff19649E),
                                    child: Icon(Icons.edit,
                                        size: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Positioned(
                    left: screenWidth * 0.35,
                    top: -100,
                    child: Text(
                      "${userProfileCubit.userData?.firstName}",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: screenWidth * 0.06,
                        color: const Color(0xff19649E),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 420,
                child: Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key:formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "newPassword".tr(),
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff19649E),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Center(
                                    child: Container(
                                      width: screenWidth * 0.9,
                                      height: screenHeight * 0.06,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: passwordController,
                                        validator:  (String? value) {
                                          value = passwordController.text;
                                          if (value == null || value.length < 8) {
                                            return "passwordLength".tr();
                                          }
                                          return null;
                                        },
                                        // textDirection: TextDirection.rtl,
                                        // textAlign: TextAlign.right,
                                        obscureText: _isObscure1,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure1
                                                  ? Icons.visibility_off_rounded
                                                  : Icons.visibility_rounded,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure1 = !_isObscure1;
                                              });
                                            },
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "confirmPassword".tr(),
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff19649E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Center(
                                  child: Container(
                                    width: screenWidth * 0.9,
                                    height: screenHeight * 0.06,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      controller: confirmPasswordController,
                                      // textDirection: TextDirection.rtl,
                                      // textAlign: TextAlign.right,
                                      obscureText: _isObscure2,
                                      validator: (String? value) {
                                        value = passwordController.text;
                                        if (value != confirmPasswordController.text) {
                                          return "matchPassword".tr();
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(11),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure2
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure2 = !_isObscure2;
                                            });
                                          },
                                        ),
                                      ),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.09),
                      Center(
                        child: GestureDetector(
                          onTap: (){
      if (formKey.currentState!.validate()) {
      BlocProvider.of<ResetPasswordCubit>(context)
          .resetPasswordByEmail(context, userProfileCubit.userData?.email??"",
      passwordController.text,"changePassword");
      passwordController.clear();
      confirmPasswordController.clear();
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      
      }
                          },
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              color: Color(0xff19649E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "update".tr(),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
        }
        return Container(); // Default return in case no state matches
      },
      )),
    );
}

}
