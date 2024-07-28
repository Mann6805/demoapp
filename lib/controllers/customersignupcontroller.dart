// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:demoapp/screens/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:demoapp/server/customerPost.dart';

class CustomerSignupController {

  static Future<Customerpost> createProfile(String mobile_no, String email, BuildContext context) async {
    Map<String, dynamic> data = {
        "name" : "Dummy",
        "mobile_no" : mobile_no,
        "email" : email
    };

    final url = Uri.parse("https://trashandler-api-s-1-259j.onrender.com/customerauth/");
    final response = await http.post(url, body: data);

    if (response.statusCode == 201){
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91"+mobile_no,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) {}, 
        verificationFailed: (FirebaseAuthException ex){
          SnackBar messagesnackbar = const SnackBar(
              backgroundColor: Colors.red,
              content: Text("This is invalid number.")
            );
            ScaffoldMessenger.of(context).showSnackBar(
              (messagesnackbar)
            ); 
        }, 
        codeSent: (String verificationid, int? resendtoken) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context){
                return Otpscreen(verificationid: verificationid,mobileno: mobile_no,);
            }
            )
          );
        }, 
        codeAutoRetrievalTimeout: (String verificationid) {}
      );
      return Customerpost.fromJson(json.decode(response.body));
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