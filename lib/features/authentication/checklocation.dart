import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CheckLocation extends StatefulWidget {
  const CheckLocation({super.key});

  @override
  State<CheckLocation> createState() => _CheckLocationState();
}

class _CheckLocationState extends State<CheckLocation> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String currentAddress = "";
  double distance = 0.0;

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      debugPrint("Service Disabled ");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoOrdinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];

      setState(() {
        currentAddress = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  _checkDistance() {
    double dis = Geolocator.distanceBetween(_currentLocation!.latitude,
        _currentLocation!.longitude, 18.5050084, 73.8123033);
    setState(() {
      distance = dis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Center(
              child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_currentLocation != null) {
                    debugPrint(" Location is Null");
                  } else {
                    _currentLocation = await _getCurrentLocation();
                    await _getAddressFromCoOrdinates();
                    _checkDistance();
                  }
                  debugPrint("${_currentLocation?.latitude}");
                  debugPrint("${_currentLocation?.longitude}");
                },
                child: Text("Get Location "),
              ),
              Text("Latitude :  ${_currentLocation?.latitude}"),
              Text("Longitude :  ${_currentLocation?.longitude}"),
              Text("Address :  $currentAddress"),
              Text("Distance  :  ${distance.toInt()} Meters "),
            ],
          )),
        ]),
      ),
    );
  }
}
