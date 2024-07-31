import 'package:demoapp/screens/customerhome.dart';
import 'package:demoapp/screens/vendorhomescreen.dart';
import 'package:demoapp/screens/welcomescreen.dart';
import 'package:demoapp/server/checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  bool? iscustomer = Checker().isCustomer;
  String? customerid = Checker().customerid;
  String? vendorid = Checker().vendorid;
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    // Check for user login status
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (user == null && widget.iscustomer == null){
          openLogin();
        }
        else {
          openDashboard();
        }
      }  
    );
  
  }

  void openDashboard() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
          builder: (context) {
            return widget.iscustomer! ? CustomerHomePage(customer_id: widget.customerid!): VendorHomeScreen(vendorid: widget.vendorid!);
          }
        )
    );
  }

  void openLogin(){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
          builder: (context) {
            return const WelcomeScreen();
          }
        )
    );
  } 

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF693907),
      body: Center(
        child: Image(image: AssetImage("assets/images/splash.png"))
      ),
    );
  }
  
}