import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/features/generate_qr_code.dart';
import 'package:id_generator/firebase_options.dart';
import 'package:id_generator/pages/login.dart';
import 'package:id_generator/features/qr_scanner.dart';

import 'package:id_generator/pages/signup.dart';
import 'package:id_generator/pages/student_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: Signup(),
    );
  }
}
