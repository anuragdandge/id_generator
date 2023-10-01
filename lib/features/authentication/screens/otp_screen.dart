// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:id_generator/features/authentication/controllers/otp_controller.dart';
// import 'package:id_generator/src/repository/authentication_repository/authentication_repository.dart';

// class OTPScreen extends StatefulWidget {
//   const OTPScreen({super.key});

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   var otp;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         OtpTextField(
//           mainAxisAlignment: MainAxisAlignment.center,
//           numberOfFields: 6,
//           fillColor: Colors.black.withOpacity(0.1),
//           onSubmit: (code) {
//             otp = code;
//             Get.put(OTPController().verifyOTP(otp));
//             debugPrint("OTP is $otp");
//           },
//         ),
//         ElevatedButton(
//             onPressed: () {
//               OTPController().verifyOTP(otp);
//             },
//             child: const Text("Verify OTP "))
//       ]),
//     );
//   }
// }
