import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventParticipants extends StatefulWidget {
  final String? eventId;
  const EventParticipants({super.key, required this.eventId});

  @override
  State<EventParticipants> createState() => _EventParticipantsState();
}

class _EventParticipantsState extends State<EventParticipants> {
  late List<Map<String, dynamic>> participants = [];
  bool isLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    _getParticipants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Participants"),
      ),
      body: RefreshIndicator(
          onRefresh: () async {},
          child: isLoaded
              ? ListView.builder(
                  itemCount: participants.length,
                  itemBuilder: (context, index) {
                    // return Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.all(16),
                    //   margin: const EdgeInsets.all(16),
                    //   height: 130,
                    //   decoration: BoxDecoration(
                    //     color: Colors.deepPurple[100],
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Row(children: [
                    //     Container(
                    //       height: 95,
                    //       width: 95,
                    //       decoration: BoxDecoration(
                    //         color: Colors.deepPurple[50],
                    //         borderRadius: const BorderRadius.all(
                    //           Radius.circular(8),
                    //         ),
                    //       ),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: Image.network(
                    //           participants[index]['profileUrl'],
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Column(
                    //         children: [
                    //           Text(participants[index]['fullname']),
                    //           Text(participants[index]['phonenumber']),
                    //         ],
                    //       ),
                    //     )
                    //   ]),
                    // );

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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                                participants[index]['profileUrl'],
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
                                            participants[index]['fullname'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black54,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            participants[index]['phonenumber'],
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
                                                    color:
                                                        Colors.deepPurple[400],
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
                                                              color:
                                                                  Colors.white,
                                                              size: 24,
                                                            ),
                                                          ),
                                                          const Text(
                                                            "Student profile ",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white,
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
                                                                participants[
                                                                        index][
                                                                    'profileUrl'],
                                                                height: 100,
                                                                width: 100,
                                                                fit: BoxFit
                                                                    .cover,
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
                                                                  participants[
                                                                          index]
                                                                      [
                                                                      'fullname'],
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  participants[
                                                                              index]
                                                                          [
                                                                          'class'] +
                                                                      "[" +
                                                                      participants[
                                                                              index]
                                                                          [
                                                                          'division'] +
                                                                      "] | Roll: " +
                                                                      participants[
                                                                              index]
                                                                          [
                                                                          'rollnumber'],
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        18,
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
                                                  padding: const EdgeInsets.all(
                                                      32.0),
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
                                                                    fontSize:
                                                                        16,
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
                                                                participants[
                                                                        index][
                                                                    "phonenumber"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        18,
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
                                                                    fontSize:
                                                                        16,
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
                                                                participants[
                                                                        index][
                                                                    "emergencynumber"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        18,
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
                                                                    fontSize:
                                                                        16,
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
                                                                participants[
                                                                        index]
                                                                    ["gender"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        18,
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
                                                                    fontSize:
                                                                        16,
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
                                                                participants[
                                                                        index][
                                                                    "bloodgroup"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        18,
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
                                                                    fontSize:
                                                                        16,
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
                                                                participants[
                                                                        index][
                                                                    "academicyear"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        18,
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
                                                                    fontSize:
                                                                        16,
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
                                                                participants[
                                                                        index][
                                                                    "dateofbirth"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        18,
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
                                                                    fontSize:
                                                                        16,
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
                                                                participants[
                                                                        index][
                                                                    "localaddress"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                            .grey[
                                                                        700]),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        participants[index]
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
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  // void getData() async {
  //   QuerySnapshot psnapshot = await FirebaseFirestore.instance
  //       .collection('events/${widget.eventId}/participants')
  //       .get();
  //   print(psnapshot.docs[0]);
  //   psnapshot.docs.forEach((doc) {
  //     // Access each document
  //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  //     // Print specific fields or the entire document
  //     print('Document ID: ${doc.id}');
  //     print('Data: $data');

  //     // Accessing specific fields in the document
  //     print('Participant Role: ${data['role']}');
  //     print('Participant UUID: ${data['uuid']}');
  //     // Add more fields you want to print...
  //   });
  //   participants =
  // }

  // Future<void> _getParticipants() async {
  //   // print("_getParticipants");
  //   var collection = FirebaseFirestore.instance
  //       .collection('events/${widget.eventId}/participants');
  //   var data = await collection.get();

  //   late List<Map<String, dynamic>> tempList = [];
  //   print(collection.count().get());
  //   for (var element in data.docs) {
  //     tempList.add(element.data());
  //     // print(tempList[0]['uuid']);
  //     final collections = FirebaseFirestore.instance
  //         .collection('students')
  //         .where('uuid', isEqualTo: tempList[0]['uuid']);
  //     var data = await collections.get();
  //     for (var element in data.docs) {
  //       // print(element.data());
  //     }
  //   }
  //   // print(tempList);
  //   setState(() {
  //     participants = tempList;
  //     isLoaded = true;
  //   });
  // }

  Future<void> _getParticipants() async {
    var collection = FirebaseFirestore.instance
        .collection('events/${widget.eventId}/participants');
    var data = await collection.get();

    List<Map<String, dynamic>> tempList = [];

    for (var element in data.docs) {
      Map<String, dynamic> participantData = element.data();
      String participantUUID = participantData['uuid'];

      var studentCollection = FirebaseFirestore.instance
          .collection('students')
          .where('uuid', isEqualTo: participantUUID);

      var studentData = await studentCollection.get();
      for (var studentElement in studentData.docs) {
        Map<String, dynamic> studentInfo = studentElement.data();
        // Here you can access the information of the student
        print('Participant Information: $studentInfo');
        // Add the student information to your list or perform any other operations
        tempList.add(studentInfo);
      }
    }

    setState(() {
      participants = tempList;
      isLoaded = true;
    });
  }
}
