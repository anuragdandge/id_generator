import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatelessWidget {
  late String data = "-";
  GenerateQR({super.key, required String data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.qr_code_2,
            size: 40,
          ),
          title: const Text(
            " Generated QR Code ",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: QrImageView(
                data: data,
                backgroundColor: const Color.fromARGB(255, 193, 132, 255),
              ),
            ),
            Text(" scanned : $data")
          ],
        ));
  }
}
