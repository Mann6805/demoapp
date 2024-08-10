import 'dart:io';
import 'package:demoapp/screens/customerhome.dart';
import 'package:demoapp/server/checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Scrapdetailscontroller {
  static Future createProfile (
      String customerid, String description, File scrapphotos, double lat, double long, BuildContext context) async {
    final url =
        Uri.parse("https://trashandler-api-s-1-259j.onrender.com/pickup-request/");

    String? address = await Checker().getAddress();

    var request = http.MultipartRequest('POST', url);

    request.fields['latitude'] = lat as String;
    request.fields['longitude'] = long as String;
    request.fields['customer_id'] = customerid;
    request.fields['description'] = description;
    request.fields['landmark'] = "Ahmedabad";
    request.fields['timeslots'] = "morning";
    request.files.add(
        await http.MultipartFile.fromPath('photo', scrapphotos.path));

    try {
      final response = await request.send();

      final responseString = await response.stream.bytesToString();
      print("Status code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response: $responseString");

      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(
            builder: (context){
              return CustomerHomePage(customer_id: customerid, address: address!);
            }
          ), 
          (route){
            return false;
          }
        );
      } else {
        SnackBar messagesnackbar = SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error: $responseString"),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar((messagesnackbar));
      }
    } catch (e) {
      SnackBar messagesnackbar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("No Vendor Online"),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar((messagesnackbar));
      print("Exception: $e");
    }
  }
}
