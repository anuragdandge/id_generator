// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:id_generator/pages/verify_otp.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// import 'login.dart';

// class StudentQR extends StatelessWidget {
//   // final String data;
//   // final String phone;
//   // final String name;
//   // final File file;

//   StudentQR({
//     Key? key,
//     // required this.data,
//     // required this.file,
//     // required this.name,
//     // required this.phone
//   }) : super(key: key);

//   String uuid = "";
//   String phoneNo = "";
//   String fullName = "";
//   String url = "";

//   getData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     uuid = prefs.getString('uuid')!;
//     final ref = FirebaseStorage.instance
//         .ref()
//         .child("1512e538-d558-4f9d-947c-38a0227b32bc");
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('credentials')
//         .where('uuid', isEqualTo: uuid)
//         .get();
//     url = await ref.getDownloadURL();
//     debugPrint(url);
//     if (snapshot.docs.isNotEmpty) {
//       for (QueryDocumentSnapshot document in snapshot.docs) {
//         Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//         fullName = data['fullname'];
//         phoneNo = data['phonenumber'];
//       }
//     } else {
//       // ignore: use_build_context_synchronously
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple[50],
//       appBar: AppBar(
//         title: const Text("Welcome "),
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: SizedBox(
//           width: double.infinity,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 height: 370,
//                 width: 370,
//                 decoration: BoxDecoration(color: Colors.deepPurple[100]),
//                 child: QrImageView(
//                   data: uuid,
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 150,
//                 margin: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     color: Colors.deepPurple[100],
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 150,
//                       width: 150,
//                       padding: const EdgeInsets.all(20),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           url,
//                           scale: 1.0,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 110,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                               child: Text(
//                             fullName,
//                             // "Anurag Dandge",
//                             style: const TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold),
//                           )),
//                           Container(child: Text(phoneNo)),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               TextButton(
//                   onPressed: () async {
//                     Get.to(() => const LoginScreen());
//                     final SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     await prefs.setBool('isLoggedIn', false);
//                     debugPrint("User Logged Out ");
//                   },
//                   child: const Text("Logout"))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  // String imgUrl = '';
  @override
  void initState() {
    super.initState();
    _getStudentData();
  }

  final storage = FirebaseStorage.instance;
  final collection = FirebaseFirestore.instance
      .collection('students')
      .orderBy('fullname', descending: false);
  late List<Map<String, dynamic>> students = [];
  bool isLoaded = false;
  Future<void> _getStudentData() async {
    var data = await collection.get();
    List<Map<String, dynamic>> tempList = [];
    for (var element in data.docs) {
      tempList.add(element.data());
    }
    setState(() {
      students = tempList;
      isLoaded = true;
    });
  }

  Future<void> refreshList() async {
    _getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome "),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);
                debugPrint(" Logged Out as User");
                Navigator.pop(context);
                Get.to(() => const LoginScreen());
              },
            ),
          )
        ],
      ),
      body: isLoaded
          ? RefreshIndicator(
              onRefresh: refreshList,
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 5,
                          spreadRadius: 0,
                          offset: Offset(0, 2),
                        )
                      ],
                      border: Border.all(color: Colors.black12, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.deepPurple[100],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 95,
                          width: 95,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[50],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              students[index]['profileUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          students[index]['fullname'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black54,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          students[index]['phonenumber'],
                                          style: const TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple[400],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(40),
                                                    bottomRight:
                                                        Radius.circular(40),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_back_ios,
                                                            color: Colors.white,
                                                            size: 24,
                                                          ),
                                                        ),
                                                        const Text(
                                                          "Student profile ",
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons.more_vert,
                                                            color: Colors.white,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    209,
                                                                    196,
                                                                    233,
                                                                    1),
                                                                width: 3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child:
                                                                Image.network(
                                                              students[index][
                                                                  'profileUrl'],
                                                              height: 100,
                                                              width: 100,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                students[index][
                                                                    'fullname'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                students[index]
                                                                        [
                                                                        'class'] +
                                                                    "[" +
                                                                    students[
                                                                            index]
                                                                        [
                                                                        'division'] +
                                                                    "] | Roll: " +
                                                                    students[
                                                                            index]
                                                                        [
                                                                        'rollnumber'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(32.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Phone Number ",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              students[index][
                                                                  "phonenumber"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Emergency Number ",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              students[index][
                                                                  "emergencynumber"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Gender ",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              students[index]
                                                                  ["gender"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Blood Group ",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              students[index][
                                                                  "bloodgroup"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Academic Year ",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              students[index][
                                                                  "academicyear"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Date Of Birth ",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              students[index][
                                                                  "dateofbirth"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Local Address ",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              students[index][
                                                                  "localaddress"],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      students[index]
                                                          ["verified"],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text("Show More "),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
