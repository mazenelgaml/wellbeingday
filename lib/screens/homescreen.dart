import 'dart:async';
import 'package:doctor/screens/home_second_screen.dart';
import 'package:doctor/screens/problem_solving_screen.dart';
import 'package:doctor/screens/psychological_disorders_screen.dart';
import 'package:doctor/screens/psychological_prevention_screen.dart';
import 'package:doctor/screens/rehabilitation_screen.dart';
import 'package:doctor/screens/therapeutic_programs_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_state.dart';
import '../models/user_profile_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'childrens_disorder_screen.dart';
import 'free_consultation_screen.dart';
import 'home_third_screen.dart';
import 'instant_session_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "mentalHealth".tr(),
    "physicalHealth".tr(),
    "skillDevelopment".tr(),
    "magazine".tr()
  ];
  int selectedIndex = 0;

  final List<String> images = [
    'assets/images/family.png',
    'assets/images/familyy.png',
    'assets/images/familyyy.png',
  ];
  PageController _pageController = PageController();
  late Timer _timer;
  late UserProfileCubit userProfileCubit;

  @override
  void initState() {
    super.initState();
    userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    _loadUserProfile();
    _startAutoPageSwitch();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
    userProfileCubit.getUserProfile(context, id);
  }

  void _startAutoPageSwitch() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page?.toInt() == images.length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }



  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
                appBar: CustomAppBar(
                  userProfile: userProfile,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                bottomNavigationBar:const CustomBottomNavBar(currentIndex: 1,),
                body: Column(
                  children: [
                    // Header

                    SizedBox(height: screenHeight * 0.01),

                    // Category List
                    SizedBox(
                      height: 32,
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: screenWidth * 0.02);
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (index == categories.length - 1) {
                                  // Do nothing if it's the last item
                                  selectedIndex = selectedIndex; // Keep the current index
                                } else {
                                  selectedIndex = index; // Update the selected index
                                }
                              });

                              // Navigate only if it's not the last item
                              if (index != categories.length - 1) {
                                Widget page;

                                if (selectedIndex == 0) {
                                  page = const HomeScreen();
                                } else if (selectedIndex == 1) {
                                  page = const HomeSecondScreen();
                                } else if (selectedIndex == 2) {
                                  page = const HomeThirdScreen();
                                } else {
                                  page = const HomeScreen();
                                }

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        BlocProvider(
                                          create: (_) => UserProfileCubit(),
                                          child: page,
                                        ),
                                    transitionDuration: const Duration(milliseconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: screenWidth * 0.35,
                              height: 32,
                              decoration: BoxDecoration(
                                color: index == categories.length - 1
                                    ? const Color(0xffAFDCFF) // Always blue for the last item
                                    : (selectedIndex == index ? const Color(0xff19649E) :
                                const Color(0xffD5D5D5)),

                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Image Slider
                    SizedBox(
                      height: screenHeight * 0.18,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            images[index],
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  child: const FreeConsultationScreen(),
                                ),

                              ),

                            );
                          },
                          child: Container(
                            width: screenWidth * 0.46,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff1F78BC),
                            ),
                            child: Center(
                              child: Text(
                                "consultation".tr(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                    BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                    BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                  ],
                                  child: const InstantSessionScreen(),
                                ),

                              ),

                            );
                          },
                          child: Container(
                            width: screenWidth * 0.45,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff1F78BC),
                            ),
                            child: Center(
                              child: Text(
                                "instantSession".tr(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var label in [
                              "therapeuticPrograms",
                              "groupTherapy",
                              "psychologicalDisorders"
                            ])
                              GestureDetector(
                                onTap: (){
                                  if(label=="psychologicalDisorders"){  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                          BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                          BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                        ],
                                        child: const PsychologicalDisordersScreen(),
                                      ),

                                    ),

                                  );}
                                  else if(label=="therapeuticPrograms"){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                            BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                            BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                          ],
                                          child: const TherapeuticProgramsScreen(),
                                        ),

                                      ),

                                    );
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff69B7F3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      label.tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var label in [
                              "guidanceAndInstructions",
                              "solveProblems",
                              "childrenDisorder"
                            ])
                              GestureDetector(
                                onTap: (){
                                  if(label== "solveProblems"){  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                          BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                          BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                        ],
                                        child: const ProblemSolvingScreen(),
                                      ),

                                    ),

                                  );}
                                  else if(label=="childrenDisorder"){  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                          BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                          BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                        ],
                                        child: const ChildrensDisorderScreen(),
                                      ),

                                    ),

                                  );}

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff69B7F3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      label.tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var label in [
                              "PsychologicalPreventionAndFollowUp",
                              "rehabilitation"
                            ])
                              GestureDetector(
                                onTap: (){
                                  if(label=="rehabilitation"){  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                          BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                          BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                        ],
                                        child: const RehabilitationScreen(),
                                      ),

                                    ),

                                  );}
                                  else if(label=="PsychologicalPreventionAndFollowUp"){  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
                                          BlocProvider<AddImageToProfileCubit>(create: (_) => AddImageToProfileCubit()),
                                          BlocProvider<UpdateUserCubit>(create: (_) => UpdateUserCubit()),
                                        ],
                                        child: const PsychologicalPreventionScreen(),
                                      ),

                                    ),

                                  );}

                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff69B7F3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      label.tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    )

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

//                       _buildButton(screenWidth, "consultation".tr()),
//                       _buildButton(screenWidth, "instantSession".tr()),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.03),
//
//                   // Treatment Programs
//                   _buildTreatmentPrograms(screenHeight),
//                 ],
//               ),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
//
//   Widget _buildButton(double screenWidth, String text) {
//     return Container(
//       width: screenWidth * 0.4,
//       height: 40,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Color(0xff1F78BC),
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTreatmentPrograms(double screenHeight) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildProgramButton("therapeuticPrograms".tr(),),
//             _buildProgramButton("groupTherapy".tr()),
//             _buildProgramButton("psychologicalDisorders".tr()),
//           ],
//         ),
//         SizedBox(height: screenHeight * 0.025),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildProgramButton("guidanceAndInstructions".tr()),
//             _buildProgramButton("solveProblems".tr()),
//             _buildProgramButton("childrenDisorder".tr()),
//           ],
//         ),
//         SizedBox(height: screenHeight * 0.025),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildProgramButton("PsychologicalPreventionAndFollowUp".tr()),
//             _buildProgramButton("rehabilitation".tr()),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProgramButton(String text) {
//     return Container(
//       width: 100,
//       height: 68,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Color(0xff69B7F3),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Center(
//         child: Text(
//           text,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }