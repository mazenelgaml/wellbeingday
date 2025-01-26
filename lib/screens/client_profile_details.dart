import 'package:doctor/cubit/update_user_cubit/update_user_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';

class ClientProfileDetails extends StatefulWidget {
  const ClientProfileDetails({super.key});

  @override
  State<ClientProfileDetails> createState() => _ClientProfileDetailsState();
}

class _ClientProfileDetailsState extends State<ClientProfileDetails> {
  late UserProfileCubit userProfileCubit;
  late AddImageToProfileCubit addImageToProfileCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(context); // Initialize the cubit
    _loadUserProfile();
    // Call the asynchronous method here
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
          create: (_) => userProfileCubit, // Use the same cubit instance
          child: BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              } else if (state is UserProfileFailure) {
                return Center(
                    child: Text("Error loading profile: ${state.error}"));
              } else if (state is UserProfileSuccess) {
                // Once the profile is loaded, show the actual UI
                UserProfileModel userProfile = state.userProfile;
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    leading: BackButton(onPressed: ()async{
                     await BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
                    Navigator.pop(context);
                     },),
                    backgroundColor: const Color(0xff19649E),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    centerTitle: true,
                    title: Text(
                      "yourProfile".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: screenWidth,
                                  height: screenHeight *
                                      0.22, // Adjust height proportionally
                                  decoration: BoxDecoration(
                                    color: Color(0xff19649E),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  // child: Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       right: 16.0, top: 40),
                                  //   child: Container(
                                  //     width: screenWidth * 0.9,
                                  //     child: Row(
                                  //       crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //       mainAxisAlignment: MainAxisAlignment.end,
                                  //       children: [
                                  //         Text(
                                  //           "ملفك الشخصي",
                                  //           textAlign: TextAlign.center,
                                  //           style: TextStyle(
                                  //             fontSize: screenWidth * 0.06,
                                  //             // Adjust font size proportionally
                                  //             color: Colors.white,
                                  //             fontWeight: FontWeight.bold,
                                  //           ),
                                  //         ),
                                  //         SizedBox(width: 90),
                                  //         GestureDetector(
                                  //             onTap: () {
                                  //               Navigator.pop(context);
                                  //             },
                                  //             child: Icon(Icons.arrow_forward,
                                  //                 color: Colors.white)),
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
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                addImageToProfileCubit.pickImage(context,userProfile.id??"");
                                                BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
                                              });
                                            },
                                            child: Container(
                                              height: screenWidth * 0.3,
                                              // Adjust size proportionally
                                              width: screenWidth * 0.3,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(40),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(30),

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
                                          ),
                                          IconButton(
                                            onPressed: (){
                                              setState(() {
                                                addImageToProfileCubit.pickImage(context,userProfile.id??"");
                                                BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
                                              });
                                            },
                                            icon: Positioned(
                                              bottom: 10,
                                              left: 10,
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Color(0xff19649E),
                                                child: Icon(Icons.edit, size: 16, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "firstName".tr(),
                                    textAlign: TextAlign.center,
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
                                        controller:
                                            userProfileCubit.firstNameController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "lastName".tr(),
                                    textAlign: TextAlign.center,
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
                                        controller:
                                            userProfileCubit.lastNameController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "email".tr(),
                                    textAlign: TextAlign.center,
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
                                        controller:
                                            userProfileCubit.emailController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.email, size: 30),
                                              color: Colors.grey),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "phoneNumber".tr(),
                                    textAlign: TextAlign.center,
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
                                        controller:
                                            userProfileCubit.phoneController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.phone_android,
                                                  size: 30),
                                              color: Colors.grey),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "gender".tr(),
                                    textAlign: TextAlign.center,
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
                                        controller:
                                            userProfileCubit.genderController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "nationality".tr(),
                                    textAlign: TextAlign.center,
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
                                        controller: userProfileCubit
                                            .nationalityController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "homeAddress".tr(),
                                    textAlign: TextAlign.center,
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
                                        controller:
                                            userProfileCubit.addressController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "region".tr(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff19649E),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Center(
                                    child: Container(
                                      width: screenHeight * 0.9,
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
                                        controller:
                                            userProfileCubit.regionController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(color: Colors.black),
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: screenHeight * 0.03),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    final prefs =
                                    await SharedPreferences.getInstance();
                                    String id = prefs.getString('userId') ?? "";
                                    BlocProvider.of<UpdateUserCubit>(context)
                                        .updateUser(
                                        context,
                                        userProfileCubit
                                            .firstNameController.text
                                            .trim(),
                                        userProfileCubit
                                            .lastNameController.text
                                            .trim(),
                                        userProfileCubit.emailController.text
                                            .trim(),
                                        userProfileCubit.phoneController.text
                                            .trim(),
                                        userProfileCubit
                                            .addressController.text
                                            .trim(),
                                        userProfileCubit.regionController.text
                                            .trim(),
                                        userProfileCubit
                                            .nationalityController.text
                                            .trim(),
                                        userProfileCubit.genderController.text
                                            .trim(),
                                        id);
                                    setState(() {
                                      BlocProvider.of<UserProfileCubit>(context).getUserProfile(context, userProfile.id??"");
                                    });
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
