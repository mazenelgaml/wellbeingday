import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {




  int _currentPage = 0;
  final int totalPages = 2;

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
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
        leading: BackButton(onPressed:(){Navigator.pop(context);}),
        backgroundColor: const Color(0xff19649E),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "changeLanguage".tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.21, // Adjust height proportionally
                decoration: const BoxDecoration(
                  color: Color(0xff19649E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
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
          const SizedBox(height: 35),
          Text(
            "${userProfileCubit.userData?.firstName}",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: screenWidth * 0.06,
              color: const Color(0xff19649E),
            ),
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(25, 40, 25, 5),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF19649E),
                    borderRadius: BorderRadius.circular(10), // Circular shape
                  ),
                  child: NavigationBar(

                    backgroundColor: Colors.transparent,
                    height: 50,
                    destinations: [
                      TextButton(
                        onPressed: () {
                          _onItemTapped(0);
                          EasyLocalization.of(context)!.setLocale(const Locale('ar'));

                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor:
                          _currentPage == 0 ? Colors.white : Colors.transparent,
                        ),
                        child: Text(
                          "arabic".tr(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: _currentPage == 0
                                ? const Color(0xFF19649E)
                                : Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _onItemTapped(1);
                          EasyLocalization.of(context)!.setLocale(const Locale('en'));

                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor:
                          _currentPage == 1 ? Colors.white : Colors.transparent,
                        ),
                        child: Text(
                          "english".tr(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: _currentPage == 1
                                  ? const Color(0xFF19649E)
                                  : Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 150,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(700, 50), backgroundColor: const Color(0xFF19649E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "update".tr(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
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
