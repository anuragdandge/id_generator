// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, non_constant_identifier_names

import 'package:id_generator/pages/student_home.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/signUpWidgets.dart';
import 'dart:io';
// import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:id_generator/pages/verify_otp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required this.phoneNo});
  final String phoneNo;
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
  // TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  // TextEditingController academicYear = TextEditingController();
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
  String imgUrl = '';
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp fullNameValid =
      RegExp(r"^[a-zA-Z]+(([',\.\-\s][a-zA-Z ])?[a-zA-Z]*)*$");

  //A function that validate user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();

    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  //A function that validate user entered Full Name
  bool validateFullName(String name) {
    String fullName = name.trim();

    if (fullNameValid.hasMatch(fullName)) {
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SignUpWidgets.buildTop(mediaSize),
              // ),
              _buildBottom(),
            ],
          ),
        ),
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
              SignUpWidgets.buildGreyText("Signup with your Information"),
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
                  } else {
                    bool result = validateFullName(value);
                    if (result) {
                      return null;
                    } else {
                      return " Name Should Contain Alphabets Only ";
                    }
                  }
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
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDob = await showDatePicker(
                    helpText: "Date Of Birth  ",
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDob != null) {
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDob);

                    setState(() {
                      dateOfBirth.text =
                          formattedDate; //set output date to TextField value.
                    });
                  }
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
                readOnly: true,
                onTap: () async {
                  DateTime? pickedAy = await showDatePicker(
                    initialDatePickerMode: DatePickerMode.year,
                    helpText: "Academic year ",
                    context: context,
                    initialDate: DateTime(2020),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (pickedAy != null) {
                    String formattedDate = DateFormat('yyyy').format(pickedAy);

                    setState(() {
                      academicYear.text =
                          formattedDate; //set output date to TextField value.
                    });
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "2024",
                  label: Text(" Academic Year  "),
                  prefixIcon: Icon(
                    Icons.school_outlined,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // TextFormField(
              //   maxLength: 10,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter Phone Number ';
              //     }
              //     return null;
              //   },
              //   keyboardType: TextInputType.phone,
              //   controller: phoneController,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: "9145369999",
              //       label: Text(" Phone Number "),
              //       prefixIcon: Icon(
              //         Icons.phone,
              //         color: Colors.deepPurple,
              //       )),
              // ),
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
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: 116,
                height: 116,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    color: Colors.deepPurpleAccent,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        height: 120,
        width: 120,
        child: IconButton(
          // splashColor: null,
          icon: const Icon(
            Icons.add_a_photo,
            size: 60,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return _buildAlertDialog();
                });
          },
        ),
      );
    }
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
                onPressed: () {
                  _pickImageFromCamera();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt),
                    const SizedBox(width: 20),
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
                onPressed: () {
                  _pickImageFromGallery();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.upload_file),
                    const SizedBox(width: 20),
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

  Widget _buildSignupButton() {
    return ElevatedButton(
        onPressed: () async {
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            showDialog(
                context: context,
                builder: (context) {
                  return SignUpWidgets().alertDialogForNoConnectivity();
                });
          } else {
            if (_formKey.currentState!.validate()) {
              _generateNewUuid();
              // await uploadImageToFirebaseStorage();
              Reference storageReference =
                  FirebaseStorage.instance.ref().child('studentsProfile/$uuid');
              UploadTask uploadTask = storageReference.putFile(_selectedImage!);

              // Wait for the upload to complete
              await uploadTask.whenComplete(() => null);

              // Get the download URL
              String downloadURL = await storageReference.getDownloadURL();
              CollectionReference collRef =
                  FirebaseFirestore.instance.collection('students');
              collRef.add(
                {
                  'fullname': fullNameController.text,
                  'uuid': uuid,
                  'profileUrl': downloadURL,
                  'phonenumber': widget.phoneNo,
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
                  'verified': 'false',
                  'registeredAt': DateTime.now(),
                },
              );
              CollectionReference credRef =
                  FirebaseFirestore.instance.collection('credentials');
              credRef.add(
                {
                  'phonenumber': widget.phoneNo.substring(3),
                  'password': password.text,
                  'uuid': uuid,
                },
              );
            }
            // _signup();
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
            await prefs.setString("uuid", uuid);
            await prefs.setString("phone", widget.phoneNo);
            await prefs.setString("name", fullNameController.text);
            setState(() {
              // Navigator.pop(context);
              if (_selectedImage == null) {
                showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          title: const Text("Select Profile Photo "),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Close"))
                          ],
                        )));
              } else {
                // uploadImage();
                Navigator.pop(context);
                Get.to(() => const StudentHome());
              }
            });
          }
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
          SignUpWidgets.buildGreyText("Already have an account ? "),
          ElevatedButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0),
              onPressed: () {
                setState(() {
                  Get.to(() => const VerifyPhoneScreen());
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

  Future uploadImage() async {
    if (_selectedImage == null) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text("Select Profile Photo "),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"))
                ],
              )));
    } else {
      var firebaseStorage = FirebaseStorage.instance.ref('students/$uuid');
      UploadTask uploadTask = firebaseStorage.putFile(_selectedImage!);
      await uploadTask.whenComplete(() => null);
      String downloadURL = await firebaseStorage.getDownloadURL();
      setState(() {
        imgUrl = downloadURL;
      });
    }
  }

  // Future<String> uploadImageToFirebaseStorage() async {
  //   Reference storageReference =
  //       FirebaseStorage.instance.ref().child('students/$uuid');
  //   UploadTask uploadTask = storageReference.putFile(File(uuid));

  //   // Wait for the upload to complete
  //   await uploadTask.whenComplete(() => null);

  //   // Get the download URL
  //   String downloadURL = await storageReference.getDownloadURL();

  //   return downloadURL;
  // }
}
