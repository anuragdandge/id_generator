import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String _scannedQrResult = "Empty"; // Provide a default empty string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scan QR Code "),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple[100]),
                child: QrImageView(
                  data: _scannedQrResult,
                  backgroundColor: Colors.white,
                  size: 300,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: ElevatedButton(
                      style:
                          ButtonStyle(elevation: MaterialStatePropertyAll(10)),
                      onPressed: scanQRCode,
                      child: Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Text(
                          "Scan",
                          style: TextStyle(fontSize: 30),
                        ),
                      ))),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Scanned Res : \n $_scannedQrResult",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    String qrCodeRes;
    try {
      qrCodeRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      debugPrint(qrCodeRes);
    } on PlatformException {
      qrCodeRes = "Failed to get platform version ";
    }
    if (!mounted) return;
    setState(() {
      _scannedQrResult = qrCodeRes; // Assign the value directly
    });
  }
}
