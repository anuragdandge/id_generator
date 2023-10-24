// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:id_generator/features/admin/createEvent/ui/create_event.dart';
import 'package:id_generator/pages/adminHome.dart';
import 'package:id_generator/pages/createEventScreen.dart';
import 'package:id_generator/pages/login.dart';
import 'package:id_generator/pages/student_qr.dart';
import 'pages/checklocation.dart';
import 'pages/qr_scanner.dart';
import 'pages/authentication_login.dart';
import 'pages/generate_qr_code.dart';
import 'package:mac_address/mac_address.dart';
import './firebase_options.dart';
import './pages/verify_otp.dart';
import './pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/otp_screen.dart';
// import './src/repository/authentication_repository/authentication_repository.dart';
import './pages/student_home.dart';
import 'pages/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CreateEvent(),
      // home: const AdminHome(),
    );
  }
}
