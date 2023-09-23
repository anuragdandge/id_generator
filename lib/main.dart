import 'package:flutter/material.dart';
import 'package:id_generator/features/generate_qr_code.dart';
import 'package:id_generator/pages/login.dart';
import 'package:id_generator/features/qr_scanner.dart';

import 'package:id_generator/pages/signup.dart';
import 'package:id_generator/pages/student_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StudentQR(),
    );
  }
}
