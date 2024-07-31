import 'package:demoapp/screens/customerhome.dart';
import 'package:demoapp/screens/vendorhomescreen.dart';
import 'package:demoapp/screens/welcomescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser;
  bool? isCustomer;
  String? customerid;
  String? vendorid;

  @override
  void initState() {
    super.initState();
    loadCustomerStatus();

    // Check for user login status
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (user == null && isCustomer == null) {
          openLogin();
        } else {
          openDashboard();
        }
      },
    );
  }

  Future<void> loadCustomerStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCustomer = prefs.getBool('isCustomer');
      customerid = prefs.getString('customerid');
      vendorid = prefs.getString('vendorid');
    });
  }

  void openDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return isCustomer!
              ? CustomerHomePage(customer_id: customerid!)
              : VendorHomeScreen(vendorid: vendorid!);
        },
      ),
    );
  }

  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const WelcomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF693907),
      body: Center(
        child: Image(image: AssetImage("assets/images/splash.png")),
      ),
    );
  }
}
