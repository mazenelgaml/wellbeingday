import 'package:doctor/screens/specialists_screen.dart';
import 'package:doctor/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_image_to_profile/add_image_to_profile_cubit.dart';
import '../cubit/update_user_cubit/update_user_cubit.dart';
import '../cubit/user_profile_cubit/user_profile_cubit.dart';

class AnxietyScreen extends StatelessWidget {
  const AnxietyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed:(){Navigator.pop(context);},icon:Icon(Icons.keyboard_backspace_rounded,size: 30,),color: Color(0xff19649E),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),

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
                      "القلق",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // "أهمية البرامج" Section
              Text(
                "أهمية البرامج",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(

                  initialValue:
                  "هو خطة مدروسة متكاملة لعلاج الفرد بكل نواحيه المعرفية والسلوكية والانفعالية، وهو يحدد الاهداف ويستعمل كل التقنيات الضرورة لتحقيقها.فهو يستعمل الوقت بافضل طريقة ويستخدم كل التدخلات العلاجية الضرورية، ويحقق أفضل النتائج العلاجية عمقا في النفس وتأثيرا على الحياة وأكثر ثباتا لنتائجه الإيجابية",
                  maxLines: null, // Allows the field to expand for multiline input
                  style: const TextStyle(fontSize: 14, height: 1.6),

                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: InputBorder.none, // Removes the underline
                    contentPadding: EdgeInsets.zero, // Matches the original padding
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
              // "الخطة / العلاج" Section
              Text(
                "الخطة / العلاج",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(

                  maxLines: null, // Allows the field to expand for multiline input
                  style: const TextStyle(fontSize: 14, height: 1.6),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Removes the underline
                    contentPadding: EdgeInsets.zero, // Matches the original padding
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // "الأهداف" Section
              Text(
                "الأهداف",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: null, // Allows the field to expand for multiline input
                  style: const TextStyle(fontSize: 14, height: 1.6),
                  decoration: const InputDecoration(

                    border: InputBorder.none, // Removes the underline
                    contentPadding: EdgeInsets.zero, // Matches the original padding
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.045),
              // "الأهداف" Section
              Text(
                "المراحل",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: null, // Allows the field to expand for multiline input
                  style: const TextStyle(fontSize: 14, height: 1.6),
                  decoration: const InputDecoration(

                    border: InputBorder.none, // Removes the underline
                    contentPadding: EdgeInsets.zero, // Matches the original padding
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // "الأهداف" Section
              Text(
                "التقنيات",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: null, // Allows the field to expand for multiline input
                  style: const TextStyle(fontSize: 14, height: 1.6),
                  decoration: const InputDecoration(

                    border: InputBorder.none, // Removes the underline
                    contentPadding: EdgeInsets.zero, // Matches the original padding
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // "الأهداف" Section
              Text(
                "الجلسات",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: null, // Allows the field to expand for multiline input
                  style: const TextStyle(fontSize: 14, height: 1.6),
                  decoration: const InputDecoration(

                    border: InputBorder.none, // Removes the underline
                    contentPadding: EdgeInsets.zero, // Matches the original padding
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // "الأهداف" Section
              Text(
                "تدريب على مهارات",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  maxLines: null, // Allows the field to expand for multiline input
                  style: const TextStyle(fontSize: 14, height: 1.6),
                  decoration: const InputDecoration(

                    border: InputBorder.none, // Removes the underline
                    contentPadding: EdgeInsets.zero, // Matches the original padding
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
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
                        child: const SpecialistsScreen(),
                      ),

                    ),

                  );
                },
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
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
    );
  }
}
