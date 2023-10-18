// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:id_generator/features/authentication/screens/adminHome.dart';
import 'package:id_generator/features/authentication/screens/login.dart';
import './features/authentication/checklocation.dart';
import './features/authentication/screens/qr_scanner.dart';
import './features/authentication_login.dart';
import './features/generate_qr_code.dart';
import 'package:mac_address/mac_address.dart';
import './firebase_options.dart';
import './pages/verify_otp.dart';
import './pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './features/authentication/screens/otp_screen.dart';
// import './src/repository/authentication_repository/authentication_repository.dart';
import './pages/student_home.dart';
import 'features/authentication/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // .then((value) => Get.put(AuthenticationRepository()));
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
      home: const SplashScreen(),
    );
  }
}
