import 'package:flutter/material.dart';
import 'package:id_generator/features/generate_qr_code.dart';
import 'package:id_generator/pages/qr_scanner.dart';

import 'package:id_generator/pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenerateQR(),
    );
  }
}
