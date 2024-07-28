// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:demoapp/screens/businessscreen.dart';
import 'package:demoapp/server/vendorpost.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VendorSignupController {

  static Future<Vendorpost> createProfile(String name, String mobile_no, String email, BuildContext context) async {
    Map<String, dynamic> data = {
        "name" : name,
        "mobile_no" : mobile_no,
        "email" : email
    };

    final url = Uri.parse("https://trashandler-api-s-1-259j.onrender.com/vendorauth/");
    final response = await http.post(url, body: data);

    if (response.statusCode == 201){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BusinessScreen(mobile_no: mobile_no);
          }
        )
      );
      return Vendorpost.fromJson(json.decode(response.body));
    }
    else{
      SnackBar messagesnackbar = const SnackBar(
        backgroundColor: Colors.red,
        content: Text("User already exists with this credentials.")
      );
      ScaffoldMessenger.of(context).showSnackBar(
        (messagesnackbar)
      );
      throw Exception();
    }


  }

}