import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_generator/pages/login.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StudentQR extends StatelessWidget {
  final String data;
  final String phone;
  final String name;
  final File file;

  const StudentQR(
      {Key? key,
      required this.data,
      required this.file,
      required this.name,
      required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("Welcome "),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 370,
                width: 370,
                decoration: BoxDecoration(color: Colors.deepPurple[100]),
                child: QrImageView(
                  data: data,
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            "$name",
                            // "Anurag Dandge",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                          Container(child: Text("$phone")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              TextButton(onPressed: () => Get.to(Login()), child: Text("Login"))
            ],
          ),
        ),
      )),
    );
  }
}
