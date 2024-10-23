import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:id_generator/pages/admin/admin_home.dart';
import 'package:id_generator/pages/login.dart';
import 'package:id_generator/pages/participant/view_events.dart';
import 'package:id_generator/pages/participant/student_home.dart';
import 'package:id_generator/pages/admin/student_profile.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var duration = const Duration(seconds: 7);
    return Timer(duration, route);
  }

  route() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? profile = prefs.getString('profile');
    print("Is User Already Logged in :  $isLoggedIn");
    print("Logged in as :  $profile");
    Navigator.pop(context);
    Get.to(
      () => isLoggedIn == false
          ? const LoginScreen()
          : profile == "admin"
              ? const AdminHome()
              : const StudentHome(),
    );
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lotties/splash.json', fit: BoxFit.cover),
        ],
      ),
    );
  }
}
