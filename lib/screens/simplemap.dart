import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng current = LatLng(25.1193, 55.3773);

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: current,
          zoom: 14.0, // Specify zoom level for better visibility
        ),
      ),
    );
  }
}
