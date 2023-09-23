import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String? _scannedQrResult;

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
      _scannedQrResult = qrCodeRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child:
                    ElevatedButton(onPressed: scanQRCode, child: Text("Scan"))),
            Text("Scanned Res : $_scannedQrResult"),
          ],
        ),
      ),
    );
  }
}
