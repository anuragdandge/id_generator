import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../animations/slideRight.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  TextEditingController eventTitle = TextEditingController();
  TextEditingController eventDescription = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  DateTime _selectedTime = DateTime.now();

  @override
  void initState() {
    startDate.text = ""; //set the initial value of text field
    endDate.text = ""; //set the initial value of text field
    super.initState();
  }

  Future<void> _selectTime(BuildContext context, String time) async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(_selectedTime);
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (selectedTime != null) {
      final newTime = DateTime(
        _selectedTime.year,
        _selectedTime.month,
        _selectedTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      setState(() {
        _selectedTime = newTime;
        if (time == "startTime") {
          startTime.text = DateFormat.jm().format(newTime);
        } else if (time == "endTime") {
          endTime.text = DateFormat.jm().format(newTime);
        }
      });
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
            fontSize: 40,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Event Title",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 62, 22, 131),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Event Description",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
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
                      borderRadius: BorderRadius.circular(20)),
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
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextField(
                                controller: startDate,
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
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
                            SizedBox(
                              width: 150,
                              child: TextField(
                                controller: endDate,
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
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
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 8),
                            spreadRadius: -2,
                            blurRadius: 10)
                      ],
                      color: const Color.fromARGB(255, 241, 226, 255),
                      borderRadius: BorderRadius.circular(5)),
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
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextField(
                                controller: startTime,
                                readOnly: true,
                                onTap: () => _selectTime(context, "startTime"),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "From Time"),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                controller: endTime,
                                readOnly: true,
                                onTap: () => _selectTime(context, "endTime"),
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
                const SizedBox(
                  height: 40,
                ),
                // ElevatedButton(
                //   style: ButtonStyle(
                //     shape: MaterialStatePropertyAll(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //     ),
                //     elevation: MaterialStatePropertyAll(20),
                //     foregroundColor: MaterialStatePropertyAll(Colors.white),
                //     backgroundColor: const MaterialStatePropertyAll(
                //         Color.fromARGB(255, 160, 105, 199)),
                //     minimumSize:
                //         const MaterialStatePropertyAll(Size.fromHeight(50.0)),
                //   ),
                //   onPressed: () {
                //     const SnackBar(
                //       content: Text(" Event Created !!! "),
                //     );
                //   },
                //   child: const Text(
                //     " Create Event ",
                //     style: TextStyle(fontSize: 25),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 48,
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}
