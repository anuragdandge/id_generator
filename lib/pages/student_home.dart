import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mac_address/mac_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String _platformVersion = 'Unknown';
  String uuid = '';
  String name = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(prefs.getString("uuid"));
    debugPrint(prefs.getString("phone"));
    debugPrint(prefs.getString("name"));
    setState(() {
      uuid = prefs.getString("uuid")!;
      phone = prefs.getString("phone")!;
      name = prefs.getString("name")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.purpleAccent,
    //   body: Lottie.asset(
    //     'assets/lotties/splash.json',
    //   ),
    // );
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
                  // setState(() {});
                  debugPrint(" User Logged Out !!!");
                  Get.to(() => const LoginScreen());
                },
                icon: const Icon(Icons.logout)),
          ),
        ],
        title: const Text("Welcome "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Get SharedPrefs "),
            ),
            Text("UUID = $uuid"),
            Text("Phone = $phone"),
            Text("Name = $name"),
          ],
        ),
      ),
    );
  }
}
