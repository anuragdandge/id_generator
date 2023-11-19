import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_generator/Widgets/event_card_participants.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    getPrefs();
  }

  final List<String> roles = [
    'Participant',
    'Volunteer',
    'Co-Ordinator',
    'Head Co-Ordinator',
  ];
  // ignore: unused_field
  String? _selectedRole = "Participant";
  late List<Map<String, dynamic>> events = [];
  bool isLoaded = false;
  bool isEditing = false;
  String? uuid;

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
                          return EventCardWidgetParticipant(
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
                                      onPressed: () async {
                                        QuerySnapshot snapshot =
                                            await FirebaseFirestore.instance
                                                .collection('events')
                                                .where('uuid',
                                                    isEqualTo: events[index]
                                                        ['uuid'])
                                                .get();
                                        var id = snapshot.docs[0].id;
                                        CollectionReference collRef =
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'events/$id/participants');
                                        collRef.add(
                                          {'uuid': uuid, 'role': _selectedRole},
                                        );
                                        Navigator.pop(context);
                                      },
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
                            },
                          );
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

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uuid = prefs.getString('uuid');
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
}
