import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demoapp/screens/otpscreen.dart';
import 'package:http/http.dart' as http;

class BusinessScreenController{
  static BuildContext? get context => null;


  static Future createProfile(String mobile_no, String business_name, String business_gst, var panimg, var businessimg) async {

    Map<String, dynamic> data = {
        "business_gst" : business_gst,
        "business_name" : business_name,
        "panimg" : panimg,
        "businessimg" : businessimg
    };

    final url = Uri.parse("https://trashandler-api-s-1-259j.onrender.com/vendorauth/");
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
            ScaffoldMessenger.of(context!).showSnackBar(
              (messagesnackbar)
            ); 
        },
        codeSent: (String verificationid, int? resendtoken) {
          Navigator.pushReplacement(
            context!,
            MaterialPageRoute(
              builder: (context){
                return Otpscreen(verificationid: verificationid,mobileno: mobile_no,iscustomer: false,);
              }
            )
          );
        }, 
        codeAutoRetrievalTimeout: (String verificationid) {} 
      ); 
    }
    else{
      SnackBar messagesnackbar = const SnackBar(
        backgroundColor: Colors.red,
        content: Text("There some error in your information.")
      );
      ScaffoldMessenger.of(context!).showSnackBar(
        (messagesnackbar)
      );
      throw Exception();
    }

  }
}