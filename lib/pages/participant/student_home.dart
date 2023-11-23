import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:id_generator/pages/login.dart';
import 'package:id_generator/pages/participant/notifications.dart';
import 'package:id_generator/pages/participant/profile.dart';
import 'package:id_generator/pages/participant/view_events.dart';
import 'package:intl/intl.dart';

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
  late String name = '';
  late String eventAddress = '';
  late String eventDescription = '';
  late String eventEndDate;
  late String eventEndTime;
  late String eventStartDate;
  late String eventStartTime;
  late String eventTitle = '';
  String phone = '';
  bool eventLoading = true;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
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
        backgroundColor: Colors.deepPurple,
        elevation: 2,
        title: Text(
          "Hello, $name 👋 ",
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
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
          // IconButton(
          //   onPressed: () {
          //     Get.to(() => const Notifications());
          //   },
          //   icon: const Icon(Icons.notifications_none),
          // ),
          IconButton(
              onPressed: () {
                Get.to(() => const Profile());
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius: BorderRadius.circular(10)),
            child: const Text(
              " Featured Event 🔥 ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          // Center(
          //   child: Container(
          //     padding: const EdgeInsets.all(24.0),
          //     margin: const EdgeInsets.all(16.0),
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(10),
          //       boxShadow: const [
          //         BoxShadow(
          //           color: Colors.grey,
          //           blurRadius: 10,
          //           spreadRadius: -2,
          //           offset: Offset(0, 10),
          //         )
          //       ],
          //     ),
          //     child: Column(
          //       children: [
          //         SvgPicture.asset(
          //           './assets/images/viewEvents.svg',
          //           height: 150,
          //           width: double.infinity,
          //         ),
          //         const SizedBox(
          //           height: 24,
          //         ),
          //         ElevatedButton(
          //           style: ButtonStyle(
          //             shape: MaterialStatePropertyAll(
          //               RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10.0),
          //               ),
          //             ),
          //             backgroundColor:
          //                 const MaterialStatePropertyAll(Colors.white),
          //             minimumSize:
          //                 const MaterialStatePropertyAll(Size.fromHeight(50.0)),
          //           ),
          //           onPressed: () {
          //             Navigator.push(
          //                 context, SlideRightRoute(page: const ViewEvents()));
          //           },
          //           child: const Text(
          //             " View Events  ",
          //             style: TextStyle(fontSize: 25),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple[50],
                border: Border.all(
                    style: BorderStyle.solid, width: 1, color: Colors.grey)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/abc.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventTitle,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            eventLoading
                                ? const Text("Loading...")
                                : Text(
                                    "${DateFormat("EEEE").format(DateFormat("dd-MM-yyyy").parse(eventStartDate))} ${eventStartTime.substring(0, 4)} onwards ",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   location,
                            //   style: const TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.w400,
                            //     color: Colors.black54,
                            //   ),
                            // ),
                            // Text(
                            //   description,
                            //   style: const TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w400,
                            //     color: Colors.black45,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Animate(
                            effects: const [
                              FlipEffect(
                                curve: Curves.bounceOut,
                                duration: Duration(seconds: 2),
                              ),
                            ],
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.black45,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(3, 3),
                                    blurRadius: 0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: eventLoading
                                        ? const Text("Loading...")
                                        : Text(
                                            DateFormat("MMM").format(
                                              DateFormat("dd-MM-yyyy")
                                                  .parse(eventStartDate),
                                            ),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                  eventLoading
                                      ? const Text("Loading...")
                                      : Text(
                                          DateFormat("d").format(
                                            DateFormat("dd-MM-yyyy")
                                                .parse(eventStartDate),
                                          ),
                                          style: const TextStyle(
                                              fontSize: 26,
                                              color: Colors.deepPurple),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewEvents()));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "View more ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('uuid', isEqualTo: uuid)
        .get();
    QuerySnapshot snapshotE = await FirebaseFirestore.instance
        .collection('events')
        .where('featured', isEqualTo: true)
        .get();

    print(snapshotE.docs[0].data());
    setState(() {
      name = snapshot.docs[0]['fullname'];
      eventTitle = snapshotE.docs[0]['eventTitle'];
      // eventDescription = snapshotE.docs[0]['eventDescription'];
      eventStartDate = snapshotE.docs[0]['eventStartDate'];
      eventEndDate = snapshotE.docs[0]['eventEndDate'];
      eventStartTime = snapshotE.docs[0]['eventStartTime'];
      eventEndTime = snapshotE.docs[0]['eventEndTime'];
      eventAddress = snapshotE.docs[0]['eventAddress'];
      eventLoading = false;
      prefs.setString('studId', snapshot.docs[0].id);

      // profileUrl = snapshot.docs[0]['profileUrl'];
      // phoneNumber = snapshot.docs[0]['phonenumber'];
      // emergencyNumber = snapshot.docs[0]['emergencynumber'];
      // division = snapshot.docs[0]['division'];
      // bloodGroup = snapshot.docs[0]['bloodgroup'];
      // classValue = snapshot.docs[0]['class'];
      // gender = snapshot.docs[0]['gender'];
      // dateOfBirth = snapshot.docs[0]['dateofbirth'];
      // academicYear = snapshot.docs[0]['academicyear'];
      // localAddress = snapshot.docs[0]['localaddress'];
      // rollNumber = snapshot.docs[0]['rollnumber'];
    });
  }
}
