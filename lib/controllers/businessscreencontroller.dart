import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demoapp/screens/otpscreen.dart';
import 'package:http/http.dart' as http;

class BusinessScreenController{

  static Future createProfile(String vendor_id, String mobile_no, String business_name, String business_gst, File panfile, File businessfile, BuildContext context) async {

    final url = Uri.parse("https://trashandler-api-s-1-259j.onrender.com/vendor-complete-profile/");

    var request = http.MultipartRequest('POST', url);

    request.fields['vendor_id'] = vendor_id;
    request.fields['gstin_number'] = business_gst;
    request.fields['business_name'] = business_name;
    request.files.add(await http.MultipartFile.fromPath('pan_card', panfile.path));
    request.files.add(await http.MultipartFile.fromPath('business_photos', businessfile.path));

    final response = await request.send();

    print("${await response.stream.bytesToString()}");

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
      ScaffoldMessenger.of(context).showSnackBar(
        (messagesnackbar)
      );
    }
  }
}