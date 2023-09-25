// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:id_generator/pages/login.dart';
import 'package:id_generator/pages/student_home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

final List<String> bloodGroups = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];

class _SignupState extends State<Signup> {
  late Size mediaSize;
  late Color myColor;
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController academicYear = TextEditingController();
  TextEditingController emergencyNumber = TextEditingController();
  TextEditingController localAddress = TextEditingController();
  TextEditingController rollNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  bool rememberUser = false;
  String uuid = const Uuid().v4();
  String? _selectedClass;
  String? _selectedGender;
  String? _selectedDivision;
  String? _selectedBloodGroup = bloodGroups.first;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();

    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTop(),
              ),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.login,
            size: 100,
            color: Colors.deepPurple,
          ),
          Text(
            "Register",
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome ",
                style: TextStyle(
                    color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
              ),
              _buildGreyText("Signup with your Information"),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: _selectPassportPhoto(),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Full Name ';
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                controller: fullNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(" Full Name "),
                    hintText: "Baburao Ganpatrao Aapte ",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Date of Birth ';
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
                controller: dateOfBirth,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "dd/mm/yyyy",
                    label: Text(" Date OF Birth  "),
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Academic Year ';
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
                controller: academicYear,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "2024",
                    label: Text(" Academic Year  "),
                    prefixIcon: Icon(
                      Icons.school_outlined,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone Number ';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "9145369999",
                    label: Text(" Phone Number "),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Emergency Number ';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                controller: emergencyNumber,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "9145369999",
                    label: Text(" Emergency Phone Number "),
                    prefixIcon: Icon(
                      Icons.contact_emergency,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Address ';
                  }
                  return null;
                },
                keyboardType: TextInputType.streetAddress,
                controller: localAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Karve Nagar ,2nd Floor ,  Flat no. 30 ",
                    label: Text(" Local Address "),
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Roll Number ';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: rollNumber,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "51112",
                    label: Text("Roll Number "),
                    prefixIcon: Icon(
                      Icons.pin,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 10),
              _buildClassChoiceChip(),
              const SizedBox(height: 10),
              _buildDivChoiceChip(),
              const SizedBox(height: 10),
              _buildBloodGroupDropDown(),
              const SizedBox(height: 10),
              _buildGenderChoiceChip(),
              const SizedBox(height: 10),
              TextFormField(
                maxLength: 12,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password ';
                  } else {
                    bool result = validatePassword(value);
                    if (result) {
                      // create account event
                      return null;
                    } else {
                      return " Password should contain Capital, small letter & Number & Special";
                    }
                  }
                },
                keyboardType: TextInputType.visiblePassword,
                controller: password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Abc#123",
                    label: Text("Password "),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.deepPurple,
                    )),
              ),
              const SizedBox(height: 30),
              _buildSignupButton(),
              const SizedBox(height: 30),
              _buildLogin(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectPassportPhoto() {
    if (_selectedImage != null) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            right: -10,
            top: -10,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = null;
                  });
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                )),
          )
        ],
      );
    } else {
      return IconButton(
        // splashColor: null,
        icon: const Icon(
          Icons.add_a_photo,
          size: 50,
          color: Colors.deepPurple,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return _buildAlertDialog();
              });
        },
      );

      // return GestureDetector(
      //     onTap: () => showDialog(
      //         context: context,
      //         builder: (context) {
      //           return _buildAlertDialog();
      //         }),
      //     child: SvgPicture.asset(
      //       './assets/images/emptyProfile.svg',
      //     ));
      // return FilledButton(
      //     onPressed: () => showDialog(
      //         context: context,
      //         builder: (context) {
      //           return _buildAlertDialog();
      //         }),
      //     child: Image.asset('./assets/images/emptyProfile.png'));
      // return Container(

      //   child: Image.asset('./assets/images/emptyProfile.png'),
      // );
    }
  }

  Widget _alertDialogForNoConnectivity() {
    return AlertDialog(
      title: Text("No Internet Connectivity !!! "),
    );
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: const Text("Select Image "),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    iconColor:
                        MaterialStatePropertyAll(Colors.deepPurple[400])),
                onPressed: _pickImageFromCamera,
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 20),
                    Text("Camera ",
                        style: TextStyle(color: Colors.deepPurple[400])),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    iconColor:
                        MaterialStatePropertyAll(Colors.deepPurple[400])),
                onPressed: _pickImageFromGallery,
                child: Row(
                  children: [
                    Icon(Icons.upload_file),
                    SizedBox(width: 20),
                    Text("Gallery ",
                        style: TextStyle(color: Colors.deepPurple[400]))
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Close",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
        onPressed: () async {
          var connectivityResult = await Connectivity().checkConnectivity();

          if (connectivityResult == ConnectivityResult.none) {
            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                builder: (context) {
                  return _alertDialogForNoConnectivity();
                });
          } else {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              _generateNewUuid();
              CollectionReference collRef =
                  FirebaseFirestore.instance.collection('students');
              collRef.add({
                'fullname': fullNameController.text,
                'uuid': uuid,
                'phonenumber': phoneController.text,
                'password': password.text,
                'emergencynumber': emergencyNumber.text,
                'division': _selectedDivision,
                'bloodgroup': _selectedBloodGroup,
                'class': _selectedClass,
                'gender': _selectedGender,
                'dateofbirth': dateOfBirth.text,
                'academicyear': academicYear.text,
                'localaddress': localAddress.text,
                'rollnumber': rollNumber.text,
              });
            }
            _signup();
            uploadImage();
            // ignore: use_build_context_synchronously
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => StudentQR(
            //               data: uuid,
            //               file: _selectedImage!,
            //               name: fullNameController.text,
            //               phone: phoneController.text,
            //             )));
            setState(() {
              Get.to(StudentQR(
                data: uuid,
                file: _selectedImage!,
                name: fullNameController.text,
                phone: phoneController.text,
              ));
            });
          }

          // if (_formKey.currentState!.validate()) {
          // ignore: use_build_context_synchronously
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Processing Data')),
          // );
          // _generateNewUuid();
          // CollectionReference collRef =
          //     FirebaseFirestore.instance.collection('students');
          // collRef.add({
          //   'fullname': fullNameController.text,
          //   'uuid': uuid,
          //   'phonenumber': phoneController.text,
          //   'password': password.text,
          //   'emergencynumber': emergencyNumber.text,
          //   'division': _selectedDivision,
          //   'bloodgroup': _selectedBloodGroup,
          //   'class': _selectedClass,
          //   'gender': _selectedGender,
          //   'dateofbirth': dateOfBirth.text,
          //   'academicyear': academicYear.text,
          //   'localaddress': localAddress.text,
          //   'rollnumber': rollNumber.text,
          // });
          // }
          debugPrint("UUID  :  ${uuid.toString()}");
          debugPrint("Entered Full Name  :  ${fullNameController.text}");
          debugPrint("DOB  :  ${dateOfBirth.text}");
          debugPrint("AY  :  ${academicYear.text}");
          debugPrint("Phone Number   :  ${phoneController.text}");
          debugPrint("Emergency Phone Number   :  ${emergencyNumber.text}");
          debugPrint("local Address   :  ${localAddress.text}");
          debugPrint("Roll Number   :  ${rollNumber.text}");
          debugPrint("Selected Class :  $_selectedClass");
          debugPrint("Selected Gender:  $_selectedGender");
          debugPrint("Selected Blood Group  :  $_selectedBloodGroup");
          debugPrint("Passport Photo Location:  $_selectedImage");
          debugPrint("Password:  ${password.text}");
          // _signup();
          // uploadImage();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => StudentQR(
          //               data: uuid,
          //               file: _selectedImage!,
          //               name: fullNameController.text,
          //               phone: phoneController.text,
          //             )));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: myColor,
            shape: const StadiumBorder(),
            elevation: 20,
            shadowColor: Colors.deepPurple,
            minimumSize: const Size.fromHeight(60)),
        child: const Text(
          "Signup",
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildLogin() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGreyText("Already have an account ? "),
          ElevatedButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                });
              },
              child: const Text(
                "Login Here ",
                style: TextStyle(color: Colors.deepPurple),
              )),
        ],
      ),
    );
  }

  Widget _buildClassChoiceChip() {
    return Container(
      child: Wrap(spacing: 5.0, children: <Widget>[
        _buildChoiceChip_Class("FYMCA"),
        const SizedBox(width: 10),
        _buildChoiceChip_Class("SYMCA")
      ]),
    );
  }

  Widget _buildGenderChoiceChip() {
    return Wrap(spacing: 5.0, children: <Widget>[
      _buildChoiceChip_Gender("Male "),
      const SizedBox(width: 10),
      _buildChoiceChip_Gender("Female ")
    ]);
  }

  Widget _buildDivChoiceChip() {
    return Wrap(spacing: 5.0, children: <Widget>[
      _buildChoiceChip_Div("A"),
      const SizedBox(width: 10),
      _buildChoiceChip_Div("B")
    ]);
  }

  Widget _buildChoiceChip_Class(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedClass == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedClass = selected ? label : null;
        });
      },
    );
  }

  Widget _buildChoiceChip_Gender(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedGender == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedGender = selected ? label : null;
        });
      },
    );
  }

  Widget _buildChoiceChip_Div(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedDivision == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedDivision = selected ? label : null;
        });
      },
    );
  }

  Widget _buildBloodGroupDropDown() {
    return DropdownMenu<String>(
      initialSelection: bloodGroups.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          _selectedBloodGroup = value!;
        });
      },
      leadingIcon: const Icon(Icons.bloodtype),
      label: const Text(" Blood Type "),
      dropdownMenuEntries:
          bloodGroups.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  void _generateNewUuid() {
    setState(() {
      uuid = const Uuid().v4(); // Generate a new random UUID
    });
  }

  void _signup() {
    // setPreferance();
    // setState(() {
    //   Get.to(() => const StudentQR());
    // });
  }

  uploadImage() async {
    var firebaseStorage = FirebaseStorage.instance.ref("$uuid");
    if (_selectedImage != null) {
      await firebaseStorage.putFile(_selectedImage!);
    } else {
      showDialog(
          context: context,
          builder: ((context) => const AlertDialog(
                title: Text("Select Profile Photo "),
              )));
    }
    var url = firebaseStorage.getDownloadURL();
    debugPrint("$url");
  }
}
