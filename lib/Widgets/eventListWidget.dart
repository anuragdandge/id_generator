// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class EventListWidget extends StatelessWidget {
//   final String? eventTitle;
//   EventListWidget({
//     Key? key,
//     required this.eventTitle,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.all(16.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//           color: Colors.deepPurple[100],
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             eventTitle!,
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Divider(
//             color: Colors.black,
//             thickness: 2,
//           ),
//           const Text(
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt , adipiscing elit, sed do eiusmod tempor incididunt adipiscing elit, sed do eiusmod tempor incididuntadipiscing elit, sed do eiusmod tempor incididunt",
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text(
//             "Date",
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   " From Date ",
//                   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//                 ),
//                 Text(
//                   " To  Date ",
//                   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text(
//             "Timing ",
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   " From Time  ",
//                   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//                 ),
//                 Text(
//                   " To Time  ",
//                   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text(
//             "Location ",
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const Text(
//             " Address  ",
//             style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//           ),
//           ElevatedButton(
//               onPressed: () {}, child: const Text("Register For Event "))
//         ],
//       ),
//     );
//   }
// }
