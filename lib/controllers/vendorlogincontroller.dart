// ignore_for_file: depend_on_referenced_packages, camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'package:demoapp/screens/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VendorLoginController {

  static Future getdata(String mobile_no, BuildContext context) async {

    Map<String, dynamic> customerData = {
      "mobile_no" : mobile_no,
    };

    final url = Uri.parse("https://trashandler-api-s-1-259j.onrender.com/vendorsignin/");
    final response = await http.post(url, body: customerData);
    print(response.statusCode);
    if (response.statusCode == 200){
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
                return Otpscreen(verificationid: verificationid, mobileno: mobile_no,);
            }
            )
          );
        }, 
        codeAutoRetrievalTimeout: (String verificationid) {}
      ) ;
    }
    else{
      SnackBar messagesnackbar = const SnackBar(
        backgroundColor: Colors.red,
        content: Text("There's no such user with this credentials.")
      );
      ScaffoldMessenger.of(context).showSnackBar(
        (messagesnackbar)
      );      
      throw Exception();
    }

  }

}