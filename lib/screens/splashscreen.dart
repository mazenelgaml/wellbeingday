import 'package:doctor/screens/home_second_screen.dart';
import 'package:doctor/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/user_profile_cubit/user_profile_cubit.dart';
import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define a tween for scaling the image
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _animationController.forward();

    // Navigate to the next screen after some time
    Timer(const Duration(seconds: 3), () async{
      final prefs = await SharedPreferences.getInstance();
      prefs.containsKey("userId")?
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (_) => UserProfileCubit(),
              child:HomeScreen()
          ),
        ),
      )
      :Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: 225,
            height: 178.62,
            child: Image.asset('assets/images/img.png', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

