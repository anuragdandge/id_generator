import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/adminHome.dart';
import 'package:id_generator/pages/login.dart';

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
    print("Is User Already Logged in :  $isLoggedIn");
    Navigator.pop(context);
    Get.to(() => isLoggedIn ? const AdminHome() : const LoginScreen());
  }

  gotoHome() {}

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/lotties/splash.json'),
      ),
    );
  }
}
