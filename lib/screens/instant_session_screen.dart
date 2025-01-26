import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';

class InstantSessionScreen extends StatefulWidget {
  const InstantSessionScreen({super.key});

  @override
  State<InstantSessionScreen> createState() => _InstantSessionScreenState();
}

class _InstantSessionScreenState extends State<InstantSessionScreen> {
  late UserProfileCubit userProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
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
    create: (_) => userProfileCubit,
    child: BlocBuilder<UserProfileCubit, UserProfileState>(
    builder: (context, state) {
    if (state is UserProfileLoading) {
    return const Scaffold(
    body: Center(child: CircularProgressIndicator()),
    );
    } else if (state is UserProfileFailure) {
    return Center(child: Text("Error loading profile: ${state.error}"));
    } else if (state is UserProfileSuccess) {
    UserProfileModel userProfile = state.userProfile;
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
      appBar: CustomAppBar(
        userProfile: userProfile,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0,top: 15),

                    child: Center(
                      child: Container(
                        width: 161,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F78BC),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "جلسه فوريه",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "عبر عن حالتك بشكل مختصر",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff19649E)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width:screenWidth* 0.9,
                    height: 180,
                    child: TextFormField(

                      decoration: InputDecoration(
                        hintText: "ما هو شعورك؟ أكتب وصفاً قصيراً لحالتك لعرضها على المختص",
                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                        filled: true,
                        fillColor: Color(0xFFD5D5D5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      ),
                      maxLines: 10,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: screenWidth * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "شروط الجلسه",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1F78BC)),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Column(
                    children: [
                      Row(

                        children: [
                          Icon(Icons.circle, size: 10, color: Colors.black),
                          SizedBox(width: 5),
                          Text("تطلب الجلسه عند الضروره أو وجود وضع صعب"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(

                        children: [
                          Icon(Icons.circle, size: 10, color: Colors.black),
                          SizedBox(width: 5),
                          Text("لا تطلب الجلسه عند حالات الإنتحار أو ايذاء الذات أو الآخرين"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(

                        children: [
                          Icon(Icons.circle, size: 10, color: Colors.black),
                          SizedBox(width: 5),
                          Text("يتم تحويلك إلي الأخصائي المتوفر لاجراء الجلسه"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: Container(
              width: screenWidth* 0.9,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xff19649E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'إستمرار',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
    return Container(); // Default return in case no state matches
    },
    )),
    );
  }
}
