import 'package:doctor/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'package:doctor/screens/change_language.dart';
import 'package:doctor/screens/client_change_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/reset_password_cubit/reset_password_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  void showDeleteAccountBottomSheet(BuildContext context, VoidCallback onConfirm) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), // Rounded top corners
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust height to fit content
            children: [
              Text(
                "confirmDeleteAccount".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Divider(thickness: 1, color: Color(0xff19649E)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xff19649E),width: 2),
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(20),

                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: Text(
                      "dismiss".tr(),
                      style: TextStyle(color: Color(0xff19649E),fontSize: 20,fontWeight: FontWeight.w600),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff19649E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      onConfirm(); // Handle confirmation
                    },
                    child: Text(
                      "confirm".tr(),
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  late UserProfileCubit userProfileCubit;
  late AddImageToProfileCubit addImageToProfileCubit;
  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    addImageToProfileCubit = BlocProvider.of<AddImageToProfileCubit>(context);// Initialize the cubit
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
    List<String> actions = ["changeLanguage".tr(), "passwordManager".tr()];

    // MediaQuery for responsive sizing
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
        backgroundColor: Colors.white,
                  appBar: AppBar(
                    leading: BackButton(onPressed: (){Navigator.pop(context);},),
                    backgroundColor: const Color(0xff19649E),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    centerTitle: true,
                    title: Text(
                      "settings".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: screenHeight * 0.22,  // Adjust height proportionally
                      decoration: BoxDecoration(
                        color: Color(0xff19649E),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      // child: Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 16.0, top: 30),
                      //       child: GestureDetector(
                      //           onTap: (){
                      //             Navigator.pop(context);
                      //           },
                      //           child: Icon(Icons.arrow_forward, color: Colors.white)),
                      //     ),
                      //   ],
                      // ), // child: Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 16.0, top: 30),
                      //       child: GestureDetector(
                      //           onTap: (){
                      //             Navigator.pop(context);
                      //           },
                      //           child: Icon(Icons.arrow_forward, color: Colors.white)),
                      //     ),
                      //   ],
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
                Positioned(
                  left: screenWidth * 0.35, // Adjust for better centering
                  top: -100,
                  child: Text(
                    "${userProfileCubit.userData?.firstName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: screenWidth * 0.06,
                      // Adjust size based on screen width
                      color: Color(0xff19649E),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                            BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                            BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                          ],
                          child: const ChangeLanguage(),
                        ),
                      ),
                    );

                  },
                  child: Container(
                    margin:
                    EdgeInsets.only(bottom: 15, top: 25, left: 22, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "changeLanguage".tr(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.05,
                                  // Adjust text size
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xff19649E),
                              size: screenWidth *
                                  0.08, // Adjust icon size proportionally
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 12),
                          width: screenWidth * 0.85,
                          height: 2,
                          color: Color(0xff19649E),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                            BlocProvider<ResetPasswordCubit>(create: (_) => ResetPasswordCubit()),
                          ],
                          child:ClientChangePassword(),
                        ),
                      ),
                    );

                  },
                  child: Container(
                    margin:
                    EdgeInsets.only(bottom: 15, top: 10, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text(
                                "changePassword".tr(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.05,
                                  // Adjust text size
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xff19649E),
                              size: screenWidth *
                                  0.08, // Adjust icon size proportionally
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 12),
                          width: screenWidth * 0.85,
                          height: 2,
                          color: Color(0xff19649E),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showDeleteAccountBottomSheet( context, ()async{
                      final prefs = await SharedPreferences.getInstance();
                      String id = prefs.getString('userId') ?? "";
                      BlocProvider.of<DeleteAccountCubit>(context).deleteAccount(context, id);
                    });
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: 15, top: 10, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text(
                                "deleteAccount".tr(),
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: screenWidth * 0.05,
                                  // Adjust text size
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.redAccent,
                              size: screenWidth *
                                  0.08, // Adjust icon size proportionally
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 12),
                          width: screenWidth * 0.85,
                          height: 2,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
        }
        return Container();
      },
      )),
    );
}

}
