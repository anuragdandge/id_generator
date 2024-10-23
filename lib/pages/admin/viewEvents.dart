import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/admin/event_participants.dart';
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
                            onViewParticipants: () async {
                              debugPrint("View Participants ");
                              QuerySnapshot snapshot = await FirebaseFirestore
                                  .instance
                                  .collection('events')
                                  .where('uuid',
                                      isEqualTo: events[index]['uuid'])
                                  .get();
                              var id = snapshot.docs[0].id;
                              Get.to(() => EventParticipants(eventId: id));
                              debugPrint(id);
                            },
                            onDelete: () {
                              deleteEvent(index);
                            },
                            onEdit: () {},
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
      ),
    );
  }
}
