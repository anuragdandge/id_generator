// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:id_generator/animations/shake-widget.dart';
import 'package:id_generator/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
    debugPrint(" Phone Number Entered  ");
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone.trim(),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              debugPrint("verificationCompleted...");
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
                              keyboardType: TextInputType.number)
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              debugPrint("OTP Entered !!!");
                              FirebaseAuth auth = FirebaseAuth.instance;
                              smsCode = _codeController.text;
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: smsCode);
                              auth
                                  .signInWithCredential(credential)
                                  .then((value) {
                                // ignore: unnecessary_null_comparison
                                if (value != null) {
                                  Navigator.pop((context));
                                  debugPrint("Verification Completed !!!");
                                  Get.to(() => Signup(
                                        phoneNo: phone,
                                      ));
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
                          QuerySnapshot snapshot = await FirebaseFirestore
                              .instance
                              .collection('students')
                              .where('phonenumber',
                                  isEqualTo: phoneController.text)
                              .get();
                          if (snapshot.docs.isNotEmpty) {
                            for (QueryDocumentSnapshot document
                                in snapshot.docs) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              // String uuid = data['uuid'];
                              debugPrint(
                                  "User Already Exists in Database with UUID : ${data['uuid']}");
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                  title: Text("User Already Exists  "),
                                ),
                              );
                              // academicyear "2525"
                              // bloodgroup "O+"
                              // class "SYMCA"
                              // dateofbirth "031001"
                              // division "B"
                              // emergencynumber "9145369975"
                              // fullname "Anurag "
                              // gender "Male "
                              // localaddress "abc"
                              // password "Aa@1"
                              // phonenumber "+919145369970"
                              // rollnumber "52112"
                              // uuid "2c763a8b-4b0a-4fc6-a1ef-446c0186fc5b"

                              // if (passwordController.text != password) {
                              //   // ignore: use_build_context_synchronously
                              //   showDialog(
                              //     context: context,
                              //     builder: (context) => const AlertDialog(
                              //       title: Text("Password Not Matched "),
                              //     ),
                              //   );
                              // } else {
                              //   final SharedPreferences prefs =
                              //       await SharedPreferences.getInstance();
                              //   await prefs.setBool('isLoggedIn', true);
                              //   debugPrint(" User Logged In !!!");
                              //   // ignore: use_build_context_synchronously
                              //   Navigator.pop(context);
                              //   Get.to(() => const StudentHome());
                              // }
                            }
                          } else {
                            _verifyPhoneNumber("+91${phoneController.text}");
                          }
                        } else {
                          shakeKey.currentState?.shake();
                        }
                      },
                      style: ElevatedButton.styleFrom(
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
