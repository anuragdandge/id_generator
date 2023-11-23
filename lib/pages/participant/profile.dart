import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    getRegisteredEvents();
    super.initState();
  }

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

  bool hide = false;

  void toggleVisibility() {
    setState(() {
      hide = !hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Get.off(() => const LoginScreen());
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[400],
                  // borderRadius: const BorderRadius.only(
                  //   bottomLeft: Radius.circular(40),
                  //   bottomRight: Radius.circular(40),
                  // ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(209, 196, 233, 1),
                                width: 3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FutureBuilder(
                              future: loadImageFromNetwork(profileUrl),
                              builder: (BuildContext context,
                                  AsyncSnapshot<ImageProvider<Object>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return Image(
                                    image: snapshot.data!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text('Error loading image');
                                } else {
                                  return const SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    fullName,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  verified == 'true'
                                      ? const Icon(
                                          Icons.gpp_good,
                                          color: Colors.greenAccent,
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            toggleVisibility();
                                          },
                                          icon: const Icon(Icons.gpp_maybe),
                                          color: Colors.amberAccent,
                                        ),
                                ],
                              ),
                              Text(
                                "$classValue[$division] | Roll: $rollNumber",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
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
              Visibility(
                visible: hide,
                child: Animate(
                  effects: const [
                    FadeEffect(),
                    SlideEffect(
                        begin: Offset(
                          1,
                          0,
                        ),
                        curve: Curves.easeIn)
                  ],
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.info_outline_rounded),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Profile unverified ! ")
                          ],
                        ),
                        IconButton(
                            onPressed: toggleVisibility,
                            icon: Icon(Icons.close))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Phone Number ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                phoneNumber,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Emergency Number ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                emergencyNumber,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Gender ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                gender,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Blood Group ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                bloodGroup,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Academic Year ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                academicYear,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Date Of Birth ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                dateOfBirth,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Local Address ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              localAddress,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  " Registered Events ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
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
    late List<Map<String, dynamic>> detailedList = [];
    // int iterator = 0;
    for (var element in data.docs) {
      tempList.add(element.data());
      Map<String, dynamic> e = element.data();
      DocumentSnapshot<Map<String, dynamic>> snapshotE = await FirebaseFirestore
          .instance
          .collection('events')
          .doc(e['eventId'])
          .get();
      print(snapshotE['eventTitle']);
      // iterator++;
    }
    // print(tempList[0]);

    // for (var i = 0; i < tempList.length; i++) {
    //   var evid = tempList[i]['eventId'];
    //   print(evid);
    //   DocumentSnapshot<Map<String, dynamic>> snapshotE =
    //       await FirebaseFirestore.instance.collection('events').doc(evid).get();
    //   if (snapshotE.exists) {
    //     // Document exists
    //     Map<String, dynamic> data = snapshotE.data() as Map<String, dynamic>;
    //     // Use 'data' Map to access document fields
    //     print('Document data: $data');
    //   } else {
    //     // Document does not exist
    //     print('Document does not exist');
    //   }
    //   // var eventData = snapshotE.docs[0].data();
    //   // print(eventData);
    // }
    // List<Map<String, dynamic>> tempList = [];
    // for (var element in data.docs) {
    //   Map<String, dynamic> eventInfo = element.data();
    //   var evId = eventInfo['eventId'];
    //   QuerySnapshot snapshotE = await FirebaseFirestore.instance
    //       .collection('events')
    //       .where('eventId', isEqualTo: evId)
    //       .get();
    // }
  }
  // Future<void> getRegisteredEvents() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   QuerySnapshot snapshotS = await FirebaseFirestore.instance
  //       .collection('students')
  //       .where('uuid', isEqualTo: prefs.getString('uuid'))
  //       .get();

  //   var studId = snapshotS.docs[0].id;
  //   var collection = FirebaseFirestore.instance
  //       .collection('students/$studId/registeredEvents');

  //   var data = await collection.get();

  //   List<Map<String, dynamic>> eventDetailsList = [];

  //   for (var element in data.docs) {
  //     Map<String, dynamic> eventInfo = element.data();
  //     var evId = eventInfo['eventId'];

  //     QuerySnapshot snapshotE = await FirebaseFirestore.instance
  //         .collection('events')
  //         .where('eventId', isEqualTo: evId)
  //         .get();

  //     if (snapshotE.docs.isNotEmpty) {
  //       // Assuming eventId is unique, accessing first document from the query result
  //       var eventData = snapshotE.docs[0].data();

  //       // Adding event details to the list
  //       eventDetailsList.add({
  //         'eventId': evId,
  //         // 'eventName': eventName,
  //         // Add other event details you want to include
  //       });
  //     }
  //   }

  //   // Print or use the collected event details
  //   for (var eventDetails in eventDetailsList) {
  //     print('Event ID: ${eventDetails['eventId']}');
  //     print('Event Name: ${eventDetails['eventName']}');
  //     // Print other event details
  //   }
  // }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('uuid');
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('uuid', isEqualTo: uuid)
        .get();

    // print(snapshot.docs[0].data());
    setState(() {
      fullName = snapshot.docs[0]['fullname'];
      profileUrl = snapshot.docs[0]['profileUrl'];
      phoneNumber = snapshot.docs[0]['phonenumber'];
      emergencyNumber = snapshot.docs[0]['emergencynumber'];
      division = snapshot.docs[0]['division'];
      bloodGroup = snapshot.docs[0]['bloodgroup'];
      classValue = snapshot.docs[0]['class'];
      gender = snapshot.docs[0]['gender'];
      dateOfBirth = snapshot.docs[0]['dateofbirth'];
      academicYear = snapshot.docs[0]['academicyear'];
      localAddress = snapshot.docs[0]['localaddress'];
      rollNumber = snapshot.docs[0]['rollnumber'];
      verified = snapshot.docs[0]['verified'];
    });
  }

  Future<ImageProvider<Object>> loadImageFromNetwork(String imageUrl) async {
    // Simulate network delay with a Future.delayed
    await Future.delayed(
        Duration(seconds: 2)); // Replace with your image loading logic

    // Return the NetworkImage if loading was successful
    return NetworkImage(imageUrl);
  }
}
