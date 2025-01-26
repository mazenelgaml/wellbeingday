import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:doctor/screens/thirdpage.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // محتوى الصفحة
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الصورة
                  Image.asset(
                    'assets/images/welcome.png', // أضف مسار الصورة هنا
                    height: 200,
                  ),

                  const SizedBox(height: 24.0),

                  // النص الرئيسي
                  Text(
                    'makeItEasy'.tr(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  // النص الوصفي
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'secondWelcomeScreen'.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24.0),

                  // زر الانتقال للصفحة التالية
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThirdPage()),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xff19649E), width: 2),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xff19649E),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // زر التخطي
            Positioned(
              top: 16.0,
              right: 16.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThirdPage()),
                  );  // Add functionality for skip if needed
                },
                child: Text(
                  'skip'.tr(),
                  style: const TextStyle(
                    color: Color(0xFF007BFF),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
