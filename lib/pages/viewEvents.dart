import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:id_generator/Widgets/eventListWidget.dart';

class ViewEventsScreen extends StatefulWidget {
  const ViewEventsScreen({super.key});

  @override
  State<ViewEventsScreen> createState() => _ViewEventsScreenState();
}

class _ViewEventsScreenState extends State<ViewEventsScreen> {
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
  String? _selectedRole;
  late List<Map<String, dynamic>> events;
  bool isLoaded = false;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(" Events "),
          actions: [
            IconButton(onPressed: _getEvents, icon: const Icon(Icons.refresh))
          ],
        ),
        body: isLoaded
            ? ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isEditing
                                ? SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      initialValue: events[index]['eventTitle'],
                                    ),
                                  )
                                : Text(
                                    events[index]['eventTitle'] ??
                                        " Loading...",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            isEditing
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditing = false;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      size: 32,
                                      semanticLabel: "Edit Event",
                                    ),
                                    style: ButtonStyle(),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) => const AlertDialog(
                                      //     title: Text("Edit Event "),
                                      //     // content: Form(child: Column(
                                      //     // )),
                                      //   ),
                                      // );
                                      setState(() {
                                        isEditing = true;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit_calendar_outlined,
                                      size: 32,
                                      semanticLabel: "Edit Event",
                                    ),
                                    style: ButtonStyle(),
                                  )
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Text(
                          events[index]['eventDescription'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                events[index]['eventStartDate'] +
                                    " to " +
                                    events[index]['eventEndDate'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Timing ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                events[index]['eventStartTime'] +
                                    " to " +
                                    events[index]['eventEndTime'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Location ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          " Address  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => deleteEvent(index),
                              icon: const Icon(
                                Icons.delete,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) => AlertDialog(
                        //         title: Text(
                        //             "Registering for ${events[index]['eventTitle']} event "),
                        //         content: Form(
                        //           child: DropdownMenu<String>(
                        //             initialSelection: "Participant",
                        //             onSelected: (String? value) {
                        //               // This is called when the user selects an item.
                        //               setState(() {
                        //                 _selectedRole = value!;
                        //               });
                        //             },
                        //             leadingIcon: const Icon(Icons.person),
                        //             label: const Text(" Select Role  "),
                        //             dropdownMenuEntries: roles
                        //                 .map<DropdownMenuEntry<String>>(
                        //                     (String value) {
                        //               return DropdownMenuEntry<String>(
                        //                 value: value,
                        //                 label: value,
                        //               );
                        //             }).toList(),
                        //           ),
                        //         ),
                        //         actions: [
                        //           TextButton(
                        //             onPressed: () => Navigator.pop(context),
                        //             child: const Text(" Close "),
                        //           ),
                        //           ElevatedButton(
                        //             onPressed: () => Navigator.pop(context),
                        //             style: ButtonStyle(
                        //                 backgroundColor:
                        //                     MaterialStatePropertyAll(
                        //                         Colors.deepPurple[100])),
                        //             child: const Text(
                        //               " Register",
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     );
                        //   },
                        //   child: const Text("Register For Event "),
                        // )
                      ],
                    ),
                  );
                },
              )
            : const CircularProgressIndicator.adaptive());
  }

  Future<void> _getEvents() async {
    var collection = FirebaseFirestore.instance.collection('events');
    var data = await collection.get();

    late List<Map<String, dynamic>> tempList = [];
    data.docs.forEach((element) {
      tempList.add(element.data());
    });
    setState(() {
      events = tempList;
      isLoaded = true;
    });
  }

  void deleteEvent(int index) async {
    // QuerySnapshot snapshot = await FirebaseFirestore.instance
    //     .collection('credentials')
    //     .where(
    //       'phonenumber', isEqualTo: events[index]['uuid']
    //     )
    //     .get();

    // setState(() {
    //   events.removeAt(index);
    // });
  }

  // void _deleteEvent() {
  // }
}
