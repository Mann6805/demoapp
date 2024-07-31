import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LatLng _currentPosition;
  late GoogleMapController _mapController;

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
    print(position);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    // Move the map camera to the current location.
    if (_mapController != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentPosition,
            zoom: 14.0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location'),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition ?? LatLng(0, 0),
                zoom: 14.0,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                // Move the map camera to the current location once the map is created.
                if (_currentPosition != null) {
                  _mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: _currentPosition,
                        zoom: 14.0,
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
