import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  const String apiKey = 'AIzaSyCWcrSlvbBqsLExHz0Lo_N5wvEQ1ntee7Q';
  const String origin = '23.052288,72.597504';
  final List<String> waypoints = [
    '23.1543,72.6657', //PDEU
    '22.99982,72.65891', //Nirant
    '23.0019,72.6343', //Rabari colony
    '22.9998,72.6350', //wonder point
    '22.9926,72.6333', // ctm
    '23.0219,72.5971', //ram mandir
    '22.9972,72.6675', //vastral gam
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

    List<String> optimizedCoordinates = [];
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
