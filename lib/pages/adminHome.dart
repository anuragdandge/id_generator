// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(10)),
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
          // Container(
          //   margin: const EdgeInsets.all(10),
          //   padding: const EdgeInsets.all(10),
          //   height: 250,
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     color: Color.fromARGB(255, 225, 225, 225),
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(10),
          //     ),
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Event ', // used by assistive technologies
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  child: AlertDialog(
                    title: const Text(" Select Date "),
                    content: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: DateRangePickerDialog(
                          firstDate: DateTime.now(), lastDate: DateTime(2090)),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close "))
                    ],
                  ),
                );
              });
          // showDateRangePicker(
          //     context: context,
          //     firstDate: DateTime.now(),
          //     lastDate: DateTime(2090));
        },
        child: const Icon(Icons.edit_calendar),
      ),
    );
  }
}
