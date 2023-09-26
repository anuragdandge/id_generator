import 'package:flutter/material.dart';

class SignUpWidgets {
  Widget alertDialogForNoConnectivity() {
    return const AlertDialog(
      title: Text("No Internet Connectivity !!! "),
    );
  }

  Widget buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
}
