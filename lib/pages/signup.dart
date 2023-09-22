import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

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
  bool rememberUser = false;
  String? _selectedOption;
  String? _selectedBloodGroup = bloodGroups.first;
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = Theme.of(context).primaryColor;
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome ",
              style: TextStyle(
                  color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
            ),
            _buildGreyText("Signup with your Information "),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
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
              keyboardType: TextInputType.datetime,
              controller: fullNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "01/01/2000",
                  label: Text(" Date OF Birth  "),
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Colors.deepPurple,
                  )),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.datetime,
              controller: fullNameController,
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
              keyboardType: TextInputType.phone,
              controller: phoneController,
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
              keyboardType: TextInputType.streetAddress,
              controller: phoneController,
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
              keyboardType: TextInputType.number,
              controller: phoneController,
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
            Container(
              width: 100,
              height: 100,
              child: IconButton(
                splashColor: null,
                icon: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.deepPurple,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: AlertDialog(
                            title: Text("Select Image "),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: _pickImageFromCamera,
                                      child: Row(
                                        children: [
                                          Icon(Icons.camera_alt),
                                          SizedBox(width: 20),
                                          Text("Camera ")
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
                                      onPressed: _pickImageFromGallery,
                                      child: Row(
                                        children: [
                                          Icon(Icons.upload_file),
                                          SizedBox(width: 20),
                                          Text("Gallery ")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: -5,
                      offset: Offset(
                        0,
                        5,
                      ),
                    )
                  ],
                  color: Colors.deepPurple[50],
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      width: 1, color: Colors.grey, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
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
            _buildSignupButton(),
            const SizedBox(height: 30),
            _buildLogin()
          ],
        ),
      ),
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
        onPressed: () {
          debugPrint("Entered Full Name  :  ${fullNameController.text}");
          debugPrint("Selected Class :  $_selectedOption");
          debugPrint("Selected Blood Group  :  $_selectedBloodGroup");
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
              onPressed: () {},
              child: const Text(
                "Login Here ",
                style: TextStyle(color: Colors.deepPurple),
              )),
        ],
      ),
    );
  }

  Widget _buildClassChoiceChip() {
    return Wrap(spacing: 5.0, children: <Widget>[
      _buildChoiceChip("FYMCA"),
      const SizedBox(width: 10),
      _buildChoiceChip("SYMCA")
    ]);
  }

  Widget _buildGenderChoiceChip() {
    return Wrap(spacing: 5.0, children: <Widget>[
      _buildChoiceChip("Male "),
      const SizedBox(width: 10),
      _buildChoiceChip("Female ")
    ]);
  }

  Widget _buildDivChoiceChip() {
    return Wrap(spacing: 5.0, children: <Widget>[
      _buildChoiceChip("A"),
      const SizedBox(width: 10),
      _buildChoiceChip("B")
    ]);
  }

  Widget _buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedOption == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedOption = selected ? label : null;
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
}
