import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/admin/viewEvents.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController eventTitle = TextEditingController();
  TextEditingController eventDescription = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  DateTime _selectedStartTime = DateTime.now();
  DateTime _selectedEndTime = DateTime.now().add(const Duration(hours: 1));
  TextEditingController address = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    startDate.text = "";
    endDate.text = "";
    super.initState();
  }

  Future<void> _selectTime(BuildContext context, String time, String startOrEnd,
      TimeOfDay initTime) async {
    TimeOfDay? selectedTime = await showTimePicker(
        helpText: startOrEnd, context: context, initialTime: initTime);

    if (selectedTime != null) {
      final newTime = DateTime(
        _selectedStartTime.year,
        _selectedStartTime.month,
        _selectedStartTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      if (time == "startTime") {
        startTime.text = DateFormat.jm().format(newTime);
        // setState(() {

        // });
      } else if (time == "endTime") {
        setState(() {
          endTime.text = DateFormat.jm().format(newTime);
          _selectedEndTime = newTime;
          // DateTime sixHoursFromNow =
          //     _selectedEndTime.add(const Duration(hours: 6));
          if (_selectedEndTime.isBefore(_selectedStartTime)) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.red[100],
                title: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded),
                    Text("Warning !!!"),
                  ],
                ),
                content:
                    const Text(" End Time Should be Greater than 6 hours "),
              ),
            );
          }
        });
      }

      //   setState(() {
      //     _selectedTime = newTime;
      //     if (time == "startTime") {
      //       startTime.text = DateFormat.jm().format(newTime);
      //     } else if (time == "endTime") {

      //       endTime.text = DateFormat.jm().format(newTime);
      //     }
      //   });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 186, 255),
        title: const Text(
          " Create Event ",
          style: TextStyle(
            fontSize: 30,
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: eventTitle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Title  ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                    label: Text(
                      "Event Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 62, 22, 131),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Address ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(),
                    label: Text(
                      "Event Address ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 62, 22, 131),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description ';
                    }
                    return null;
                  },
                  controller: eventDescription,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                    label: Text(
                      "Event Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 62, 22, 131),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 226, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        style: BorderStyle.solid, width: 1, color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Dates",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            Icon(
                              Icons.calendar_month,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 140,
                              child: TextFormField(
                                controller: startDate,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ' Event Start Time  ';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    helpText: "Event Starting Date ",
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    print(
                                        "$pickedDate.month.toString() $pickedDate.day $pickedDate.year");
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    print(formattedDate);
                                    setState(() {
                                      startDate.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Start Date "),
                              ),
                            ),
                            const Icon(Icons.sync_alt),
                            SizedBox(
                              width: 140,
                              child: TextFormField(
                                controller: endDate,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ' Event End Date ';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      helpText: "Event Ending Date ",
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    print(formattedDate);
                                    setState(() {
                                      endDate.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "End Date "),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
// -------------------------------------------------------------------------------------------------------------
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // boxShadow: const <BoxShadow>[
                    //   BoxShadow(
                    //       color: Colors.grey,
                    //       offset: Offset(2, 8),
                    //       spreadRadius: -2,
                    //       blurRadius: 10)
                    // ],
                    color: const Color.fromARGB(255, 241, 226, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        style: BorderStyle.solid, width: 1, color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Timings ",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            Icon(
                              Icons.access_time,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 140,
                              child: TextFormField(
                                controller: startTime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ' Event Start Time';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () => _selectTime(
                                  context,
                                  "startTime",
                                  " Event Starting Time ",
                                  TimeOfDay.now(),
                                ),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Start Time"),
                              ),
                            ),
                            const Icon(Icons.sync_alt),
                            SizedBox(
                              width: 140,
                              child: TextFormField(
                                controller: endTime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Event End Time';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                onTap: () => _selectTime(
                                  context,
                                  "endTime",
                                  "Event Ending Time ",
                                  TimeOfDay.fromDateTime(
                                    DateTime.now().add(
                                      const Duration(hours: 3),
                                    ),
                                  ),
                                ),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "End Time "),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // showDialog(
          //   // barrierDismissible: false,
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     title: const Text("Event Added "),
          //     content: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Image.asset(
          //           'assets/images/eventAdded.png',
          //         ),
          //         Row(
          //           children: [
          //             ElevatedButton(
          //                 onPressed: () {}, child: const Text("View Events "))
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // );
          if (_formKey.currentState!.validate()) {
            CollectionReference collRef =
                FirebaseFirestore.instance.collection('events');
            collRef.add({
              'uuid': const Uuid().v4(),
              'eventTitle': eventTitle.text,
              'eventDescription': eventDescription.text,
              'eventStartDate': startDate.text,
              'eventEndDate': endDate.text,
              'eventStartTime': startTime.text,
              'eventEndTime': endTime.text,
              'eventAddress': address.text,
            });
            Navigator.pop(context);
            Get.to(
              () => const ViewEvents(),
            );
          }
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 48,
        ),
      ),
    );
  }

  // Future<void> _selectTime(
  //     BuildContext context, String time, String startOrEnd) async {
  //   TimeOfDay initialTime = TimeOfDay.fromDateTime(_selectedTime);
  //   TimeOfDay? selectedTime = await showTimePicker(
  //     helpText: startOrEnd,
  //     context: context,
  //     initialTime: initialTime,
  //   );

  //   if (selectedTime != null) {
  //     final newTime = DateTime(
  //       _selectedTime.year,
  //       _selectedTime.month,
  //       _selectedTime.day,
  //       selectedTime.hour,
  //       selectedTime.minute,
  //     );

  //     setState(() {
  //       _selectedTime = newTime;
  //       if (time == "startTime") {
  //         startTime.text = DateFormat.jm().format(newTime);
  //       } else if (time == "endTime") {
  //         endTime.text = DateFormat.jm().format(newTime);
  //       }
  //     });
  //   }
  // }
}
