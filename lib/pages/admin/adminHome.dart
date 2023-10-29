// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/admin/viewAllStudents.dart';
import 'package:id_generator/pages/login.dart';
import 'package:id_generator/pages/admin/viewEvents.dart';
import 'package:id_generator/pages/student_qr.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../animations/slideRight.dart';
import 'createEventScreen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);
              Navigator.pop(context);
              Get.to(() => const LoginScreen());
            },
            icon: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
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
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        './assets/images/createEvent.svg',
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
                          minimumSize: const MaterialStatePropertyAll(
                              Size.fromHeight(50.0)),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              SlideRightRoute(page: const CreateEventScreen()));
                        },
                        child: const Text(
                          " Create Event ",
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                          offset: Offset(0, 10))
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
                          minimumSize: const MaterialStatePropertyAll(
                              Size.fromHeight(50.0)),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              SlideRightRoute(page: const ViewEventsScreen()));
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
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        './assets/images/seeStudents.svg',
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
                          minimumSize: const MaterialStatePropertyAll(
                              Size.fromHeight(50.0)),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   SlideRightRoute(
                          //     page: const ViewStudents(),
                          //   ),
                          // );
                          Get.to(() => StudentQR());
                        },
                        child: const Text(
                          " View Students  ",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //
    );
  }
}
