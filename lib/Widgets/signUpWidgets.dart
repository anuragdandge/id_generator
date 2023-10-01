import 'package:flutter/material.dart';

class SignUpWidgets {
  Widget alertDialogForNoConnectivity() {
    return const AlertDialog(
      title: Text("No Internet Connectivity !!! "),
    );
  }

  static Widget buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  static Widget buildTop(Size mediaSize) {
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
}
