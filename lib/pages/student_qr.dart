// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:id_generator/pages/verify_otp.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// import 'login.dart';

// class StudentQR extends StatelessWidget {
//   // final String data;
//   // final String phone;
//   // final String name;
//   // final File file;

//   StudentQR({
//     Key? key,
//     // required this.data,
//     // required this.file,
//     // required this.name,
//     // required this.phone
//   }) : super(key: key);

//   String uuid = "";
//   String phoneNo = "";
//   String fullName = "";
//   String url = "";

//   getData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     uuid = prefs.getString('uuid')!;
//     final ref = FirebaseStorage.instance
//         .ref()
//         .child("1512e538-d558-4f9d-947c-38a0227b32bc");
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('credentials')
//         .where('uuid', isEqualTo: uuid)
//         .get();
//     url = await ref.getDownloadURL();
//     debugPrint(url);
//     if (snapshot.docs.isNotEmpty) {
//       for (QueryDocumentSnapshot document in snapshot.docs) {
//         Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//         fullName = data['fullname'];
//         phoneNo = data['phonenumber'];
//       }
//     } else {
//       // ignore: use_build_context_synchronously
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple[50],
//       appBar: AppBar(
//         title: const Text("Welcome "),
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: SizedBox(
//           width: double.infinity,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 height: 370,
//                 width: 370,
//                 decoration: BoxDecoration(color: Colors.deepPurple[100]),
//                 child: QrImageView(
//                   data: uuid,
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 150,
//                 margin: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     color: Colors.deepPurple[100],
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 150,
//                       width: 150,
//                       padding: const EdgeInsets.all(20),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           url,
//                           scale: 1.0,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 110,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                               child: Text(
//                             fullName,
//                             // "Anurag Dandge",
//                             style: const TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.bold),
//                           )),
//                           Container(child: Text(phoneNo)),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               TextButton(
//                   onPressed: () async {
//                     Get.to(() => const LoginScreen());
//                     final SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     await prefs.setBool('isLoggedIn', false);
//                     debugPrint("User Logged Out ");
//                   },
//                   child: const Text("Logout"))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentQR extends StatefulWidget {
  const StudentQR({Key? key}) : super(key: key);

  @override
  State<StudentQR> createState() => _StudentQRState();
}

class _StudentQRState extends State<StudentQR> {
  String imgUrl = '';
  final storage = FirebaseStorage.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgUrl = '';
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('uuid');
    final ref = storage.ref().child(uuid!);
    final url = await ref.getDownloadURL();
    setState(() {
      imgUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome "),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);
                debugPrint(" Logged Out ");
                Navigator.pop(context);
                Get.to(() => const LoginScreen());
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    );
  }
}
