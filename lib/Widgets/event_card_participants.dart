import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class EventCardWidget extends StatelessWidget {
  final String eventName;
  final String location;
  final String description;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final VoidCallback onRegister;

  EventCardWidget({
    required this.eventName,
    required this.location,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple[50],
          border: Border.all(
              style: BorderStyle.solid, width: 1, color: Colors.grey)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              'assets/images/abc.jpg',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${DateFormat("EEEE").format(DateFormat("dd-MM-yyyy").parse(startDate))} ${startTime.substring(0, 4)} onwards ",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Animate(
                      effects: const [
                        FlipEffect(
                          curve: Curves.bounceOut,
                          duration: Duration(seconds: 2),
                        ),
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.black45,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(3, 3),
                              blurRadius: 0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                              ),
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                DateFormat("MMM").format(
                                  DateFormat("dd-MM-yyyy").parse(startDate),
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat("d").format(
                                DateFormat("dd-MM-yyyy").parse(startDate),
                              ),
                              style: const TextStyle(
                                  fontSize: 26, color: Colors.deepPurple),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "to",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Animate(
                      effects: const [
                        FlipEffect(
                          curve: Curves.bounceOut,
                          duration: Duration(seconds: 2),
                        ),
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.black45,
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(3, 3),
                              blurRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.deepPurpleAccent),
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                DateFormat("MMM").format(
                                  DateFormat("dd-MM-yyyy").parse(endDate),
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat("d").format(
                                DateFormat("dd-MM-yyyy").parse(endDate),
                              ),
                              style: const TextStyle(
                                  fontSize: 26, color: Colors.deepPurple),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRegister,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
