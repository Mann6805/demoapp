import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Example coordinates (San Francisco)
          zoom: 10,
        ),
        markers: _createMarkers(),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(37.7749, -122.4194), // Example coordinates
        infoWindow: InfoWindow(
          title: 'San Francisco',
          snippet: 'A cool place to visit!',
        ),
      ),
    };
  }
}
