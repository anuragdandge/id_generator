import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);

                  Navigator.pop(context);
                  debugPrint(" User Logged Out !!!");
                  Get.to(() => const LoginScreen());
                },
                icon: const Icon(Icons.logout)),
          ),
        ],
        title: const Text("Welcome  "),
      ),
    );
  }
}
