// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:id_generator/animations/shake-widget.dart';
import 'package:id_generator/pages/signup.dart';
import 'package:id_generator/pages/student_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});
  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  late Size mediaSize;
  late Color myColor;
  TextEditingController phoneController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();
  String smsCode = "";
  bool rememberUser = false;
  final _formKey = GlobalKey<FormState>();
  final shakeKey = GlobalKey<ShakeWidgetState>();

  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp phoneValid = RegExp(r"^\+?[0-9]{10,12}$");

  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePhoneNumber(String phone) {
    String phoneNumber = phone.trim();

    if (phoneValid.hasMatch(phoneNumber)) {
      return true;
    } else {
      return false;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _verifyPhoneNumber(String phone) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone.trim(),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              debugPrint("verificationCompleted...");
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const StudentHome(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            });
          },
          verificationFailed: (((error) {
            print("Verification Failed  $error");
            debugPrint("verificationFailed !!! ");
          })),
          codeSent: (String verificationId, [int? forceResendingToken]) {
            debugPrint("CodeSent...");

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                      title: const Text("Enter OTP"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _codeController,
                          )
                          // OtpTextField(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   numberOfFields: 6,
                          //   fillColor: Colors.black.withOpacity(0.1),
                          //   handleControllers: (controllers) => _codeController,
                          // ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              smsCode = _codeController.text;
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: smsCode);
                              auth
                                  .signInWithCredential(credential)
                                  .then((value) {
                                if (value != null) {
                                  Navigator.pop((context));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Signup()));
                                }
                              }).catchError((e) {
                                print(e);
                              });
                            },
                            child: const Text("Submit "))
                      ],
                    ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
            debugPrint("CodeAutoRetrieval...");
          },
          timeout: const Duration(seconds: 45));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = Theme.of(context).primaryColor;
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.deepPurple[400],
    //     title: const Text(
    //       "Verify Phone Number ",
    //       style: TextStyle(fontSize: 30, color: Colors.white),
    //     ),
    //   ),
    //   body: SafeArea(child: _buildBottom()),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: const Text(
          "Verify Phone Number",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShakeWidget(
                  key: shakeKey,
                  shakeOffset: 10,
                  shakeCount: 3,
                  shakeDuration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "9145369970",
                          labelText: "Phone Number",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Phone Number';
                          } else {
                            bool result = validatePhoneNumber(value);
                            if (result) {
                              return null;
                            } else {
                              return "Enter Number like +91*****";
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _verifyPhoneNumber("+91${phoneController.text}");
                        } else {
                          shakeKey.currentState?.shake();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(110, 30),
                        backgroundColor: myColor,
                        shape: const StadiumBorder(),
                        elevation: 10,
                        shadowColor: Colors.deepPurple,
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(
                            Icons.arrow_right_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShakeWidget(
              key: shakeKey,
              shakeOffset: 10,
              shakeCount: 3,
              shakeDuration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "9145369970",
                        label: Text(" Phone Number "),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Phone Number ';
                      } else {
                        bool result = validatePhoneNumber(value);
                        if (result) {
                          return null;
                        } else {
                          return "Enter Number like +91*****";
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )),
          Positioned(right: 0, child: _buildLoginButton()),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () async {
          // If the form is valid, display a snackbar. In the real world,
          if (_formKey.currentState!.validate()) {
            _verifyPhoneNumber("+91${phoneController.text}");
          } else {
            shakeKey.currentState?.shake();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: myColor,
          shape: const StadiumBorder(),
          elevation: 10,
          shadowColor: Colors.deepPurple,
          // minimumSize: const Size.fromHeight(60)
        ),
        child: const SizedBox(
          width: 65,
          child: Row(
            children: [
              Text(
                "Next ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Icon(
                Icons.arrow_right_outlined,
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:id_generator/animations/shake-widget.dart';
// import 'package:id_generator/pages/signup.dart';
// import 'package:id_generator/pages/student_home.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class VerifyPhoneScreen extends StatefulWidget {
//   const VerifyPhoneScreen({Key? key}) : super(key: key);

//   @override
//   _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
// }

// class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
//   late Size mediaSize;
//   late Color myColor;
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();
//   String smsCode = "";
//   final _formKey = GlobalKey<FormState>();
//   final shakeKey = GlobalKey<ShakeWidgetState>();

//   final RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
//   final RegExp phoneValid = RegExp(r"^\+?[0-9]{10,12}$");

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   bool validatePassword(String pass) {
//     String password = pass.trim();
//     return passValid.hasMatch(password);
//   }

//   bool validatePhoneNumber(String phone) {
//     String phoneNumber = phone.trim();
//     return phoneValid.hasMatch(phoneNumber);
//   }

//   void _verifyPhoneNumber(String phone) async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phone.trim(),
//         verificationCompleted: (PhoneAuthCredential authCredential) async {
//           await _auth.signInWithCredential(authCredential).then((value) {
//             debugPrint("verificationCompleted...");
//             Navigator.push(
//               context,
//               PageRouteBuilder(
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     StudentHome(),
//                 transitionsBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   return SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(1.0, 0.0),
//                       end: Offset.zero,
//                     ).animate(animation),
//                     child: child,
//                   );
//                 },
//               ),
//             );
//           });
//         },
//         verificationFailed: (error) {
//           print("Verification Failed: $error");
//           debugPrint("verificationFailed !!!");
//         },
//         codeSent: (String verificationId, [int? forceResendingToken]) {
//           debugPrint("CodeSent...");

//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) => AlertDialog(
//               title: const Text("Enter OTP"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     controller: _codeController,
//                   ),
//                 ],
//               ),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () {
//                     FirebaseAuth auth = FirebaseAuth.instance;
//                     smsCode = _codeController.text;
//                     PhoneAuthCredential _credential =
//                         PhoneAuthProvider.credential(
//                       verificationId: verificationId,
//                       smsCode: smsCode,
//                     );
//                     auth.signInWithCredential(_credential).then((value) {
//                       if (value != null) {
//                         Navigator.pop(context);
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Signup()));
//                       }
//                     }).catchError((e) {
//                       print(e);
//                     });
//                   },
//                   child: const Text("Submit "),
//                 )
//               ],
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           verificationId = verificationId;
//           debugPrint("CodeAutoRetrieval...");
//         },
//         timeout: const Duration(seconds: 45),
//       );
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     mediaSize = MediaQuery.of(context).size;
//     myColor = Theme.of(context).primaryColor;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple[400],
//         title: const Text(
//           "Verify Phone Number",
//           style: TextStyle(fontSize: 30, color: Colors.white),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(32.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ShakeWidget(
//                   key: shakeKey,
//                   shakeOffset: 10,
//                   shakeCount: 3,
//                   shakeDuration: const Duration(milliseconds: 500),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         keyboardType: TextInputType.phone,
//                         controller: phoneController,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: "9145369970",
//                           labelText: "Phone Number",
//                           prefixIcon: Icon(
//                             Icons.phone,
//                             color: Colors.deepPurple,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter Phone Number';
//                           } else {
//                             bool result = validatePhoneNumber(value);
//                             if (result) {
//                               return null;
//                             } else {
//                               return "Enter Number like +91*****";
//                             }
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           _verifyPhoneNumber("+91${phoneController.text}");
//                         } else {
//                           shakeKey.currentState?.shake();
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         fixedSize: Size(110, 30),
//                         backgroundColor: myColor,
//                         shape: const StadiumBorder(),
//                         elevation: 10,
//                         shadowColor: Colors.deepPurple,
//                       ),
//                       child: const Row(
//                         children: [
//                           Text(
//                             "Next",
//                             style: TextStyle(color: Colors.white, fontSize: 20),
//                           ),
//                           Icon(
//                             Icons.arrow_right_outlined,
//                             color: Colors.white,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
