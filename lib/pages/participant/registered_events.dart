import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisteredEvents extends StatefulWidget {
  const RegisteredEvents({super.key});

  @override
  State<RegisteredEvents> createState() => _RegisteredEventsState();
}

class _RegisteredEventsState extends State<RegisteredEvents> {
  @override
  void initState() {
    // TODO: implement initState
    getRegisteredEvents();
    super.initState();
  }

  bool isLoading = true;
  late List<Map<String, dynamic>> detailedList = [];
  String fullName = '';
  String uuid = '';
  String profileUrl = '';
  String phoneNumber = '';
  String password = '';
  String emergencyNumber = '';
  String division = '';
  String bloodGroup = '';
  String classValue = '';
  String gender = '';
  String dateOfBirth = '';
  String academicYear = '';
  String localAddress = '';
  String rollNumber = '';
  late String verified = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Events "),
      ),
      body: ListView.builder(
          itemCount: detailedList.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: .5, color: Colors.black)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          detailedList[index]['eventTitle'],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const Icon(
                          Icons.badge_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[500],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  " Phone Number ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  phoneNumber,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                // Text(
                                //   detailedList[index]['eventDescription'],
                                // ),
                                // Text(
                                //   detailedList[index]['eventStartTime'],
                                //   style: TextStyle(color: Colors.white),
                                // ),
                                // Text(
                                //   detailedList[index]['eventEndTime'],
                                //   style: TextStyle(color: Colors.white),
                                // ),
                                // Text(
                                //   detailedList[index]['eventStartDate'],
                                //   style: TextStyle(color: Colors.white),
                                // ),
                                // Text(
                                //   detailedList[index]['eventEndDate'],
                                // ),
                                // Text(
                                //   uuid,
                                //   style: TextStyle(color: Colors.white),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[50],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Image.network(
                                  profileUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                detailedList[index]['role'],
                              ),
                              // Text(
                              //   fullName,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          detailedList[index]['eventEndDate'] +
                              "," +
                              detailedList[index]['eventEndTime'],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white),
                        child: QrImageView(
                          data: uuid + detailedList[index]['role'],
                          size: 140,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          })),
    );
  }

  void getRegisteredEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    QuerySnapshot snapshotS = await FirebaseFirestore.instance
        .collection('students')
        .where('uuid', isEqualTo: prefs.getString('uuid'))
        .get();

    var studId = snapshotS.docs[0].id;
    var collection = FirebaseFirestore.instance
        .collection('students/$studId/registeredEvents');
    var data = await collection.get();

    late List<Map<String, dynamic>> tempList = [];
    // int iterator = 0;
    for (var element in data.docs) {
      tempList.add(element.data());
      // Map<String, dynamic> e = element.data();
      // DocumentSnapshot<Map<String, dynamic>> snapshotE = await FirebaseFirestore
      //     .instance
      //     .collection('events')
      //     .doc(e['eventId'])
      //     .get();
      // print(snapshotE['eventTitle']);
      // iterator++;
    }
    debugPrint("Events $tempList");
    setState(() {
      isLoading = false;
      fullName = snapshotS.docs[0]['fullname'];
      profileUrl = snapshotS.docs[0]['profileUrl'];
      phoneNumber = snapshotS.docs[0]['phonenumber'];
      emergencyNumber = snapshotS.docs[0]['emergencynumber'];
      division = snapshotS.docs[0]['division'];
      bloodGroup = snapshotS.docs[0]['bloodgroup'];
      classValue = snapshotS.docs[0]['class'];
      gender = snapshotS.docs[0]['gender'];
      dateOfBirth = snapshotS.docs[0]['dateofbirth'];
      academicYear = snapshotS.docs[0]['academicyear'];
      localAddress = snapshotS.docs[0]['localaddress'];
      rollNumber = snapshotS.docs[0]['rollnumber'];
      verified = snapshotS.docs[0]['verified'];
      uuid = snapshotS.docs[0]['uuid'];
      detailedList = tempList;
    });
  }

  // void getData() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var uuid = prefs.getString('uuid');
  // QuerySnapshot snapshot = await FirebaseFirestore.instance
  //     .collection('students')
  //     .where('uuid', isEqualTo: uuid)
  //     .get();

  // print(snapshot.docs[0].data());
  // setState(() {
  // fullName = snapshot.docs[0]['fullname'];
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
  // verified = snapshot.docs[0]['verified'];
  //   });
  // }
}
