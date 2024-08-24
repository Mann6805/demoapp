import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Routemap extends StatefulWidget {
  const Routemap({super.key});

  @override
  State<Routemap> createState() => _RoutemapState();
}

class _RoutemapState extends State<Routemap> {

  late LatLng _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }
  
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request users to enable them.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Permissions are granted, get the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 13),
        markers: {
          Marker(
            markerId: const MarkerId('Vendor current location'),
            icon: BitmapDescriptor.defaultMarker,
            position: _currentPosition,
          )
        },
      ),
    );
  }
}