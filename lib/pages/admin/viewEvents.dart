import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Widgets/event_card_admin.dart';

class ViewEvents extends StatefulWidget {
  const ViewEvents({super.key});

  @override
  State<ViewEvents> createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  final List<String> roles = [
    'Participant',
    'Volunteer',
    'Co-Ordinator',
    'Head Co-Ordinator',
  ];
  // ignore: unused_field
  String? _selectedRole;
  late List<Map<String, dynamic>> events = [];
  bool isLoaded = false;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Events "),
      ),
      body:
          // events.isEmpty
          //     ? Center(
          //         child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           LottieBuilder.asset('./assets/lotties/noEvent.json'),
          //           const Text.rich(TextSpan(
          //               text: "No Events ",
          //               style:
          //                   TextStyle(fontSize: 50, fontWeight: FontWeight.w500)))
          //         ],
          //       ))
          //     :
          isLoaded
              ? events.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset('./assets/lotties/noEvent.json'),
                          const Text.rich(TextSpan(
                              text: "No Events ",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)))
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _getEvents,
                      child: ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return EventCardWidgetAdmin(
                              eventName: events[index]['eventTitle'],
                              location: events[index]['eventAddress'],
                              description: events[index]['eventDescription'],
                              startDate: events[index]['eventStartDate'],
                              endDate: events[index]['eventEndDate'],
                              startTime: events[index]['eventStartTime'],
                              endTime: events[index]['eventEndTime'],
                              onRegister: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                        "Registering for ${events[index]['eventTitle']} event "),
                                    content: Form(
                                      child: DropdownMenu<String>(
                                        initialSelection: "Participant",
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            _selectedRole = value!;
                                          });
                                        },
                                        leadingIcon: const Icon(Icons.person),
                                        label: const Text(" Select Role  "),
                                        dropdownMenuEntries: roles
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                            value: value,
                                            label: value,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(" Close "),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.deepPurple[100])),
                                        child: const Text(
                                          " Register",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });

                          // return Container(
                          //   width: double.infinity,
                          //   margin: const EdgeInsets.all(16.0),
                          //   padding: const EdgeInsets.all(16.0),
                          //   decoration: BoxDecoration(
                          //       color: Colors.deepPurple[100],
                          //       borderRadius: BorderRadius.circular(20)),
                          //   child: Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             events[index]['eventTitle'] ??
                          //                 " Loading...",
                          //             style: const TextStyle(
                          //               fontSize: 30,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //           // isEditing
                          //           //     ? IconButton(
                          //           //         onPressed: () {
                          //           //           setState(() {
                          //           //             isEditing = false;
                          //           //           });
                          //           //         },
                          //           //         icon: const Icon(
                          //           //           Icons.done,
                          //           //           size: 32,
                          //           //           semanticLabel: "Edit Event",
                          //           //         ),
                          //           //         style: const ButtonStyle(),
                          //           //       ):
                          //           IconButton(
                          //             onPressed: () {
                          //               // showDialog(
                          //               //   context: context,
                          //               //   builder: (context) => const AlertDialog(
                          //               //     title: Text("Edit Event "),
                          //               //     // content: Form(child: Column(
                          //               //     // )),
                          //               //   ),
                          //               // );
                          //               editEvent(events[index]['uuid'], index);
                          //               setState(() {
                          //                 isEditing = true;
                          //               });
                          //             },
                          //             icon: const Icon(
                          //               Icons.edit_calendar_outlined,
                          //               size: 32,
                          //               semanticLabel: "Edit Event",
                          //             ),
                          //             style: const ButtonStyle(),
                          //           )
                          //         ],
                          //       ),
                          //       const Divider(
                          //         color: Colors.black,
                          //         thickness: 2,
                          //       ),
                          //       Text(
                          //         events[index]['eventDescription'],
                          //         style: const TextStyle(
                          //           fontSize: 17,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       const Text(
                          //         "Date",
                          //         style: TextStyle(
                          //           fontSize: 25,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Text(
                          //               events[index]['eventStartDate'] +
                          //                   " to " +
                          //                   events[index]['eventEndDate'],
                          //               style: const TextStyle(
                          //                   fontWeight: FontWeight.w400,
                          //                   fontSize: 20,
                          //                   color: Colors.black54),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       const Text(
                          //         "Timing ",
                          //         style: TextStyle(
                          //           fontSize: 25,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Text(
                          //               events[index]['eventStartTime'] +
                          //                   " to " +
                          //                   events[index]['eventEndTime'],
                          //               style: const TextStyle(
                          //                   fontWeight: FontWeight.w400,
                          //                   fontSize: 20,
                          //                   color: Colors.black54),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       const Text(
                          //         "Location ",
                          //         style: TextStyle(
                          //           fontSize: 25,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //       Text(
                          //         events[index]['eventAddress'],
                          //         style: const TextStyle(
                          //             fontWeight: FontWeight.w400, fontSize: 20),
                          //       ),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //           IconButton(
                          //             onPressed: () => deleteEvent(index),
                          //             icon: const Icon(
                          //               Icons.delete,
                          //               size: 32,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       // ElevatedButton(
                          //       //   onPressed: () {
                          //       //     showDialog(
                          //       //       context: context,
                          //       //       builder: (context) => AlertDialog(
                          //       //         title: Text(
                          //       //             "Registering for ${events[index]['eventTitle']} event "),
                          //       //         content: Form(
                          //       //           child: DropdownMenu<String>(
                          //       //             initialSelection: "Participant",
                          //       //             onSelected: (String? value) {
                          //       //               // This is called when the user selects an item.
                          //       //               setState(() {
                          //       //                 _selectedRole = value!;
                          //       //               });
                          //       //             },
                          //       //             leadingIcon: const Icon(Icons.person),
                          //       //             label: const Text(" Select Role  "),
                          //       //             dropdownMenuEntries: roles
                          //       //                 .map<DropdownMenuEntry<String>>(
                          //       //                     (String value) {
                          //       //               return DropdownMenuEntry<String>(
                          //       //                 value: value,
                          //       //                 label: value,
                          //       //               );
                          //       //             }).toList(),
                          //       //           ),
                          //       //         ),
                          //       //         actions: [
                          //       //           TextButton(
                          //       //             onPressed: () => Navigator.pop(context),
                          //       //             child: const Text(" Close "),
                          //       //           ),
                          //       //           ElevatedButton(
                          //       //             onPressed: () => Navigator.pop(context),
                          //       //             style: ButtonStyle(
                          //       //                 backgroundColor:
                          //       //                     MaterialStatePropertyAll(
                          //       //                         Colors.deepPurple[100])),
                          //       //             child: const Text(
                          //       //               " Register",
                          //       //               style: TextStyle(
                          //       //                   fontWeight: FontWeight.bold),
                          //       //             ),
                          //       //           )
                          //       //         ],
                          //       //       ),
                          //       //     );
                          //       //   },
                          //       //   child: const Text("Register For Event "),
                          //       // )
                          //     ],
                          //   ),
                          // );
                        },
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 10.0,
                  ),
                ),
    );
  }

  Future<void> _getEvents() async {
    var collection = FirebaseFirestore.instance.collection('events');
    var data = await collection.get();

    late List<Map<String, dynamic>> tempList = [];
    for (var element in data.docs) {
      tempList.add(element.data());
    }
    setState(() {
      events = tempList;
      isLoaded = true;
    });
  }

  void editEvent(String uuid, int index) {
    debugPrint(uuid);
    debugPrint("$index");
    setState(() {});
  }

  void deleteEvent(int index) async {
    debugPrint(" Deleting  Event .... ");
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Are you Sure ? "),
              content: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel "),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      QuerySnapshot snapshot = await FirebaseFirestore.instance
                          .collection('events')
                          .where('uuid', isEqualTo: events[index]['uuid'])
                          .get();
                      var id = snapshot.docs[0].id;
                      await FirebaseFirestore.instance
                          .collection('events')
                          .doc(id)
                          .delete();
                      Navigator.pop(context);
                      debugPrint(" Event Deleted !!! ");
                      _getEvents();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete),
                        Text("Delete "),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
