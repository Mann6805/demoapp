import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class optimizemaps {

  late String origin;
  List<String> optimizedCoordinates = [];
  
  optimizemaps(LatLng origin){
    this.origin = '${origin.latitude}, ${origin.longitude}';
    print(this.origin);
  }
  
  Future<void> getroutes() async {
    const String apiKey = 'AIzaSyCWcrSlvbBqsLExHz0Lo_N5wvEQ1ntee7Q';
    
    final List<String> waypoints = [
      '23.1287,72.5454', //Nirma
      '23.0984,72.5322', //Gota
      '23.0769,72.5249', // kargil
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

      print('Optimized route coordinates:');
      for (var coord in optimizedCoordinates) {
        print(coord);
      }
    } else {
      print('Failed to fetch directions: ${response.statusCode}');
    }
  }

}