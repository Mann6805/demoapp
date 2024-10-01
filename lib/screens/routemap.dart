import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Routemap extends StatefulWidget {
  const Routemap({super.key});

  @override
  State<Routemap> createState() => _RoutemapState();
}

class _RoutemapState extends State<Routemap> {
  LatLng? _currentPosition;
  LatLng? destination;
  List<String> optimizedCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> markers = {};
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    initializeMapAndTrackLocation();
  }

  Future<void> initializeMapAndTrackLocation() async {
    await _determinePosition();

    if (_currentPosition != null) {
      OptimizedMaps maps = OptimizedMaps(_currentPosition!);
      await maps.getRoutes();
      print("maps: ${maps.optimizedCoordinates}");
      optimizedCoordinates = maps.optimizedCoordinates;
    }
    await initializeMap();
    trackLiveLocation();
  }

  Future<void> initializeMap() async {
    // Set the destination as the last waypoint in the list
    if (optimizedCoordinates.isNotEmpty) {
      destination = _parseLatLng(optimizedCoordinates.last);
      print(destination);
    }

    // Add markers for waypoints and destination
    setState(() {
      markers.clear();

      // Add marker for current location
      if (_currentPosition != null) {
        markers.add(Marker(
          markerId: const MarkerId('Current Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: _currentPosition!,
        ));
      }

      // Add markers for each waypoint in optimizedCoordinates
      for (int i = 0; i < optimizedCoordinates.length; i++) {
        final coord = optimizedCoordinates[i];
        final latLng = _parseLatLng(coord);
        if (latLng != null) {
          markers.add(Marker(
            markerId: MarkerId('Waypoint$i'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),
            position: latLng,
          ));
        }
      }

      // Add marker for destination
      if (destination != null) {
        markers.add(Marker(
          markerId: const MarkerId('Destination'),
          icon: BitmapDescriptor.defaultMarker,
          position: destination!,
        ));
      }
    });

    // Update route with the initial coordinates
    await updateRoute();
  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyCWcrSlvbBqsLExHz0Lo_N5wvEQ1ntee7Q',
      request: PolylineRequest(
        origin: PointLatLng(
            _currentPosition!.latitude, _currentPosition!.longitude),
        destination: PointLatLng(destination!.latitude, destination!.longitude),
        mode: TravelMode.driving,
        wayPoints: optimizedCoordinates
            .map((coord) {
              final latLng = _parseLatLng(coord);
              return latLng != null
                  ? PolylineWayPoint(
                      location: "${latLng.latitude}, ${latLng.longitude}")
                  : null;
            })
            .whereType<PolylineWayPoint>()
            .toList(),
      ),
    );

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
    }
  }

  Future<void> generatePolyline(List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    // Clear existing polylines
    setState(() {
      polylines.clear();
    });

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<void> updateRoute() async {
    if (_currentPosition != null && optimizedCoordinates.isNotEmpty) {
      final coordinates = await fetchPolylinePoints();
      generatePolyline(coordinates);
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void trackLiveLocation() {
    positionStream =
        Geolocator.getPositionStream().listen((Position position) async {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        markers.removeWhere(
            (marker) => marker.markerId.value == 'Current Location');
        markers.add(Marker(
          markerId: const MarkerId('Current Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: _currentPosition!,
        ));
      });

      // Check if the user is near any waypoint
      for (int i = 0; i < optimizedCoordinates.length; i++) {
        final coord = optimizedCoordinates[i];
        final waypoint = _parseLatLng(coord);
        if (waypoint != null && _isNearWaypoint(_currentPosition!, waypoint)) {
          setState(() {
            markers
                .removeWhere((marker) => marker.markerId.value == 'Waypoint$i');
          });
        }
      }

      // Fetch and update polyline for new location
      final coordinates = await fetchPolylinePoints();
      generatePolyline(coordinates);
    });
  }

  bool _isNearWaypoint(LatLng currentPosition, LatLng waypoint) {
    const double radius = 50.0; // Radius in meters to consider as "near"
    final distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      waypoint.latitude,
      waypoint.longitude,
    );
    return distance < radius;
  }

  LatLng? _parseLatLng(String coord) {
    final parts = coord.split(',');
    if (parts.length == 2) {
      final lat = double.tryParse(parts[0]);
      final lng = double.tryParse(parts[1]);
      if (lat != null && lng != null) {
        print("Latitude: $lat, Longitude: $lng");
        return LatLng(lat, lng);
      }
    }
    return null;
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.amber[900],
              ),
            )
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _currentPosition!, zoom: 13),
              markers: markers,
              polylines: Set<Polyline>.of(polylines.values),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}

class OptimizedMaps {
  late String origin;
  List<String> optimizedCoordinates = [];

  OptimizedMaps(LatLng origin) {
    this.origin = '${origin.latitude}, ${origin.longitude}';
    print(this.origin);
  }

  Future<void> getRoutes() async {
    const String apiKey = 'AIzaSyCWcrSlvbBqsLExHz0Lo_N5wvEQ1ntee7Q';

    final List<String> waypoints = [
      '23.1287,72.5454', //Nirma
      '23.0984,72.5322', //Gota
      '23.0769,72.5249', // Kargil
    ];

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$origin&waypoints=optimize:true|${waypoints.join('|')}&key=$apiKey';

    // Fetch the response
    final response = await http.get(Uri.parse(url));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body
      final data = json.decode(response.body);

      // Extract the optimized waypoints order
      List<int> waypointOrder =
          List<int>.from(data['routes'][0]['waypoint_order']);

      // Extract the optimized route coordinates
      List<dynamic> legs = data['routes'][0]['legs'];

      for (var leg in legs) {
        String startLocation =
            '${leg['start_location']['lat']},${leg['start_location']['lng']}';
        optimizedCoordinates.add(startLocation);
      }

      // Add the final destination as well
      String endLocation =
          '${legs.last['end_location']['lat']},${legs.last['end_location']['lng']}';
      optimizedCoordinates.add(endLocation);

      print('Optimized Route:');
      print(optimizedCoordinates);
    } else {
      print('Request failed with status: ${response.body}');
    }
  }
}
