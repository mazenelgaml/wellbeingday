// import 'package:doctor/screens/homescreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// import '../cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';
// import '../cubit/doctor_sign_up_cubit/doctor_sign_up_state.dart';
// import '../make_email/login.dart';
// import '../models/doctor.dart';
// import '../widgets/custom_snake_bar.dart';

// class SignUpAsDoctorThirdScreen extends StatefulWidget {
//   final Doctor doctor;

//   const SignUpAsDoctorThirdScreen({Key? key, required this.doctor})
//       : super(key: key);

//   @override
//   State<SignUpAsDoctorThirdScreen> createState() =>
//       _SignUpAsDoctorThirdScreenState();
// }

// class _SignUpAsDoctorThirdScreenState extends State<SignUpAsDoctorThirdScreen> {
//   final Map<String, Map<String, bool>> _categories = {
//     'صحة نفسية': {
//       'اضطرابات نفسية': false,
//       'برامج علاجية': false,
//       'علاج جماعي': false,
//       'اضطراب الاطفال': false,
//       'حل مشاكل': false,
//       'ارشاد وتوجيه': false,
//       'وقاية ومتابعة نفسية': false,
//       'إعادة تأهيل ودعم': false,
//     },
//     'تطوير مهارات': {
//       'الاسترخاء': false,
//       'تحمل الضغوط': false,
//       'ضبط المشاعر': false,
//       'حل استراتيجيات جدلية': false,
//       'تحقيق التوازن': false,
//       'تحسين الثقة': false,
//       'تحقيق الأهداف': false,
//       'تحقيق النجاح': false,
//       'اضطراب الصدمة': false,
//     },
//     'اضطراب نفسي': {
//       'القلق': false,
//       'الاكتئاب': false,
//       'الرهاب': false,
//       'الوسواس': false,
//       'اضطراب جنسي': false,
//       'اضطراب الاكل': false,
//       'اضطراب شخصي': false,
//       'الإدمان': false,
//       'اضطراب الصدمة': false,
//     },
//     'صحة جسدية': {
//       'نظام غذائي': false,
//       'نظام رياضي': false,
//       'عناية صحية': false,
//       'فحوص دورية': false,
//     }
//   };

//   final List<String> rightColumnCategories = [
//     'اضطراب نفسي',
//     'صحة جسدية',
//   ];
//   final List<String> leftColumnCategories = [
//     'صحة نفسية',
//     'تطوير مهارات',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocBuilder<SignUpSpecialistCubit, SignUpSpecialistState>(
//           builder: (context, state) {
//             if (state is SignUpSpecialistLoading) {
//               return Center(
//                   child: Image(image: AssetImage('assets/images/loading.gif')));
//             } else if (state is SignUpSpecialistFailure) {
//               return CustomSnackBar(
//                 message: state.errMessage,
//                 backgroundColor: Colors.red,
//                 icon: Icons.error,
//               );
//             } else if (state is SignUpSpecialistSuccess) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 CustomSnackBar(
//                   message: "اهلا بك , تمت عملية التسجيل , الرجاء تسجيل الدخول",
//                   backgroundColor: Colors.green,
//                   icon: Icons.done,
//                 );

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               });
//               return const Center(
//                   child: Image(image: AssetImage('assets/images/loading.gif')));
//             }

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text(
//                     "اختار تخصصك",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Color(0xff19649E),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Right Column
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: rightColumnCategories
//                                     .map((category) => buildCategory(
//                                         category, _categories[category]!))
//                                     .toList(),
//                               ),
//                             ),
//                             // Left Column
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: leftColumnCategories
//                                     .map((category) => buildCategory(
//                                         category, _categories[category]!))
//                                     .toList(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   InkWell(
//                     onTap: () {
//                       String selectedSpecialities = getSelectedSpecialities();
//                       widget.doctor.specialties = selectedSpecialities;
//                       context
//                           .read<SignUpSpecialistCubit>()
//                           .signUp(widget.doctor);
//                     },
//                     child: Container(
//                       width: Get.width * 0.9,
//                       height: Get.height * 0.07,
//                       decoration: BoxDecoration(
//                         color: const Color(0xff19649E),
//                         borderRadius: BorderRadius.circular(11),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'انشاء حساب',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: Get.height * 0.02),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'لديك حساب بالفعل ؟ ',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginPage()),
//                           );
//                         },
//                         child: const Text(
//                           'تسجيل الدخول ',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xff19649E),
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   String getSelectedSpecialities() {
//     List<String> selectedCategories = [];

//     _categories.forEach((category, subcategories) {
//       subcategories.forEach((subcategory, isSelected) {
//         if (isSelected) {
//           selectedCategories.add(subcategory);
//         }
//       });
//     });

//     return selectedCategories.join('; ');
//   }

//   Widget buildCategory(String category, Map<String, bool> subcategories) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Text(
//             category,
//             style: const TextStyle(
//               color: Color(0xff19649E),
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//         Column(
//           children: subcategories.entries.map((entry) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Checkbox(
//                   activeColor: Colors.blue,
//                   value: entry.value,
//                   onChanged: (newValue) {
//                     setState(() {
//                       subcategories[entry.key] = newValue!;
//                     });
//                   },
//                 ),
//                 Text(
//                   entry.key,
//                   textAlign: TextAlign.right,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
import 'package:doctor/screens/homescreen.dart';
import 'package:doctor/screens/specialist/choose_specialty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';
import '../../cubit/doctor_sign_up_cubit/doctor_sign_up_state.dart';
import '../../models/Specialist.dart';
import '../../widgets/custom_snake_bar.dart';

class SignUpAsDoctorThirdScreen extends StatefulWidget {
  final Specialist doctor;

  const SignUpAsDoctorThirdScreen({Key? key, required this.doctor})
      : super(key: key);

  @override
  State<SignUpAsDoctorThirdScreen> createState() =>
      _SignUpAsDoctorThirdScreenState();
}

class _SignUpAsDoctorThirdScreenState extends State<SignUpAsDoctorThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<SignUpSpecialistCubit, SignUpSpecialistState>(
          listener: (context, state) {
            if (state is SignUpSpecialistFailure) {
              showErrorSnackBar(context, state.errMessage);
            } else if (state is SignUpSpecialistSuccess) {
              navigateToHomeScreen(context);
            }
          },
          child: BlocBuilder<SignUpSpecialistCubit, SignUpSpecialistState>(
            builder: (context, state) {
              if (state is SignUpSpecialistLoading) {
                return loadingState(state);
              }
              return ChooseSpecialty(
                doctor: widget.doctor,
              );
            },
          ),
        ),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(
        context: context,
        message: message,
        backgroundColor: Colors.red,
        icon: Icons.error,
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Widget loadingState(SignUpSpecialistLoading state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/loading.gif'),
          const SizedBox(height: 20),
          Text(state.message),
        ],
      ),
    );
  }
}
