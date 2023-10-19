import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/features/authentication/screens/login.dart';
import 'package:id_generator/pages/verify_otp.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getStarted.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  startTime() async {
    var duration = const Duration(seconds: 8);
    return Timer(duration, route);
  }

  route() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print("Is User Already Logged in :  $isLoggedIn");
    Navigator.pop(context);
    Get.to(() => isLoggedIn ? const GetStarted() : const LoginScreen());
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/lotties/splash.json'),
      ),
    );
  }
}
