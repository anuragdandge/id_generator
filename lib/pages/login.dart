import 'package:flutter/material.dart';
import 'package:id_generator/animations/shake-widget.dart';
import 'package:id_generator/pages/signup.dart';
import 'package:id_generator/pages/student_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Size mediaSize;
  late Color myColor;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
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

  _signInWithMobileNumber(String phone) async {
    UserCredential _credentials;
    User user;
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone.trim(),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudentHome()));
            });
          },
          verificationFailed: (((error) {
            print(error);
          })),
          codeSent: (String verificationId, [int? forceResendingToken]) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                      title: Text("Enter OTP"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _codeController,
                          )
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              smsCode = _codeController.text;
                              PhoneAuthCredential _credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: smsCode);
                              auth
                                  .signInWithCredential(_credential)
                                  .then((value) {
                                if (value != null) {
                                  Navigator.pop((context));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));
                                }
                              }).catchError((e) {
                                print(e);
                              });
                            },
                            child: Text("Submit "))
                      ],
                    ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
          timeout: Duration(seconds: 45));
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
          "Verify Phone Number ",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: SafeArea(child: _buildBottom()),
    );
  }

  // Widget _buildTop() {
  //   return SizedBox(
  //     width: mediaSize.width,
  //     child: const Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(
  //           Icons.login,
  //           size: 100,
  //           color: Colors.deepPurple,
  //         ),
  //         Text(
  //           "Login",
  //           style: TextStyle(
  //               color: Colors.deepPurple,
  //               fontSize: 40,
  //               fontWeight: FontWeight.bold),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
                        hintText: "+919145369970",
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
                  // TextFormField(
                  //   maxLength: 12,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please Enter Password ';
                  //     } else {
                  //       bool result = validatePassword(value);
                  //       if (result) {
                  //         return null;
                  //       } else {
                  //         return " Password should contain Capital, small letter & Number & Special";
                  //       }
                  //     }
                  //   },
                  //   keyboardType: TextInputType.visiblePassword,
                  //   controller: passwordController,
                  //   decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: "Abc#123",
                  //       label: Text("Password "),
                  //       prefixIcon: Icon(
                  //         Icons.lock,
                  //         color: Colors.deepPurple,
                  //       )),
                  // ),
                ],
              )),

          Positioned(right: 0, child: _buildLoginButton()),

          // _buildRegister(),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(
      TextEditingController controller, String label, int ml, TextInputType tit,
      {isPassword = false}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Provide Credential  ';
        }
        return null;
      },
      controller: controller,
      maxLength: 10,
      keyboardType: tit,
      decoration: InputDecoration(
          suffixIcon: isPassword
              ? const Icon(Icons.remove_red_eye)
              : const Icon(Icons.done),
          border: const OutlineInputBorder(),
          label: Text(label)),
      obscureText: isPassword,
    );
  }

  // Widget _buildRememberForgot() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           Checkbox(
  //               value: rememberUser,
  //               onChanged: (value) {
  //                 setState(() {
  //                   rememberUser = value!;
  //                 });
  //               }),
  //           _buildGreyText("Remember me ")
  //         ],
  //       ),
  //       TextButton(onPressed: () {}, child: _buildGreyText("Forgot Password"))
  //     ],
  //   );
  // }

  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () async {
          // If the form is valid, display a snackbar. In the real world,
          if (_formKey.currentState!.validate()) {
            debugPrint("Email ${phoneController.text}");
            debugPrint("Password ${passwordController.text}");
            // MongoDatabase()
            //     .checkCreds(phoneController.text, passwordController.text);
            // AuthenticationRepository()
            //     .phoneAuthentication(phoneController.text.trim());
            // Get.to(() => const OTPScreen());
            _signInWithMobileNumber("+91${phoneController.text}");
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

  // Widget _buildRegister() {
  //   return Center(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         _buildGreyText("Don't have an account? "),
  //         TextButton(
  //             style: TextButton.styleFrom(padding: EdgeInsets.zero),
  //             onPressed: () {
  //               setState(() {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => const Signup()));
  //               });
  //             },
  //             child: const Text(
  //               "Register Here ",
  //               style: TextStyle(color: Colors.deepPurple),
  //             ))
  //       ],
  //     ),
  //   );
  // }
}
