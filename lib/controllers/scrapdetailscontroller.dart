import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Scrapdetailscontroller {
  static Future createProfile(
      String customerid, String description, File scrapphotos, BuildContext context) async {
    final url =
        Uri.parse("https://trashandler-api-s-1-259j.onrender.com/upload/");

    var request = http.MultipartRequest('POST', url);

    request.fields['customer_id'] = customerid;
    request.fields['description'] = description;
    request.fields['landmark'] = "Ahmedabad";
    request.fields['time_slot'] = "morning";
    request.files.add(
        await http.MultipartFile.fromPath('photo', scrapphotos.path));

    try {
      final response = await request.send();

      final responseString = await response.stream.bytesToString();
      print("Status code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Response: $responseString");

      if (response.statusCode == 201) {
        SnackBar messagesnackbar = const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Done Uploading"),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar((messagesnackbar));
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
        content: Text("Exception: $e"),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar((messagesnackbar));
      print("Exception: $e");
    }
  }
}
