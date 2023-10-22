// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/viewEvents.dart';

import '../animations/slideRight.dart';
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
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(24.0),
              margin: EdgeInsets.all(16.0),
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
                      minimumSize:
                          const MaterialStatePropertyAll(Size.fromHeight(50.0)),
                    ),
                    onPressed: () {
                      // Navigator.push(context,
                      //     SlideRightRoute(page: const CreateEventScreen()));
                      Get.to(() => const CreateEventScreen());
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
              padding: EdgeInsets.all(24.0),
              margin: EdgeInsets.all(16.0),
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
                      // Navigator.push(context,
                      //     SlideRightRoute(page: const ViewEventsScreen()));
                      Get.to(() => const ViewEventsScreen());
                    },
                    child: const Text(
                      " View Events  ",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      //
    );
  }
}
