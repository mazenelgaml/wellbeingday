import 'package:doctor/widgets/custom_app_bar.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
import '../widgets/doctor_card.dart';

class ChildrensDisorderScreen extends StatefulWidget {
  const ChildrensDisorderScreen({super.key});

  @override
  State<ChildrensDisorderScreen> createState() => _ChildrensDisorderScreenState();
}

class _ChildrensDisorderScreenState extends State<ChildrensDisorderScreen> {
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
                appBar: AppBar(

                  elevation: 0,
                  leading: IconButton(onPressed:(){Navigator.pop(context);},icon:Icon(Icons.keyboard_backspace_rounded,size: 30,),color: Color(0xff19649E),),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 161,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF1F78BC),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "اضطراب الاطفال",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDisorderButton("صعوبات  التعلم"),
                          _buildDisorderButton("صعوبات النطق"),
                          _buildDisorderButton("فرط الحركة"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDisorderButton("التوحد"),
                          _buildDisorderButton("الكذب"),
                          _buildDisorderButton("السرقه"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDisorderButton("العناد"),
                          _buildDisorderButton("الادمان"),
                          _buildDisorderButton("التعلثم"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDisorderButton("التعلق"),

                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 25),
                          width: 161,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF1F78BC),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "المختصين",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      // List of doctors
                      ListView.separated(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        itemBuilder: (context, index) {
                          return DoctorCard();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: screenHeight * 0.05);
                        },
                        itemCount: 2,
                        shrinkWrap: true, // Makes ListView behave like a normal widget inside a Column
                        physics: NeverScrollableScrollPhysics(), // Prevents the ListView from having its own scroll
                      )
                    ],
                  ),
                ),
              );
            }
            return Container(); // Default return in case no state matches
          },
        ),
      ),
    );
  }

  // Helper method to build disorder buttons
  Widget _buildDisorderButton(String title) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff69B7F3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
