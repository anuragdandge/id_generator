import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:id_generator/pages/login.dart';
import 'package:id_generator/pages/participant/notifications.dart';
import 'package:id_generator/pages/participant/profile.dart';
import 'package:id_generator/pages/participant/view_events.dart';

import 'package:mac_address/mac_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../animations/slideRight.dart';

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
    // getSharedPrefs();
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

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Student Home "),
        actions: [
          // IconButton(
          //   onPressed: () async {
          //     SharedPreferences prefs = await SharedPreferences.getInstance();
          //     prefs.setBool('isLoggedIn', false);
          //     prefs.remove('profile');
          //     Get.off(
          //       () => const LoginScreen(),
          //     );
          //   },
          //   icon: const Icon(
          //     Icons.logout,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              Get.to(() => const Notifications());
            },
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
              onPressed: () {
                Get.to(() => const Profile());
              },
              icon: const Icon(Icons.account_circle_outlined))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: -2,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    './assets/images/viewEvents.svg',
                    height: 150,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      minimumSize:
                          const MaterialStatePropertyAll(Size.fromHeight(50.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: const ViewEvents()));
                    },
                    child: const Text(
                      " View Events  ",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
