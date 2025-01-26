import 'package:dio/dio.dart';
import 'package:doctor/cubit/user_profile_cubit/user_profile_cubit.dart';
import 'package:doctor/screens/client_profile_details.dart';
import 'package:doctor/screens/client_profile_screen.dart';
import 'package:doctor/screens/psychological_disorders_screen.dart';
import 'package:doctor/screens/settings_screen.dart';
import 'package:doctor/screens/splashscreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'api/dio_consumer.dart';
import 'api/user_repository.dart';
import 'cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Arabic
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        // fallbackLocale: Locale('en', 'ar'),
        child: MultiBlocProvider(

          providers: [
            BlocProvider(
              create: (context) => SignUpSpecialistCubit(),
            ),
            BlocProvider(
              create: (context) => UserProfileCubit(),
            ),
          ],
          child: const GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: MyApp(),
          ),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: context.locale, // Default locale
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,

      title: 'doctorapp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
