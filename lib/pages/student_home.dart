import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:id_generator/pages/participant/view_events.dart';

import 'package:mac_address/mac_address.dart';

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

  // void getSharedPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   debugPrint(prefs.getString("uuid"));
  //   debugPrint(prefs.getString("phone"));
  //   debugPrint(prefs.getString("name"));
  //   setState(() {
  //     uuid = prefs.getString("uuid")!;
  //     phone = prefs.getString("phone")!;
  //     name = prefs.getString("name")!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.purpleAccent,
    //   body: Lottie.asset(
    //     'assets/lotties/splash.json',
    //   ),
    // );
    return const ViewEvents();
  }
}
